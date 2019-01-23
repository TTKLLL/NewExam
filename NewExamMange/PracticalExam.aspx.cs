using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Text;
using System.IO;

public partial class PracticalExam : BasePage
{

    DataClassesDataContext db = new DataClassesDataContext();
    public string examId;
    public string studentId;
    public string endTime;
    PagedDataSource pds = new PagedDataSource();
    StuExamBLL stuExamBll = new StuExamBLL();
    public static string examName;
    public static Student student;

    public static PracticalTopic topic;

    ExamBLL examBll = new ExamBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (Request.Cookies["examId"] == null || Request.Cookies["sId"] == null)
        {

            Response.Redirect("StuLogIn.aspx");
        }
        else
        {
            studentId = Request.Cookies["sId"].Value.ToString();
            examId = Request.Cookies["examId"].Value.ToString();

            if (examBll.StueIsHaveSumbitPaper(studentId, examId))
            {
                alert("该考生已交卷", "StuLogIn.aspx");
            }

        }

        studentId = Request.Cookies["sId"].Value.ToString();


        topic = stuExamBll.GetStuPracTopicByExamId(studentId, examId);  //考生的题目
        bindHeadLine();//绑定试卷标题
        bindStuInfo();  //绑定学生信息

        //判断考是否已提交答案
        StuPaper stuPaper = db.StuPaper.First(t => t.StudentId == studentId && t.ExamId == decimal.Parse(examId));
        if (stuPaper.stuAnsPath == null || stuPaper.stuAnsPath.Trim() == "")
            Label1.Text = "未提交答案";
        else
            Label1.Text = "已提交答案";
    }

    //绑定试卷标题
    protected void bindHeadLine()
    {

        ExamBLL examBll = new ExamBLL();
        Exam nowExam = examBll.GetNowExam();
        examName = examBll.GetExamName(nowExam);
        if (examName == null || examName == "")
        {
            //Response.Write("<script>alert('获取试卷信息有误')</script>");
            Response.Redirect("StuLogIn.aspx");
        }

        headLine.Text = examName;
        endTime = nowExam.ExamEndTime.ToString();
    }

    //绑定学生信息
    protected void bindStuInfo()
    {

        StuExamBLL stuExamBll = new StuExamBLL();
        student = stuExamBll.GetStuInfo(studentId);
        if (student != null)
        {
            Sname.Text = student.StudentName;
            Sno.Text = student.StudentId;
        }

    }
  
    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            if (FileUpload1.PostedFile.FileName == "" || FileUpload1.HasFile == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('要导入的文件不存在!');</script>");
                return;
            }
            else
            {
                string filePath = FileUpload1.PostedFile.FileName;
                string filename = filePath.Substring(filePath.LastIndexOf("\\") + 1);
                string realName = filePath.Substring(filePath.LastIndexOf("\\") + 1, filePath.LastIndexOf(".") - filePath.LastIndexOf("\\") - 1);
                string fileExt = filename.Substring(filename.LastIndexOf("."));
                if (!(fileExt == ".doc" || fileExt == ".docx"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件格式不正确!');</script>");
                    return;
                }
                if (FileUpload1.PostedFile.ContentLength > 51200000)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件不能大于50MB!');</script>");
                    return;
                }

                StringBuilder sname = new StringBuilder(DateTime.Now.Year + "_");
                sname.Append(DateTime.Now.Month + "_");
                sname.Append(DateTime.Now.Day);
                DirectoryInfo di = new DirectoryInfo(Server.MapPath(@"~\PracticalTopic\StuAnswer\" + sname.ToString()));
                if (!di.Exists)
                {
                    di.Create();
                }

                //sname.Append("\\" + DateTime.Now.Hour + "_");
                //sname.Append(DateTime.Now.Minute + "_");
                //sname.Append(DateTime.Now.Second + "_");

                sname.Append("\\" + studentId + "_" + student.StudentName + "_" + examName);
                sname.Append(fileExt);
                FileUpload1.PostedFile.SaveAs(Server.MapPath(@"~\PracticalTopic\StuAnswer\") + sname.ToString());
                string path = "\\PracticalTopic\\StuAnswer\\" + sname.ToString();

                if (stuExamBll.StuPutPracAns(studentId, examId, path) == 1)
                {
                    Label1.Text = "已提交答案";
                    Response.Write("<script>alert('上传成功！')</script>");     
                }
                        
                else
                    Response.Write("<script>alert('上传失败！')</script>");

            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('" + ex.Message.ToString() + "');</script>");
            return;
        }

    }
}