using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GradeManger_GradeInfoManger : BasePage
{

    DataClassesDataContext db = new DataClassesDataContext();
    string Query = "";
    public static string theExam;

    public static int TheExamId;
    public static string TheExamName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack == true)
        {
           
            if (Request.QueryString["Query"] != null)
            {
                Query = Request.QueryString["Query"].ToString();

            }

            if (Request.QueryString["TheExamId"] != null)
            {

                TheExamId = Int32.Parse(Request.QueryString["TheExamId"].ToString());
            }
            else
            {
                errAlert("获取考试信息出错！");
                Response.Redirect("ExamList.aspx");
            }

            tb_Query.Text = Query;
            BindData();

        }
    }


    private void BindData()
    {
        TheExamName = new ExamBLL().GetThExamInfoByTheId(TheExamId.ToString()).TheExamName;
        //var SchRes = (from p in db.proc_GetBkgxNowYear()
        //              select p).ToList().First();
        //List<StuGradeInf> ExamRes;
        //ExamRes = (from p in db.StuGradeInf()
        //           where p.zkzh != null && p.TestSubjectNo.ToString().Contains(TestSubjectNo) && p.subNum.Contains(subNum)
        //           orderby p.TestSubjectNo, p.proOrder
        //           select p).ToList();

        //查询当前次的所有学生的成绩
        var AllStuInTheExamGrade = (from p in db.Student
                                    join b in db.StuExam on p.StudentId equals b.StudentId
                                    join c in db.Paper on b.PaperId equals c.PaperId
                                    join d in db.Exam on c.ExamId equals d.ExamId
                                    join e in db.TheExam on d.TheExamId equals e.TheExamId
                                    where (e.TheExamId == TheExamId) && (p.StudentId.Contains(Query) || p.StudentName.Contains(Query) || p.Class.Contains(Query))
                                    orderby p.Class, b.Score descending
                                    select new
                                    {
                                        stuno = p.StudentId,
                                        stname = p.StudentName,
                                        stuclass = p.Class,
                                        stuscore = b.Score,
                                        TheExamName = e.TheExamName,
                                        beginTIme = b.BeginExamTIme,
                                        endTime = b.ReplyEndTime
                                    }).ToList();

        //   数据源
        PagedDataSource Pgds = new PagedDataSource();
        //        
        Pgds.DataSource = AllStuInTheExamGrade;
        //        设置允许分页
        Pgds.AllowPaging = true;
        //        每页显示为15行
        Pgds.PageSize = 15;
        //        显示总共页数
        //
        lblTotalPage.Text = Pgds.PageCount.ToString();
        //        当前页
        int CurrentPage;
        //        请求页码为不为null设置当前页，否则为第一页
        if (Request.QueryString["Page"] != null)
        {
            CurrentPage = Convert.ToInt32(Request.QueryString["Page"]);
        }

        else
        {
            CurrentPage = 1;
        }
        //   当前页所引为页码-1
        Pgds.CurrentPageIndex = CurrentPage - 1;
        //   显示当前页码
        lblCurrentPage.Text = CurrentPage.ToString();
        //   如果不是第一页，通过参数Page设置上一页为当前页-1，否则不显示连接
        if (!Pgds.IsFirstPage)
        {
            //            Request.CurrentExecutionFilePath为当前请求虚拟路径
            lnkPrev.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage - 1) + "&Query=" + Query + "&TheExamId=" + TheExamId;
        }
        //        End If
        //   如果不是最后一页，通过参数Page设置下一页为当前页+1，否则不显示连接
        if (!Pgds.IsLastPage)
        {
            //    Request.CurrentExecutionFilePath为当前请求虚拟路径
            lnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage + 1) + "&Query=" + Query + "&TheExamId=" + TheExamId;
        }
        //   模板绑定数据源  
        rp_GradeInfo.DataSource = Pgds;
        rp_GradeInfo.DataBind();

    }



    protected void bt_Export_Click(object sender, EventArgs e)
    {
        string Query = tb_Query.Text;
        int index = 0;
        //查询当前次的所有学生的成绩
        var StuGradeRes = (from p in db.Student
                           join b in db.StuExam on p.StudentId equals b.StudentId
                           join c in db.Paper on b.PaperId equals c.PaperId
                           join d in db.Exam on c.ExamId equals d.ExamId
                           join f in db.TheExam on d.TheExamId equals f.TheExamId
                           where (f.TheExamId == TheExamId) && (p.StudentId.Contains(Query) || p.StudentName.Contains(Query) || p.Class.Contains(Query))
                           orderby p.Class descending, p.StudentId descending
                           select new
                           {
                               stuno = p.StudentId,
                               stname = p.StudentName,
                               stuclass = p.Class,
                               stuscore = b.Score,
                               TheExamName = f.TheExamName
                           }).ToList();


        string TheExname = db.TheExam.First(t => t.TheExamId == TheExamId).TheExamName.ToString();


        string FileAndTitleName =   TheExname + " 成绩表";

        string filePath = Server.MapPath("../ExcelTemplet/Temp/" + Guid.NewGuid().ToString() + ".xls");
        File.Copy(Server.MapPath("../ExcelTemplet/StudentGradeInfo.xls"), filePath);
        // 使用OleDb驱动程序连接到副本
        OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
        using (conn)
        {
            conn.Open();

            // 增加记录
            foreach (var item in StuGradeRes)
            {
                index = index + 1;
                StringBuilder sql = new StringBuilder();
                sql.Append("INSERT INTO [Sheet1$]([序号],[学号],[姓名],[班级],[成绩]) VALUES('").Append(index).Append("','").Append(item.stuno).Append("','").Append(item.stname).Append("','").Append(item.stuclass).Append("','").Append(item.stuscore).Append("')");
                OleDbCommand cmd = new OleDbCommand(sql.ToString(), conn);
                cmd.ExecuteNonQuery();
            }
        }
        // 输出副本的二进制字节流
        Response.ContentType = "application/ms-excel";
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + FileAndTitleName + ".xls");
        Response.BinaryWrite(File.ReadAllBytes(filePath));
        // 删除副本  
        File.Delete(filePath);

    }

    protected void bt_Query_Click(object sender, EventArgs e)
    {
        Query = tb_Query.Text;
        Response.Redirect("GradeInfoManger.aspx?Query=" + Query + "&Page=1");
    }
    protected void bt_Skip_Click(object sender, EventArgs e)
    {
        Query = tb_Query.Text;
        Response.Redirect("GradeInfoManger.aspx?Query=" + Query + "&Page=" + lblCurrentPage.Text + "&TheExamId=" + TheExamId);
    }

    protected void rp_GradeInfo_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) 
        {
            Label sIdLabel = (Label)e.Item.FindControl("sId");
          

            Label _sIdLabel = (Label)e.Item.FindControl("Label1");
           

            sIdLabel.Text = _sIdLabel.Text;



        }
    }
}