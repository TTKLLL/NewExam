using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ExamManage_VIewPaper : BasePage
{
    public static string examId;
    public static Paper paper;

    public TopicBLL topicBll = new TopicBLL();
    public static int totalPage;
    public static int pageNumber = 1;
    public static int count;
    public static string para = "";
    public static List<PracticalTopic> topics = new List<PracticalTopic>();

    public static string examName;
    public  ExamBLL examBll = new ExamBLL();

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

        BindTopic();
    }

    public void BindTopic()
    {
        DataClassesDataContext db = new DataClassesDataContext();
       

        Exam exam = db.Exam.First(t => t.ExamId == decimal.Parse(examId));
        theExamId = exam.TheExamId.ToString();
        if (exam == null)
        {
            alert("获取试卷信息失败！", "AllExam.aspx");
        }

        examName = examBll.GetExamName(exam);
        topics = examBll.GetPracTopicByExamId(ref pageNumber, ref totalPage, ref count, examId);
    }
} 