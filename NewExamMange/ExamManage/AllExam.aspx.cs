using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ExamManage_AllExam : BasePage
{
    public static List<TheExam> theExams = new List<TheExam>();
    public static int pageNumber = 1;
    public static int totalPage = 1 ;
    public static int count = 1 ;
    ExamBLL examBll = new ExamBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["pageNumber"] != null)
        {
  
            pageNumber = int.Parse(Request.QueryString["pageNumber"]);
        }
           
        else
        {
            if (Request.Cookies["ExamType"] == null)
            {
                Response.Write("<script>window.parent.location.href = '../LogIn.aspx'</script>");
            }
            else
            {
                string examType = Request.Cookies["ExamType"].Value;
                theExams = examBll.GetTheExamByPage(ref pageNumber, ref totalPage, ref count, examType);

            }
            

        }
       
    }

    
}