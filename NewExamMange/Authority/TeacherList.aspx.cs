using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Authority_TeacherList : BasePage
{

    DataClassesDataContext db = new DataClassesDataContext();
    string Query = "";
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack == true) {

            //if (Session["uId"] == null || Session["uId"].ToString() == string.Empty)
            //{

            //    ClientScript.RegisterClientScriptBlock(this.GetType(),"error","<script>alert('登录过期，请重新登录！');window.parent.location='../Login.aspx'</script>");
            //    return;
            //}

            if (Request.QueryString["Query"] != null) {
                Query = Request.QueryString["Query"].ToString();
       
            }

            tb_Query.Text = Query;
            BindData();
          
        }
   }

    public void BindData() {
      
        var resultTea = (from p in db.Teacher
                         where (p.TName.Contains(Query)||p.TId.Contains(Query)) && (p.IsAdmin==1 && p.TeacherState==1)
                         select p).ToList();
        //   数据源
        PagedDataSource Pgds = new PagedDataSource();
        //        
        Pgds.DataSource = resultTea;
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
            lnkPrev.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage - 1) + "&Query=" + Query;
        }
        //        End If
        //   如果不是最后一页，通过参数Page设置下一页为当前页+1，否则不显示连接
        if (!Pgds.IsLastPage)
        {
            //    Request.CurrentExecutionFilePath为当前请求虚拟路径
            lnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage + 1) + "&Query=" + Query;
        }
        //   模板绑定数据源  
        rp_TeaInfo.DataSource = Pgds;
        rp_TeaInfo.DataBind();
    
    
    
    
    }
    protected void bt_Skip_Click(object sender, EventArgs e)
    {

        Query = tb_Query.Text;
        Response.Redirect("TeacherList.aspx?Query="+Query+"&Page="+lblCurrentPage.Text);
    }
    protected void bt_Query_Click(object sender, EventArgs e)
    {
        Query = tb_Query.Text;
        Response.Redirect("TeacherList.aspx?Query="+Query+"&Page=1"); 
    }
}