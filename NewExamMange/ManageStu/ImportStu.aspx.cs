using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ImportSingle : BasePage
{
    protected DataClassesDataContext db = new DataClassesDataContext();
    public static List<Student> allStu = new List<Student>();  //要导入的考生信息
    public static List<Student> hasStu = new List<Student>(); //已存在的考生
    StudentBLL studentBll = new StudentBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (hasStu != null)
        {
            //有考生信息时显示
            if (hasStu.Count > 0)
            {
                Panel1.Visible = false;
                Panel2.Visible = true;
            }
        }

        if (Request.QueryString["idArray"] != null)
        {
            InputStu();

        }
    }
    private string SaveFile()
    {
        try
        {
            if (fuStu.PostedFile.FileName == "" || fuStu.HasFile == false)
            {
                infoAlert("要导入的文件不存在！");
                //ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('要导入的文件不存在!');</script>");
                return "";
            }
            else
            {
                string filePath = fuStu.PostedFile.FileName;
                string filename = filePath.Substring(filePath.LastIndexOf("\\") + 1);
                string fileExt = filename.Substring(filename.LastIndexOf("."));
                if (!(fileExt == ".xls" || fileExt == ".xlsx"))
                {
                    errAlert("文件格式不正确！");
                  //  ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件格式不正确!');</script>");
                    return "";
                }
                if (fuStu.PostedFile.ContentLength > 51200000)
                {
                    errAlert("文件不能大于50MB！");
                    //ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件不能大于50MB!');</script>");
                    return "";
                }
                StringBuilder sname = new StringBuilder(DateTime.Now.Year + "_");
                sname.Append(DateTime.Now.Month + "_");
                sname.Append(DateTime.Now.Day);
                DirectoryInfo di = new DirectoryInfo(Server.MapPath(@"~\Uploads\" + sname.ToString()));
                if (!di.Exists)
                {
                    di.Create();
                }


                // fuStu.PostedFile.SaveAs("d:\\1.txt");
                sname.Append("\\" + DateTime.Now.Hour + "_");
                sname.Append(DateTime.Now.Minute + "_");
                sname.Append(DateTime.Now.Second + "_");
                sname.Append(filename);
                fuStu.PostedFile.SaveAs(Server.MapPath(@"~\Uploads\") + sname.ToString());
                return @"~\Uploads\" + sname.ToString();
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('" + ex.Message.ToString() + "');</script>");
            return "";
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        string fileUrl = SaveFile();
        string connstr = "";
        int warning = 0;
        if (fileUrl == "")
        {
            return;
        }
        string extention = Path.GetExtension(fileUrl);
        if (extention == ".xls")
        {
            connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath(fileUrl) + ";Extended Properties='Excel 8.0;HDR=YES;IMEX=2'";
        }
        else
        {
            connstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath(fileUrl) + ";Extended Properties='Excel 12.0 Xml;HDR=YES;IMEX=2'";
        }
        OleDbConnection conn = new OleDbConnection(connstr);
        try
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand("select * from [Sheet1$]", conn);
            OleDbDataReader dr = cmd.ExecuteReader();

            if (allStu != null)
                allStu.Clear();
            while (dr.Read())
            {
                if (dr["学号"].ToString().Trim() == "" ||
                    dr["姓名"].ToString().Trim() == "" || dr["班级"].ToString().Trim() == "")
                {
                    alert("请将信息补全后重新导入");
                    break;
                }
                    
                Student stu = new Student()
                {
                    StudentId = dr["学号"].ToString().Trim(),
                    StudentName = dr["姓名"].ToString().Trim(),
                    StudentPhone = "",   //手机号默认为空
                    Class = dr["班级"].ToString().Trim()
                };
                allStu.Add(stu);

            }
            CheckStu();
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('" + ex.Message + "');</script>");
        }
        finally
        {
            conn.Close();
            File.Delete(Server.MapPath(fileUrl));
            if (warning != 0)
            {
               
                Response.Write("<script>alert('请将所有数据项补全后重新导入！');window.location.href='ImportSingle.aspx';</script>");
            }
            else
            {
               
            }
        }
        db.SubmitChanges();
      
    }
    protected void btnDownModle_Click(object sender, EventArgs e)
    {
        try
        {
            string strFilePath = Server.MapPath("~") + "/Files//Student.xls";//服务器文件路径
            FileInfo fileInfo = new FileInfo(strFilePath);
            Response.Clear();
            Response.Charset = "GB2312";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.AddHeader("Content-Disposition", "attachment;filename=" + Server.UrlEncode(fileInfo.Name));
            Response.AddHeader("Content-Length", fileInfo.Length.ToString());
            Response.ContentType = "application/x-bittorrent";
            Response.WriteFile(fileInfo.FullName);
            Response.End();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            //不做处理
        }
        catch (Exception ex)
        {
            //做处理
        }


        //string path = Server.MapPath("~/Files//Student.xls");
        ////获取文件名
        //string FileNameNoExtension = System.IO.Path.GetFileNameWithoutExtension(path).ToLower();
        ////获取文件后缀
        //string FileExtension = System.IO.Path.GetExtension(path).ToLower();
        //string FileFullName = FileNameNoExtension + FileExtension;
        //Response.Clear();
        //Response.Charset = "utf-8";
        //Response.Buffer = true;
        //this.EnableViewState = false;
        //Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(FileFullName));
        //Response.ContentType = "application/unknown";
        //Response.WriteFile(path);
        //Response.Flush();
        //Response.Close();
        //Response.End();
    }

    public void CheckStu()
    {
        if (hasStu != null)
            hasStu.Clear();
        foreach (var item in allStu)
        {
            if (studentBll.IsHaveTheStu(item) > 0)
            {
                hasStu.Add(item);
            }
        }

        if (hasStu.Count() > 0)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        else  //没有异常情况
        {
            //直接导入文档中的学生信息
            int res = 0;
            foreach (var item in allStu)
            {
                if (studentBll.AddStudent(item) > 0)
                    res = 1;
                else
                {
                    res = 0;
                    break;

                }
            }

            if (res == 1)
            {
                hasStu.Clear();
                allStu.Clear();

                alert("导入考生信息成功", "WaitAuditManage.aspx");
            }
        }
    }

    //重新导入
    protected void reInput_Click(object sender, EventArgs e)
    {
        if (allStu != null)
            allStu.Clear();
        if (hasStu != null)
            hasStu.Clear();
        Panel1.Visible = true;
        Panel2.Visible = false;
    }

    //导入用户选择否的考生信息
    public void InputStu()
    {

        try
        {
            //除去不需要更新的考生
            Array idArray = Request.QueryString["idArray"].Split(',');


            List<Student> addStu = new List<Student>();

            foreach (var stu in allStu)
            {
                int tag = 0;
                foreach (string sid in idArray)
                {
                    if (stu.StudentId == sid.ToString())
                        tag = 1;
                }
                if (tag == 0)
                    addStu.Add(stu);
            }



            if (addStu.Count == 0)
            {
                hasStu.Clear();
                allStu.Clear();
                alert("没有需要更新或添加的考生", "WaitAuditManage.aspx");
                return;
            }


            int res = 0;
            foreach (var item in addStu)
            {
                if (studentBll.AddStudent(item) > 0)
                    res = 1;
                else
                {
                    res = 0;
                    break;

                }
            }

            if (res == 1)
            {
                hasStu.Clear();
                allStu.Clear();
  
                alert("导入考生信息成功", "WaitAuditManage.aspx");
              

            }
            else
            {
                alert("导入考生信息失败");
            }
        }
        catch(Exception ex)
        {
            hasStu.Clear();
            allStu.Clear();
            Panel1.Visible = true;
            Panel2.Visible = false;
        }

    }
}

