using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Exam_ExamePeriodManage : BasePage
{

    public static TheExam theExam;
    public static List<Exam> exams = new List<Exam>();
   public static ExamBLL examBll = new ExamBLL();
    DataClassesDataContext db = new DataClassesDataContext();
    public static int examFlag = examBll.GetChoseExamType();

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request.QueryString["theExamId"] != null)
        {
            string theExamId = Request.QueryString["theExamId"].ToString();
            theExam = db.TheExam.First(t => t.TheExamId == decimal.Parse(theExamId));
            exams = examBll.GetExamByTheExamId(Request.QueryString["theExamId"]);
        }
    }
}