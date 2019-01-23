<%@ WebHandler Language="C#" Class="ChangePracTcalScore" %>

using System;
using System.Web;

public class ChangePracTcalScore : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        StuExamBLL stuExamBll = new StuExamBLL();
        if(context.Request.QueryString["sId"] != null && context.Request.QueryString["TheExamId"] != null)
        {
            string TheExamId = context.Request.QueryString["TheExamId"];
            string sId = context.Request.QueryString["sId"];
            int score = int.Parse(context.Request.QueryString["score"]);

            string res =  stuExamBll.GetStuExamByTheExamId(sId, TheExamId, score);
            context.Response.Write(res);
        }
       
        
        
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}