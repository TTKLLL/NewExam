<%@ WebHandler Language="C#" Class="JudgeExamName" %>

using System;
using System.Web;

//判断考试名名称是否重复
public class JudgeExamName : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
       
        if(context.Request.Form["examName"] != null)
        {
            string examName = context.Request.Form["examName"].ToString();
            ExamBLL examBll = new ExamBLL();
            bool res = false;
            
            if (examBll.IshaveTheExam(examName.Trim()))
            {
                res = true;
            }

            context.Response.Write(res);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}