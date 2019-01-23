using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeacherManage_UnusualManage : BasePage
{
    ExamBLL exambll = new ExamBLL();
    public List<MyStuExam> stus = new List<MyStuExam>();
    public Exam nowExam;
    public string examTitle;
    public static string tId;

    public static int pageNumber;
    public static int totalPage;
    public static int count;


    public static string para = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        nowExam = exambll.GetNowExam();
        examTitle = exambll.GetExamName(nowExam);
        tId = Request.Cookies["uId"].Value.ToString();

        if (Request.QueryString["pageNumber"] != null)
        {
            pageNumber = int.Parse(Request.QueryString["pageNumber"].ToString());

            para = Request.QueryString["para"];
        }
        if (Request.Form["StudentId"] != null)
        {
            if (Request.Form["flag"] == "0")
            {
                RestStu(); //重置考试状态
            }
            if (Request.Form["flag"] == "1")
            {
                SetStuCheat(); //作弊
            }
        }
        Bind();
    }

    public void Bind()
    {
        if (nowExam == null)
        {

            alert("暂无正在进行的考试", "/Desktop.aspx");
        }
        else
        {
            stus = exambll.ExamTeacherGetStuExamByTheExamId(tId, ref pageNumber, ref totalPage, ref count,
                nowExam.ExamId.ToString(), para);
        }
    }

    public void RestStu()
    {
        Array sIds = Request.Form["StudentId"].ToString().Split(',');
        for (int i = 0; i < sIds.Length; i++)
        {
            if (exambll.RestStuExam(sIds.GetValue(i).ToString()) <= 0)
            {
                errAlert("重置学号为 " + sIds.GetValue(i).ToString() + "的考生失败");
                break;
            }
        }
        SuAlert("重置 " + sIds.Length.ToString() + " 名考生成功");
    }

    public void SetStuCheat()
    {
        Array sIds = Request.Form["StudentId"].ToString().Split(',');
        for (int i = 0; i < sIds.Length; i++)
        {
            if (exambll.StuCheat(sIds.GetValue(i).ToString(), nowExam.ExamId.ToString()) <= 0)
            {
                errAlert("设置学号为 " + sIds.GetValue(i).ToString() + "的考生作弊失败");
                break;
            }
        }
        SuAlert("设置 " + sIds.Length.ToString() + " 名考生作弊成功");
    }



}