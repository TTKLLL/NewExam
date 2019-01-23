﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Authority_GrantAuthority : BasePage
{

    DataClassesDataContext db = new DataClassesDataContext();
    public string userName = null;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack == true)
        {

            //if (Session["uId"] == null || Session["uId"].ToString() == string.Empty)
            //{


            //    ClientScript.RegisterClientScriptBlock(this.GetType(), "error", "<script>alert('登录过期，请重新登录');window.parent.location='/Login.aspx'</script>");
            //    return;
            //}

            Bindata();


        }

    }

    public void Bindata()
    {
        userName = Request.QueryString["username"].ToString();
      //  string tid = Session["uId"].ToString();

        string tid = Request.Cookies["uId"].Value.ToString().Trim();
        // var tId=from c in db.TeaAuthority where c.TId == userName select c;
        var result = (from p in db.Authority
                     where !(from q in db.TeaAuthority where q.TId == userName.ToString() select q.AuthorityId).Contains(p.AuthorityId)
                     && (from s in db.TeaAuthority where s.TId == tid.ToString() select s.AuthorityId).Contains(p.AuthorityId)
                      select p).Where(t => t.AuthorityType == (int)AuthorityBLL.AuthorityType.Admin);

        if (result.Count() < 1)
        {

            pl_Info.Visible = true;

        }
        else
        {

            rp_AutorityGrant.DataSource = result;
            rp_AutorityGrant.DataBind();

        }

    }



    protected void btn_GrantGroup_Click(object sender, EventArgs e)
    {

        bool flag = false;
        userName = Request.QueryString["username"].ToString();

        try
        {
        foreach (RepeaterItem item in rp_AutorityGrant.Items)
            {
                if (((CheckBox)item.FindControl("cb_Select")).Checked == true)
                {

                    flag = true;
                    int Aid = Int32.Parse(((HiddenField)item.FindControl("hi_Id")).Value);
                    var cs = new TeaAuthority
                    {
                        AuthorityId = Aid,
                        TId = userName
                    };
                    db.TeaAuthority.InsertOnSubmit(cs);

                }

            }
 
            if (flag == false)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "message", "<script>alert('请先勾选功能！');</script>");

                return;
            }
            else
            {

                db.SubmitChanges();
         
                ClientScript.RegisterStartupScript(this.GetType(), "message", "<script> alert('权限授予成功！');</script>");


  //              ClientScript.RegisterStartupScript(this.GetType(), "message", "<script> alert('权限授予成功！');window.location='GrantAuthority.aspx?username=userName';</script>");

            }
            Bindata();

        }
        catch (Exception ex)
        {

            ClientScript.RegisterStartupScript(this.GetType(), "message", "<script>alert('权限授予失败，请重试！');</script>");
            return;
      }
  }





}