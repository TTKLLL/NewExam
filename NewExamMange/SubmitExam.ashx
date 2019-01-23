<%@ WebHandler Language="C#" Class="AutoPutExam" %>

using System;
using System.Web;

public class AutoPutExam : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Form["studentId"] != null)
        {
            bool res = false;
            StuExamBLL stuExamBll = new StuExamBLL();
            string studentId = context.Request.Form["studentId"];
            string examId = context.Request.Form["examId"].ToString();

            if (stuExamBll.StuSubmitPaper(studentId, examId) > 0)
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