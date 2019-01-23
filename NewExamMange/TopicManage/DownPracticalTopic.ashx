<%@ WebHandler Language="C#" Class="DownPracticalTopic" %>

using System;
using System.Web;
using System.IO;

public class DownPracticalTopic : IHttpHandler
{

    //下载实践题目
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            context.Response.ContentType = "text/plain";
            string path;
            if (context.Request.QueryString["tId"] != null)
            {
                PracticalTopic topic = new TopicBLL().GetPracTopicById(context.Request.QueryString["tId"]);
                path = topic.TopicPath;

            }

            else if (context.Request.QueryString["sId"] != null && context.Request.QueryString["TheExamId"] != null)
            {
                string sId = context.Request.QueryString["sId"];
                string TheExamId = context.Request.QueryString["TheExamId"];
                path = new ExamBLL().GetStuPracAnsById(sId, TheExamId);
            }
            else
                return; //获取路径失败

            string strFilePath = context.Server.MapPath("~") + path;//服务器文件路径
            FileInfo fileInfo = new FileInfo(strFilePath);
            context.Response.Clear();
            context.Response.Charset = "GB2312";
            context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            context.Response.AddHeader("Content-Disposition", "attachment;filename=" + context.Server.UrlEncode(fileInfo.Name));
            context.Response.AddHeader("Content-Length", fileInfo.Length.ToString());
            context.Response.ContentType = "application/x-bittorrent";
            context.Response.WriteFile(fileInfo.FullName);
            context.Response.End();
        }
        catch(Exception e)
        {
            context.Response.Write(e.Message);
        }
        

    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}