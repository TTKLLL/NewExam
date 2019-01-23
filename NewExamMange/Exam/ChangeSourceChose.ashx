<%@ WebHandler Language="C#" Class="ChangeSourceChose" %>

using System;
using System.Web;


//修改题库选中状态
public class ChangeSourceChose : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        if(context.Request.Form["TopicSourceId"] != null)
        {
            string TopicSourceId = context.Request.Form["TopicSourceId"].ToString();
            ExamBLL examBll = new ExamBLL();
            
            bool res = false;
            if (examBll.ChangeSourceChose(TopicSourceId) > 0)
                res = true;

            context.Response.Write(res);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}