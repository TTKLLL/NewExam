using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddTeacher : BasePage
{

    DataClassesDataContext db = new DataClassesDataContext();
    TeacherBLL teacherBll = new TeacherBLL();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void bt_Save_Click(object sender, EventArgs e)
    {
        string tid = tb_tid.Text.Trim();
        string TPwd = generateMd5(tb_tpwd.Text.ToString());
        string tname = tb_name.Text.Trim();
        string tphnoe = tb_phone.Text.Trim();
        int IsAdmin = 0;
        int TeacherState = 1;
        DateTime TeacherCreateTime = DateTime.Now;
        int b = db.proc_selectExistTeaByTId(tid);
        if (b >= 1)
        {
            errAlert("该工号已经存在，请核对！");
            //  Response.Write("<script>alert('该工号已经存在，请核对！')</script>");

        }
        else
        {
            //db.proc_InsertTeacher(tid,TPwd,tname,tphnoe,IsAdmin,TeacherState,TeacherCreateTime);
            //db.SubmitChanges();
            Teacher teacher = new Teacher()
            {
                TId = tid,
                TPwd = TPwd,
                TName = tname,
                TPhone = tphnoe,
                IsAdmin = 0,
                TeacherState = TeacherState,
                TeacherCreateDate = TeacherCreateTime,
                isExamTeacher = 0
            };

            if (teacherBll.AddTeacher(teacher) > 0)
                ClientScript.RegisterClientScriptBlock(this.GetType(), "succeed", "<script>window.alert('添加教师成功！');window.location='ManageTeacher.aspx';</script>");
        }




    }

    protected string generateMd5(string oldPwd)
    {
        string newPwd = "";
        if (oldPwd != "")
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = System.Text.ASCIIEncoding.Unicode.GetBytes(oldPwd);
            byte[] targetData = md5.ComputeHash(fromData);
            for (int i = 0; i < targetData.Length; i++)
                newPwd += targetData[i].ToString();
        }
        return newPwd;
    }
}