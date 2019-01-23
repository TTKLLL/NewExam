using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;

public partial class Admin_TopicManage_InputTopic : BasePage
{
    public static List<ImputTopic> imputTopics = new List<ImputTopic>(); //Excel题目集合
    // public static List<ImputTopic> sameTopic = new List<ImputTopic>();  //可能相同的题目集合


    TopicBLL topicBll = new TopicBLL();
    PointService pointBll = new PointService();

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
           
        }


    }

    private string SaveFile()
    {
        try
        {
            if (FileUpload1.PostedFile.FileName == "" || FileUpload1.HasFile == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('要导入的文件不存在!');</script>");
                return "";
            }
            else
            {
                string filePath = FileUpload1.PostedFile.FileName;
                string filename = filePath.Substring(filePath.LastIndexOf("\\") + 1);
                string fileExt = filename.Substring(filename.LastIndexOf("."));
                if (!(fileExt == ".doc" || fileExt == ".docx"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件格式不正确!');</script>");
                    return "";
                }
                if (FileUpload1.PostedFile.ContentLength > 51200000)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件不能大于50MB!');</script>");
                    return "";
                }
                StringBuilder sname = new StringBuilder(DateTime.Now.Year + "_");
                sname.Append(DateTime.Now.Month + "_");
                sname.Append(DateTime.Now.Day);
                DirectoryInfo di = new DirectoryInfo(Server.MapPath(@"~\\" + sname.ToString()));
                if (!di.Exists)
                {
                    di.Create();
                }

                sname.Append("\\" + DateTime.Now.Hour + "_");
                sname.Append(DateTime.Now.Minute + "_");
                sname.Append(DateTime.Now.Second + "_");
                sname.Append(filename);
                FileUpload1.PostedFile.SaveAs(Server.MapPath(@"~\PracticalTopic\Topics") + sname.ToString());
                return @"~\PracticalTopic\Topics\" + sname.ToString();
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('" + ex.Message.ToString() + "');</script>");
            return "";
        }
    }

    public void alert(string str)
    {
        Response.Write("<script>alert('" + str + "')</script>");
    }

    //导入题目
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
                string realName = filePath.Substring(filePath.LastIndexOf("\\") + 1, filePath.LastIndexOf(".") - filePath.LastIndexOf("\\")-1);
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
                DirectoryInfo di = new DirectoryInfo(Server.MapPath(@"~\PracticalTopic\Topics\" + sname.ToString()));
                if (!di.Exists)
                {
                    di.Create();
                }

                sname.Append("\\" + DateTime.Now.Hour + "_");
                sname.Append(DateTime.Now.Minute + "_");
                sname.Append(DateTime.Now.Second + "_");
                sname.Append(filename);
                FileUpload1.PostedFile.SaveAs(Server.MapPath(@"~\PracticalTopic\Topics\") + sname.ToString());
                string path = "\\PracticalTopic\\Topics\\" + sname.ToString();
                PracticalTopic topic = new PracticalTopic()
                {
                    TopicPath = path,
                    TopicDesc = TextBox1.Text.Trim(),
                    TopicName = realName,
                     TopicUpTime = DateTime.Now.ToLocalTime()
                };
                if(topicBll.AddPracticalTopic(topic) == 1)
                {
                    TextBox1.Text = "";
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