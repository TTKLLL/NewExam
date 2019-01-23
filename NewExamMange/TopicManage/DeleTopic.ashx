<%@ WebHandler Language="C#" Class="DeleTopic" %>

using System;
using System.Web;

public class DeleTopic : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
       if(context.Request.Form["topicId"] != null)
       {
          
          int res =  new TopicBLL().DeleTopic(context.Request.Form["topicId"]);
          context.Response.Write(res.ToString());
           
       }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}