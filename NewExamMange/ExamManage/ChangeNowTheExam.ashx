<%@ WebHandler Language="C#" Class="ChangeNowTheExam" %>

using System;
using System.Web;


//修改当前次考试
public class ChangeNowTheExam : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Form["TheExamId"] != null)
        {
            string TheExamId = context.Request.Form["TheExamId"].ToString();
            ExamBLL examBll = new ExamBLL();

            bool res = false;
            if (examBll.ChangeNowTheExam(TheExamId) > 0)
                res = true;

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