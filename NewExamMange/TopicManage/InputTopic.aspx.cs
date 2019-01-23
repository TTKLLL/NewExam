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
        //if (imputTopics != null)
        //    imputTopics.Clear();  //清空题目集合
        //if (sameTopic != null)
        //    sameTopic.Clear();
        if (!IsPostBack)
        {
            if (Request.QueryString["pointArray"] != null)
            {
                //添加知识点
                List<Point> points = Public.getObjectByJson<Point>(Request.QueryString["pointArray"].ToString());
                int res = 0;
                foreach (var item in points)
                {
                    res = pointBll.AddPoint(item);
                    if (res == 0)
                        alert("添加知识点失败");
                }
                if (res == 1)
                {
                    //alert("添加知识点成功");
                    //导入题目
                    InputTopic();
                }

            }
        }


    }

    private string SaveFile()
    {
        try
        {
            if (fuStu.PostedFile.FileName == "" || fuStu.HasFile == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('要导入的文件不存在!');</script>");
                return "";
            }
            else
            {
                string filePath = fuStu.PostedFile.FileName;
                string filename = filePath.Substring(filePath.LastIndexOf("\\") + 1);
                string fileExt = filename.Substring(filename.LastIndexOf("."));
                if (!(fileExt == ".xls" || fileExt == ".xlsx"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件格式不正确!');</script>");
                    return "";
                }
                if (fuStu.PostedFile.ContentLength > 51200000)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "error", "<script>window.alert('文件不能大于50MB!');</script>");
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

    //下载模板
    protected void btnDownModle_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("~/Files//Problem.xls");
        //获取文件名
        string FileNameNoExtension = System.IO.Path.GetFileNameWithoutExtension(path).ToLower();
        //获取文件后缀
        string FileExtension = System.IO.Path.GetExtension(path).ToLower();
        string FileFullName = FileNameNoExtension + FileExtension;
        Response.Clear();
        Response.Charset = "utf-8";
        Response.Buffer = true;
        this.EnableViewState = false;
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(FileFullName));
        Response.ContentType = "application/unknown";
        Response.WriteFile(path);
        Response.Flush();
        Response.Close();
        Response.End();
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
        if (imputTopics != null)
            imputTopics.Clear();  //清空题目集合
        //if (sameTopic != null)
        //    sameTopic.Clear();

        try
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand("select * from [Sheet1$]", conn);
            OleDbDataReader dr = cmd.ExecuteReader();
            int index = 0;
            while (dr.Read())
            {
                index++;
                if (dr["题目"].ToString().Trim() == "")
                    break;
                //if (dr["题目"].ToString().Trim() == "" || dr["选项A"].ToString().Trim() == ""
                //    || dr["选项B"].ToString().Trim() == "" || dr["答案"].ToString().Trim() == ""
                //    || dr["一级知识点"].ToString().Trim() == "" || dr["二级知识点"].ToString().Trim() == ""
                //    || dr["题目类别"].ToString().Trim() == "" || dr["题目类型"].ToString().Trim() == ""
                //    || dr["题库名称"].ToString().Trim() == "")
                //{
                //    warning = 1;
                    
                //    break;
                //    //continue;
                //}
                if(dr["题目"].ToString().Trim() == "")
                {
                    infoAlert("请将第"+index+"题的题目标题信息填写完整");
                    return;
                }
                if (dr["选项A"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的选项A信息填写完整");
                    return;
                }
                if (dr["选项B"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的选项B信息填写完整");
                    return;
                }
                if (dr["选项C"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的选项C信息填写完整");
                    return;
                }
                if (dr["选项D"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的选项D信息填写完整");
                    return;
                }
                if (dr["答案"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的答案信息填写完整");
                    return;
                }
                if (dr["一级知识点"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的一级知识点信息填写完整");
                    return;
                }
                if (dr["二级知识点"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的二级知识点填写完整");
                    return;
                }
                if (dr["题目类别"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的题目类别信息填写完整");
                    return;
                }

                if (dr["题目类型"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的题目类型信息填写完整");
                    return;
                }
                if (dr["题库名称"].ToString().Trim() == "")
                {
                    infoAlert("请将第" + index + "题的题库名称信息填写完整");
                    return;
                }
                
                int sortid = 1;
                if (Request.QueryString["sortid"] != null)
                {
                    sortid = Convert.ToInt16(Request.QueryString["sortid"].ToString());
                }

                ImputTopic impupt = new ImputTopic()
                {
                    TopicTitle = dr["题目"].ToString().Trim(),
                    OptionA = dr["选项A"].ToString().Trim(),
                    OptionB = dr["选项B"].ToString().Trim(),
                    OptionC = dr["选项C"].ToString().Trim(),
                    OptionD = dr["选项D"].ToString().Trim(),
                    TitleAnswer = dr["答案"].ToString().Trim(),
                    FirstPointName = dr["一级知识点"].ToString().Trim(),
                    SecondPointName = dr["二级知识点"].ToString().Trim(),
                    SortName = dr["题目类别"].ToString().Trim(),
                    TopicType = dr["题目类型"].ToString().Trim(),
                    TopicSourceName = dr["题库名称"].ToString().Trim()
                };
                imputTopics.Add(impupt);
            }
            CheckTopic();
            //CheckExxcelRepeat();

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
                Response.Write("<script>alert('请将所有数据项补全后重新导入！');window.location.href='InputTopic.aspx';</script>");
            }
            else
            {

                // Response.Write("<script>window.location.href='ManageJudge.aspx?';</script>");


            }
        }

    }

    public void CheckTopic()
    {
        if (imputTopics == null)
        {
            alert("Excel中没有题目");
        }

        int count = 0;  //有问题的题目数量 
        int flag = 0;

        List<ImputTopic> dataBase = topicBll.GetAllTopics();
        foreach (var item in imputTopics)
        {
            item.ErrorInfo = "";  //初始化错误信息

            //判断题库是否存在
            if (!topicBll.IsHaveTopicSource(item.TopicSourceName))
            {
                item.ErrorInfo += "该题库不存在 ";
                flag = 1;
            }

            //判断知识点是否存在
            if (pointBll.IsHasFist(item.FirstPointName) == 0 ||
                pointBll.IsHasSecond(item.SecondPointName) == 0)
            {
                item.ErrorInfo += "该题目的知识点不存在 ";
                flag = 1;

            }

            foreach (var dataItem in dataBase)
            {
                if (Public.Convert(item.TopicTitle) == dataItem.TopicTitle)
                {
                    item.ErrorInfo += "此题在题库中已存在 ";
                    flag = 1;
                }
            }

            if (flag == 1)
                count++;

            flag = 0;

        }
        Panel1.Visible = false;
        Panel2.Visible = true;   //显示要上传的题目

        if (count > 0)
        {
            ConfirmInput.Enabled = false;
            TableHead.Text = "文档中存在"+imputTopics.Count()+"题  其中" + count.ToString() + "题存在问题";
        }
        else
            ConfirmInput.Enabled = true;
    }
    public void alert(string str)
    {
        Response.Write("<script>alert('" + str + "')</script>");
    }



    public void ChangeTable(string head)
    {
        TableHead.Text = head;
        Panel1.Visible = false;
        Panel2.Visible = true;
    }



    //与系统题库比对
    //public int CheckDataBase()
    //{
    //    //if (sameTopic != null)
    //    //    sameTopic.Clear();
    //    int count = 0;

    //    List<ImputTopic> dataBase = topicBll.GetAllTopics();
    //    foreach (var item in imputTopics)
    //    {
    //        item.ErrorInfo = "";  //初始化错误信息
    //        foreach (var dataItem in dataBase)
    //        {
    //            if (item.TopicTitle == dataItem.TopicTitle){
    //                item.ErrorInfo += "此题在题库中已存在";
    //                count++;
    //            }

    //                //sameTopic.Add(item);
    //        }
    //    }
    //    return count;


    //}

    //检查知识点是否存在
    //public int CheckPoint()
    //{
    //    int count = 0;

    //    //if (sameTopic != null)
    //    //    sameTopic.Clear();

    //    List<Point> allPoints = pointBll.GetPoints();
    //    foreach (var item in imputTopics)
    //    {
    //        if (pointBll.IsHasFist(item.FirstPointName) == 0 ||
    //            pointBll.IsHasSecond(item.SecondPointName) == 0)
    //        {
    //            item.ErrorInfo += "该题目的知识点不存在";
    //            count++;
    //           // sameTopic.Add(item);
    //        }

    //    }
    //    return count;

    //}




    //重新导入
    protected void ReImput_btn_Click(object sender, EventArgs e)
    {
        //sameTopic.Clear();
        imputTopics.Clear();
        Panel1.Visible = true;
        Panel2.Visible = false;
        //Panel3.Visible = false;
        //Panel4.Visible = true;
    }

    //Excel内部有相同题目 继续验证数据库


    //数据库中已存在题目 继续验证知识点


    //检查知识点



    //导入题目
    public void InputTopic()
    {
        int res = 0;
        foreach (var item in imputTopics)
        {
            res = topicBll.AddTopic(item);
            if (res == 0)
                break;
        }
        if (res > 0)
        {
            Response.Write("<script>alert('导入成功');window.location.href='TopicInfo.aspx';</script>");

        }


    }



    //导入题目
    protected void ConfirmInput_Click(object sender, EventArgs e)
    {
        InputTopic();
    }

    //重新导入
    protected void Reset_Click(object sender, EventArgs e)
    {
        imputTopics.Clear();
        Panel1.Visible = true;
        Panel2.Visible = false;
    }
}