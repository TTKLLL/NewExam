using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ExamManage_VIewPaper : BasePage
{
    public static string sId;
    public static Student studnet;
    public static string theExamId;

    public static string examName;
    public static Exam exam;
    public static Paper paper;
    public static List<Sort> sorts;

    public ExamBLL examBll = new ExamBLL();
    public StuExamBLL stuExamBll = new StuExamBLL();

    public List<StuExamTopic> topics;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["sId"] != null && Request.QueryString["theExamId"] != null)
        {
            sId = Request.QueryString["sId"].ToString();
            theExamId = Request.QueryString["theExamId"].ToString();
        }

        BindData();
    }

    public void BindData()
    {
        DataClassesDataContext db = new DataClassesDataContext();
        exam = stuExamBll.GetExamByThExamIdBySId(theExamId, sId);
        examName = examBll.GetExamName(exam);
        studnet = db.Student.First(t => t.StudentId == sId);

        if (exam == null)
        {
            alert("获取学生试卷出错", "ExamList.aspx");
            return;
        }
        sorts = stuExamBll.GetExamTopicBySort(sId, exam.ExamId.ToString());
    }
}