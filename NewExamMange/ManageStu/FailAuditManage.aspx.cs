using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AuditManage_FailAuditManage : BasePage
{
    StudentBLL studentBll = new StudentBLL();
    public static List<Student> stus = new List<Student>();
    public static int pageNumber = 1; //当前页码
    public static int totalPage = 0;  //总页数
    public static string para = ""; //查询条件

    public static int count;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["pageNumber"] != null)
            {
                pageNumber = int.Parse(Request.QueryString["pageNumber"]);
                para = Request.QueryString["para"].Trim().ToString();
            }

            BindData();
        }


    }

    public void BindData()
    {
        stus = studentBll.GetStudentByPage(ref pageNumber, ref totalPage, ref count,
            (int)StudentBLL.StudentState.FailAudit, para);
    }
}