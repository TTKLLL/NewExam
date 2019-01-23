<%@ WebHandler Language="C#" Class="OutPutTopic" %>

using System;
using System.Web;

public class OutPutTopic : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}