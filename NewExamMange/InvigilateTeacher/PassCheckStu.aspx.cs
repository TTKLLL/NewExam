using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InvigilateTeacher_PassCheckStu : BasePage
{
    public List<Student> passCheckStu; //待登记
    public Exam nowExam = new Exam(); //正在进行的考试
    public static string tId;

    public static int pageNumber;
    public static int totalPage;
    public static int count;
    public static string para = "";

    public ExamBLL examBll = new ExamBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        tId = Request.Cookies["uId"].Value.ToString();

        nowExam = examBll.GetNowExam();

        //判断有无即将开始的考试
        if (nowExam == null)
        {
            alert("暂无即将开始的考试", "/Desktop.aspx");
            return;
        }


        //判断老师是否已登记考场
        if (examBll.IsExamHasInvigilate(nowExam.ExamId.ToString(), tId) == false)
        {
            alert("请先登记考场", "SingInExamRoom.aspx");
        }


        //获取参数
       if (Request.QueryString["pageNumber"] != null)
        {
            pageNumber = int.Parse(Request.QueryString["pageNumber"].ToString());
        }
        if (Request.QueryString["para"] != null)
        {

            para = Request.QueryString["para"].ToString();

        }
        if (Request.QueryString["sIds"] != null)
        {
            Array sIds = Request.QueryString["sIds"].ToString().Split(',');

            int flag = 1;
            for (int i = 0; i < sIds.Length; i++)
            {
                
                if (examBll.ChangeStuExamState(sIds.GetValue(i).ToString(),tId, nowExam.ExamId.ToString(),
                     (int)StudentBLL.StudentExamState.Default) <= 0)
                {
                    errAlert("学号为" + sIds.GetValue(i).ToString() + "的考生取消登记失败");
                    flag = 0;
                    BindDate();
                    break;
                }
            }
            if (flag == 1)
                SuAlert("成功取消登记 " + sIds.Length.ToString() + " 名考生");
        }


        BindDate();

    }

    public void BindDate()
    {
        passCheckStu = examBll.GetPassCheckStu(nowExam.ExamId.ToString(),tId,
            ref pageNumber, ref totalPage, ref count, para);
    }
}