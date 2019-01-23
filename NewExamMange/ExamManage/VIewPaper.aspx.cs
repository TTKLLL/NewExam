using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ExamManage_VIewPaper : BasePage
{
    public static string examId;
    public static int pageNumber;
    public static int totalPage;
    public static Paper paper;
    public static List<Sort> sorts;
    public static string examName;
    public  ExamBLL examBll = new ExamBLL();
    public List<Topic> topics;
    public string theExamId;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["examId"] != null)
        {
            examId = Request.QueryString["examId"].ToString();
        }
        if (Request.QueryString["pageNumber"] != null)
        {
            pageNumber = int.Parse(Request.QueryString["pageNumber"]);
        }
        BindData();
    }

    public void BindData()
    {
        DataClassesDataContext db = new DataClassesDataContext();

        Exam exam = db.Exam.First(t => t.ExamId == decimal.Parse(examId));
        theExamId = exam.TheExamId.ToString();
        if (exam == null)
        {
            alert("获取试卷信息失败！", "AllExam.aspx");
        }

        examName = examBll.GetExamName(exam);

        paper = examBll.GetPaperByExamIdByPage(examId, ref pageNumber, ref totalPage);

        if (paper != null)
        {
            sorts = examBll.GetPaperSorts(paper.PaperId.ToString());
        }
        else
        {
            alert("获取试卷信息失败！", "AllExam.aspx");
        }

    }
} 