using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageStu_StudentDetail : BasePage
{

    StudentBLL studentBll = new StudentBLL();
    public static string SID = "";
    public static Student stu = new Student();
    public static List<string> allClass = new List<string>();
    protected void Page_Load(object sender, EventArgs e)
    {
        allClass = studentBll.GetAllClass();
        if (SID != "")
            stu = studentBll.GetStuBySid(SID);

        if (Request.QueryString["sId"] != null)
        {
            stu = studentBll.GetStuBySid(Request.QueryString["sId"]);
            SID = stu.StudentId;
        }

        //更新
        if (Request.Form["StudentId"] != null && Request.Form["operateType"] != null)
        {
            if (Request.Form["operateType"] == "0")  //更新
            {
                Student newStu = new Student()
                {
                    StudentId = Request.Form["StudentId"].Trim(),
                    StudentName = Request.Form["StudentName"].Trim(),
                    Class = Request.Form["class"].Trim(),
                    StudentPhone = Request.Form["StudentPhone"].Trim()

                };
                if (studentBll.UpdateStu(newStu) > 0)
                {
                    alert("修改成功", "PassAuditManage.aspx");
                }
                else
                    alert("修改失败");
                stu = studentBll.GetStuBySid(SID);
            }
            else  //删除
            {
                int res = studentBll.DeleteStu(Request.Form["StudentId"]);
                if(res == 1)
                {
                    alert("删除成功", "PassAuditManage.aspx");
                }
                if(res == -1)
                {
                    infoAlert("该考试生有考试记录，无法删除！");
                }
                else
                {
                    errAlert("删除失败！");
                }
            }
            
        }

    }
}