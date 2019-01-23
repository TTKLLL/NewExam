<%@ WebHandler Language="C#" Class="ChangeNowPeriod" %>

using System;
using System.Web;

public class ChangeNowPeriod : IHttpHandler
{


    //修改当前场次
    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Form["examId"] != null)
        {
            string examId = context.Request.Form["examId"].ToString();
            ExamBLL exambll = new ExamBLL();


            int res = exambll.ChangeNowPeriod(examId);
            context.Response.Write(res.ToString());
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