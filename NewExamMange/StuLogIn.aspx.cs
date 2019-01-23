using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class LogIn : System.Web.UI.Page
{
    private DataClassesDataContext db = new DataClassesDataContext();
    public static string sId;

    public static string beginTime;

    //public static ExamBLL examBll = new ExamBLL();
    //public static StuExamBLL stuExamBll = new StuExamBLL();

    public Exam nowExam;//当前考试
    public string examName; //考试名称

    public void SuAlert(string str)
    {
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "<script>SuAlert('" + str + "');</script>");
    }

    public void errAlert(string str)
    {
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "<script>errAlert('" + str + "');</script>");
    }



    public void infoAlert(string str)
    {
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "<script>infoAlert('" + str + "');</script>");
    }


    public void alert(string str, string link)
    {
        Response.Write("<script>alert('" + str + "');window.location.href='" + link + "'</script>");
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        bindInfo();
        if (Request.Form["sId"] != null)
        {
            sId = Request.Form["sId"].ToString().Trim();
            ValidStu();
        }

    }

    public void ValidStu()
    {

    }
    //绑定考试信息
    protected void bindInfo()
    {

        ExamBLL examBll = new ExamBLL();
        nowExam = examBll.GetNowExam();//当前考试


        string examName;
        //var res = (db.proc_getNewExam()).ToArray();

        if (nowExam == null)
        {
            //Label2.Text = "暂无考试";
            Label2.Visible = true;
            // Button1.Enabled = false;
            // TextBox1.Enabled = false;
            beginTime = "";
            return;
        }


        DateTime now = DateTime.Now.ToLocalTime();
        DateTime endTime = DateTime.Parse(nowExam.ExamEndTime.ToString());
        beginTime = nowExam.ExamBegTime.ToString();  //考试结束时间


        //查询到的考试已结束
        if (DateTime.Compare(now, endTime) > 0)
        {
           // Label2.Text = "暂无考试";
            Label2.Visible = true;
            Button1.Enabled = true;
            // TextBox1.Enabled = false;
            return;
        }

        examName = examBll.GetExamName(nowExam);


    }

    //学生登录
    protected void Button1_Click(object sender, EventArgs e)
    {

        if (TextBox1.Text == "" || TextBox2.Text == "")
        {
            errAlert("请输入学号和姓名！");
            return;
        }

        //     stuExamBll = new StuExamBLL();
        ExamBLL examBll = new ExamBLL();
        StuExamBLL stuExamBll = new StuExamBLL();

        Exam nowExam = examBll.GetNowExam();//当前考试
        if (nowExam == null)
        {
            errAlert("当前暂无考试！");
            return;
        }

        string erroeInfo = "";
        int res = stuExamBll.StuLogIn(TextBox1.Text.Trim(), TextBox2.Text.Trim(), nowExam.ExamId.ToString(), ref  erroeInfo);
        if (res <= 0)
        {
            errAlert(erroeInfo);
            return;
        }
        else
        {
            Panel1.Visible = false;
            //判断手机号是否为空
            Student stu = db.Student.First(t => t.StudentId == TextBox1.Text.Trim());
            if (stu.StudentPhone.Trim() == "")
                Panel3.Visible = true;
            else
                Panel2.Visible = true; // 显示确认开始考试

            examName = examBll.GetExamName(nowExam);
            string sId = TextBox1.Text.Trim();
            //Session["sId"] = sId;
            Response.Cookies["sId"].Value = sId;
        }

    }

    //确认开始考试
    protected void Button2_Click(object sender, EventArgs e)
    {
        ExamBLL examBll = new ExamBLL();
        StuExamBLL stuExamBll = new StuExamBLL();

        examName = examBll.GetExamName(nowExam);
        nowExam = examBll.GetNowExam();
        string sId = TextBox1.Text.Trim();

        DateTime now = DateTime.Now.ToLocalTime();
        DateTime beginTime = DateTime.Parse(nowExam.ExamBegTime.ToString());

        if (DateTime.Compare(now, beginTime) < 0)
        {
            infoAlert("请待考试开始");
            return;
        }
        else
        {
            int paperId = stuExamBll.StuBeginExam(sId, nowExam.ExamId.ToString());
            //alert(paperId.ToString());
            if (paperId > 0)
            {
                string examId = examBll.GetNowExam().ExamId.ToString();
                Response.Cookies["examId"].Value = examId; //当前考试Id

                Response.Redirect("ExamMain.aspx");
            }

            else
                errAlert("登陆出错,请联系管理员");
        }


    }

    //录入手机号
    protected void Button3_Click(object sender, EventArgs e)
    {
        //if (CheckPhoneIsAble(TextBox3.Text.Trim()) == false)
        //{
         //    errAlert("请输入正确的手机号!");
        //    return;
        //}
        if(TextBox1.Text.Trim() == "")
        {
            errAlert("请输入手机号!");
            return;
        }

        Student stu = db.Student.First(t => t.StudentId == TextBox1.Text.Trim());
        stu.StudentPhone = TextBox3.Text.Trim();
        db.SubmitChanges();
        Panel3.Visible = false;
        Panel2.Visible = true;

    }


    private bool CheckPhoneIsAble(string input)
    {
        if (input.Trim() == "")
            return false;
        Regex regex = new Regex("^13\\d{9}$");
        return regex.IsMatch(input.Trim());
    }
}