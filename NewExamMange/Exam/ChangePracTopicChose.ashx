<%@ WebHandler Language="C#" Class="ChangePracTopicChose" %>

using System;
using System.Web;

public class ChangePracTopicChose : IHttpHandler {
    
    //修改实践题目选中状态
    public void ProcessRequest (HttpContext context) {
       if(context.Request.QueryString["tId"] != null)
       {
           TopicBLL topicBll = new TopicBLL();
           int res = topicBll.ChangePracTopicChose(context.Request.QueryString["tId"]);
           context.Response.Write(res.ToString()); 
       
       }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}