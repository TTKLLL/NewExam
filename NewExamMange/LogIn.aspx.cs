using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;


public partial class Login2 : System.Web.UI.Page
{

    DataClassesDataContext db = new DataClassesDataContext();
    public static string url = "Main.aspx";
    //public static string url = "Default.aspx";

    public void alert(string str)
    {
        //  Response.Write("<script>alert('" + str + "')</script>");

        //防止弹出窗口后页面样式丢失
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "<script>alert('" + str + "');</script>");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Form["userName"] != null && Request.Form["pwd"] != null)
        {
            string uId = Request.Form["userName"].ToString().Trim();
            string pwd = Request.Form["pwd"].ToString().Trim();
            ValidUser(uId, pwd);
        }
    }

    //管理员选择功能模块
    protected void Admin_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string para = btn.CommandArgument;
        // alert(para);
        Response.Cookies["UserType"].Value = para; //设置为管理员或管理员监考老师
        Response.Redirect(url);


    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        Panel2.Visible = true;
    }

    protected void ValidUser(string id, string pwd)
    {

        int? res = 0;
        pwd = generateMd5(pwd);
        db.proc_LogIn(id, pwd, ref res);
        if (res == 1)
            alert("用户名不存在");
        else if (res == 2)
            alert("密码错误");

        else if (res == 0)
        {
            if (new AuthorityBLL().TeacherIsOnWord(id))
            {
                Session["uId"] = id;
                Response.Cookies["uId"].Value = id;
                JudeUserType(id);  //选择功能模块
                // Response.Redirect(url);
            }
            else
            {
                alert("此用户已离岗");

            }
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {

    }

    public void JudeUserType(string tId)
    {
        int count = new AuthorityBLL().TwoUser(tId);
        if (count > 1)
        {
            Panel1.Visible = true;
            Panel2.Visible = false;
        }
        else if (count == 1)
        {
            int role = new TeacherBLL().GetTeacherRole(tId);
            Response.Cookies["UserType"].Value = role.ToString(); ; //设置为管理员或管理员监考老师
            Response.Redirect(url);
        }
        else
        {
            //Response.Cookies["UserType"].Value = "ExamTeacher"; //设置为监考老师
            //Response.Redirect(url);
            Response.Write("<script>alert('暂无可用功能!')</script>");
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