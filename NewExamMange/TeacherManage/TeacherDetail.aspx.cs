using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeacherManage_TeacherDetail : BasePage
{

    //public string lr_UserName { set; get; }
    DataClassesDataContext db = new DataClassesDataContext();
    public string TId;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack == true)
        {

            BindData();

        }
    }

    public void BindData()
    {
        string TId = Request.QueryString["fileNo"].ToString();
        var result = (from p in db.Proc_SellectTeacherInfoByTId(TId)
                      select p).First();
        la_TeaNo.Text = result.TId;
        te_phone.Text = result.TPhone;
        tb_name.Text = result.TName;
        //if (result.IsAdmin == 1)
        //    Label1.Text = "管理员";
        //else
        //    Label1.Text = "监考老师";

    }
    public void bt_Save_Click(object sender, EventArgs e)
    {
        string tphone = te_phone.Text.Trim();
        string tname = tb_name.Text.Trim();
        TId = la_TeaNo.Text.Trim();
        int b = db.proc_UpdateTeacherById(tname, tphone, TId);

        if (b >= 0)
        {
            db.SubmitChanges();
            ClientScript.RegisterClientScriptBlock(this.GetType(), "succeed", "<script>window.alert('修改教师信息成功!');window.location='ManageTeacher.aspx';</script>");
        }


    }
    protected void RestPwd_btn_Click(object sender, EventArgs e)
    {
        TId = la_TeaNo.Text.Trim();
        string NewTpwd = generateMd5(TId);
        db.proc_ResetTeacherPwd(NewTpwd, TId);
        db.SubmitChanges();
        ClientScript.RegisterClientScriptBlock(this.GetType(), "succeed", "<script>window.alert('重置教师密码成功！');window.location='ManageTeacher.aspx';</script>");


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
    protected void Delete_btn_Click(object sender, EventArgs e)
    {
        TeacherBLL teachetBll = new TeacherBLL();

        Teacher teacher = new Teacher()
        {
            TId = la_TeaNo.Text.Trim()
        };
        if (teachetBll.TeacherIsInvigilate(teacher.TId.ToString()))
        {
            infoAlert("该教师有监考记录， 无法删除");
        }
        else
        {
            if (teachetBll.DeleteTeacher(teacher) > 0)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "succeed", "<script>window.alert('删除成功！');window.location='ManageTeacher.aspx';</script>");
            }
        }
        
    }
}