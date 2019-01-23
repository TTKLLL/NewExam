using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PersonManage_PersonInfo : BasePage
{
    DataClassesDataContext db = new DataClassesDataContext();
    public static string uId;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack == true)
        {

            //if (Session["uId"] == null || Session["uId"].ToString() == string.Empty)
            //{

            //    ClientScript.RegisterClientScriptBlock(this.GetType(), "error", "<script>alert('登录过期，请重新登录！');window.parent.location='../Login.aspx'</script>");
            //    return;

            //}
            bindata();


        }

    }

    public void bindata()
    {

        //string uid = Session["uId"].ToString();
        uId = Request.Cookies["uId"].Value.ToString();
        var result = (from p in db.Teacher select p).ToList();
        tb_Phone.Text = result.First().TPhone;
    }


    protected void bt_Save_Click(object sender, EventArgs e)
    {

        bool flag = false;
        string newTeaPhone = tb_Phone.Text.Trim().ToString();

        var resultQuery = from a in db.Teacher
                          where a.TId == uId
                          select a;
        foreach (Teacher cs in resultQuery)
        {
            cs.TPhone = newTeaPhone;
            flag = true;
        }

        if (flag == false)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "message", "<script>alert('修改失败，请重试！');window.parent.location='../Main.aspx';</script>");
            return;

        }
        else
        {
            db.SubmitChanges();
            ClientScript.RegisterStartupScript(this.GetType(), "message", "<script>alert('修改信息成功！');window.parent.location='../Main.aspx';</script>");
        }

    }
    protected void bt_confirm_Click(object sender, EventArgs e)
    {
        if (tb_CheckPwd.Text.ToString().Trim() == "")
        {
            alert("请输入原密码！");
            return;
        }
        string pwd = generateMd5(tb_CheckPwd.Text.ToString().Trim());

        var result = from p in db.Teacher where p.TPwd == pwd && p.TId == uId select p;
        int row = result.Count();
        if (row == 1)
        {
            pl_CheckPwd.Visible = false;
            pl_AdmInfo.Visible = true;

        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>alert('密码输入错误！');</script>");

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