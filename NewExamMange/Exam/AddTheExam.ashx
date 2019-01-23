<%@ WebHandler Language="C#" Class="AddTheExam" %>

using System;
using System.Web;

//添加一次考试
public class AddTheExam : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        if(context.Request.Form["theExamName"] != null)
        {
            ExamBLL exambll = new ExamBLL();
            
            ////判断最新的次考试是否已结束
            //if (exambll.TheExamIsEnd())
            //{
            //    context.Response.Write("-1");  //最新的次考试还未结束
            //    return;
            //}
            if (context.Request.Cookies["ExamType"] == null)
            {
                context.Response.Write("-1");
                return;
            }

            string examType = context.Request.Cookies["ExamType"].Value;
            string theExamName = context.Request.Form["theExamName"].ToString();

           
            int theExamId = 0;
            theExamId = exambll.AddTheExam(theExamName, examType);

            context.Response.Write(theExamId.ToString());
            
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}