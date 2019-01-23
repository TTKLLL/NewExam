<%@ WebHandler Language="C#" Class="StuIsHave" %>

using System;
using System.Web;

//判断考生是是否已存在
public class StuIsHave : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        if(context.Request.Form["sId"] != null)
        {
            string sId = context.Request.Form["sId"].ToString();
            StudentBLL stuBll = new StudentBLL();

            bool res = false;
            if (stuBll.IsHaveThStu(sId))
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