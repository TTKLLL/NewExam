using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Public_ModifyPwd : BasePage
{

    DataClassesDataContext db = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["uId"] == null || Session["uId"].ToString() == string.Empty)
        //{
        //    ClientScript.RegisterClientScriptBlock(this.GetType(), "error", "<script>alert('登录过期，请重新登录');window.parent.location='Login.aspx'</script>");
        //    return;
        //}

    }
    protected void btnOk_Click(object sender, EventArgs e)
    {

        if (tbANewPwd.Text.ToString().Trim().Length < 4)
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "error", "<script>window.alert('密码太短，为确保账户安全请重新设置！');</script>");
            return;
        }
       // string uId = Session["uId"].ToString();
        string uId = Request.Cookies["uId"].Value.ToString();

        string pwd = generateMd5(tbANewPwd.Text.Trim());
        string oldPwd = generateMd5(tbOldPwd.Text.Trim());
        var QueryResult = from p in db.Teacher where p.TId == uId && p.TPwd == oldPwd select p;
        int count = QueryResult.Count();
      
       if(count == 1)
        {


            bool flag = false;

            var resultQuery = from a in db.Teacher
                              where a.TId == uId
                              select a;
            foreach (Teacher cs in resultQuery)
            {
                cs.TPwd = pwd;
                flag = true;
            }

            if (flag == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "message", "<script>alert('修改失败，请重试！');window.parent.location='../Default.aspx';</script>");
                return;

            }
            else
            {
                db.SubmitChanges();
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Success", "<script>alert('修改成功，请用新密码重新登陆！');window.parent.location='../Login.aspx'</script>");
            }

 
        }else{
        
         Response.Write("<script>alert('原密码输入错误');location.href='ModifyPwd.aspx'</script>");
      
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
       
 