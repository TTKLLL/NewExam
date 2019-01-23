using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeacherManage_ExamTeacher : BasePage
{
    DataClassesDataContext db = new DataClassesDataContext();
    string Query = "";
    TeacherBLL teacherBll = new TeacherBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack == true)
        {
            //SESSION

            if (Request.QueryString["Query"] == null)
            {
                Query = "";
            }
            else
            {
                Query = Request.QueryString["Query"].ToString();
            }
            tb_Query.Text = Query;
            BindData();
        }


    }

    public void BindData()
    {
        var TeacherInfo = (from p in db.Teacher
                           where p.TName.Contains(Query) || p.TId.Contains(Query)
                           select p).Where(t => t.TeacherState == (int)TeacherBLL.TeacherState.OnWork)
                           .OrderByDescending(t => t.isExamTeacher).ToList();
        if (TeacherInfo.Count() <= 0)
        {
            //Panel1.Visible = false;
            //Panel2.Visible = true;
            //return;
        }

        ////数据源
        //PagedDataSource Pgds = new PagedDataSource();
        ////
        //Pgds.DataSource = TeacherInfo;
        ////允许分页
        //Pgds.AllowPaging = true;
        ////每页显示为15页
        //Pgds.PageSize = 15;
        ////显示总的页数
        ////
        //lblTotalPage.Text = Pgds.PageCount.ToString();
        ////当前页
        //int CurrentPage;
        ////请求页码不为null设置当前页，否则为第一页
        //if (Request.QueryString["Page"] != null)
        //{
        //    CurrentPage = Convert.ToInt32(Request.QueryString["Page"]);

        //}
        //else
        //{
        //    CurrentPage = 1;
        //}
        ////当前页所为页码-1
        //Pgds.CurrentPageIndex = CurrentPage - 1;
        ////显示当前页码
        //lblCurrentPage.Text = CurrentPage.ToString();
        ////如何不是第一页，通过参数Page设置上一页为当前页-1，否则不显示先连接

        //if (!Pgds.IsFirstPage)
        //{
        //    lnkPrev.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage - 1) + "&Query=" + Query;
        //}
        //if (!Pgds.IsFirstPage)
        //{
        //    lnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage + 1) + "&Query=" + Query;
        //}
        ////模板绑定数据源
        //rp_TeacherInfo.DataSource = Pgds;
        rp_TeacherInfo.DataSource = TeacherInfo;
        rp_TeacherInfo.DataBind();
    }

    public int BindTitle(object TeacherState)
    {

        if (Int32.Parse(TeacherState.ToString()) == 1)
        {

            Context.Response.Write("hhhhhhhhhh");
        }
        return 0;
    }

    protected void bt_Query_Click(object sender, EventArgs e)
    {
        Query = tb_Query.Text.Trim();
        Response.Redirect("ExamTeacher.aspx?Query=" + Query);
    }


    public string GetAuditStatus(int flag)
    {
        // Teacher teacher = db.Teacher.First(t => t.TId == tId);

        if (flag == (int)TeacherBLL.IsAdmin.Admin)
            return "管理员";
        else if (flag == (int)TeacherBLL.IsAdmin.ExamTeacher)
            return "监考教师";
        else
            return "";
    }



    protected void rp_TeacherInfo_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //    CheckBox ck = (CheckBox)e.Item.FindControl("ck2");
            //    Label teacherState = (Label)e.Item.FindControl("Label2");
            //    if (teacherState.Text.ToString() == "1")
            //        ck.Checked = true;

            Label Label1 = (Label)e.Item.FindControl("Label1");
            CheckBox isExamTeacher = (CheckBox)e.Item.FindControl("isExamTeacher");
            if (Label1.Text == "1")
            {
                isExamTeacher.Checked = true;
            }



        }
        //if (e.Item.ItemType == ListItemType.AlternatingItem)
        //{
        //    CheckBox ck = (CheckBox)e.Item.FindControl("ck1");
        //    Label teacherState = (Label)e.Item.FindControl("Label1");
        //    if (teacherState.Text.ToString() == "1")
        //        ck.Checked = true;
        //}



    }

    public void alert(string str)
    {

        ScriptManager.RegisterClientScriptBlock(UpdatePanel1, this.GetType(), "click", "alert('" + str + "')", true);
    }

    protected void ck2_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ck = (CheckBox)sender;
        bool isCheck = ck.Checked;

        //获取当前行
        RepeaterItem item = (RepeaterItem)ck.NamingContainer;
        Label idLabel = (Label)item.FindControl("Label3");
        if (teacherBll.ChangeTeacherState(idLabel.Text.Trim()) == 1)
            SuAlert("修改成功");
        else
        {
            ck.Checked = isCheck;
            errAlert("修改失败");
        }
    }


    //修改管理员是否为监考老师

    protected void isExamTeacher_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ck = (CheckBox)sender;
        bool isCheck = ck.Checked;

        RepeaterItem item = (RepeaterItem)ck.NamingContainer;
        Label idLabel = (Label)item.FindControl("Label3");
        if (teacherBll.ChangeAdminExamTeacher(idLabel.Text) > 0)
        {
           // SuAlert("修改成功");
            BindData();
        }
        else
        {
            errAlert("修改失败");
            ck.Checked = isCheck;
        }
    }




}
