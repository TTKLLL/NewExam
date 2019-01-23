using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InvigilateTeacher_TeacherAddStu : BasePage
{
    StudentBLL stuBll = new StudentBLL();
    DataClassesDataContext db = new DataClassesDataContext();
    public static List<string> ClassInfo = new List<string>();
    public static string SId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ClassInfo = db.Student.OrderBy(t => t.Class).Select(t => t.Class).Distinct().ToList();


        }

        if (Request.Form["sId"] != null)
        {
            Student stu = new Student()
            {
                StudentId = Request.Form["sId"],
                StudentName = Request.Form["name"],
                Class = Request.Form["class"],
                StudentPhone = Request.Form["phone"]
            };


            if (new StudentBLL().InvTeacherAddStudent(stu) > 0)
            {
                SId = stu.StudentId;
                alert("添加成功", "TeacherAddStu.aspx");
            }

        }
    }
}