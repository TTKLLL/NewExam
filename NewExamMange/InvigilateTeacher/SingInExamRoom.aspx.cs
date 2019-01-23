using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InvigilateTeacher_SingInExamRoom : BasePage
{

    public static Exam nowExam = null;
    public static string tname;
    public static string tId;

    public static Invigilate invigilate;

    ExamBLL examBll = new ExamBLL();
    AccountBLL accountBll = new AccountBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["uId"] == null || Request.Cookies["uId"].Value == "")
        {
            ReLogIn();
        }
        else
        {
            BindData();
            SingRoom();
            
        }

        




    }

    public void BindData()
    {

        Teacher teacher = accountBll.GetTeacherById(Request.Cookies["uId"].Value.ToString());
        tname = teacher.TName;
        tId = teacher.TId;


        nowExam = examBll.GetNowExam();
        if (nowExam == null)
        {
            alert("暂无即将开始的考试", "/Desktop.aspx");
            return;
        }



        invigilate = examBll.GetInvigilateByTidExamId(tId.ToString(), nowExam.ExamId.ToString());
        if (invigilate == null)
        {
            invigilate = new Invigilate()
            {
                ExamRoomName = "",
                ExamRoomPosition = "",
                OtherTeacher = ""
            };
        }
    }

    public void SingRoom()
    {
        if (Request.Form["ExamRoomName"] != null)
        {
            string roomName = Request.Form["ExamRoomName"].ToString();
            string positoing = Request.Form["ExamRoomPosition"].ToString().Trim();
            string otherTeacher = Request.Form["OtherTeacher"].ToString().Trim();
            if (roomName.Trim() == "" || positoing.Trim() == "" || otherTeacher.Trim() == "")
            {
                infoAlert("请输入考场信息！");
            }

            if (examBll.JudeExamRoomName(nowExam.ExamId.ToString(), roomName, tId))
            {
                alert("该考场名称已被登记", "SingInExamRoom.aspx");
                return;
            }
            if (examBll.JudeExamPosition(nowExam.ExamId.ToString().Trim(), positoing, tId))
            {
                alert("该考场地址已被登记", "SingInExamRoom.aspx");
                return;
            }
            else
            {
                Invigilate newInvigilate = new Invigilate()
                {
                    TId = tId,
                    ExamId = nowExam.ExamId,
                    ExamRoomName = roomName,
                    ExamRoomPosition = positoing,
                    OtherTeacher = otherTeacher
                };
                int res = examBll.SaveInvigilate(newInvigilate);
                if (res > 0)
                {

                    SuAlert("登记成功");
                    BindData();
                }
                else
                {
                    errAlert("失败");
                    BindData();
                }
            }
        }
    }

}