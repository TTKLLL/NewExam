<%@ WebHandler Language="C#" Class="ChangeExamState" %>

using System;
using System.Web;
using System.Collections.Generic;

public class ChangeExamState : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        int res = 0;
        StudentBLL stuBll = new StudentBLL();
        
        if(context.Request.Form["sId"] != null)
        {            
            Student stu = new Student()
            {
                StudentId = context.Request.Form["sId"].Trim(),
                StudentState = int.Parse(context.Request.Form["state"].ToString())
            };

            if (stuBll.UpdateStuState(stu) > 0)
                res = 1;

            context.Response.Write(res);
        }
        
        if(context.Request.Form["idArray"] != null)
        {
            Array ids = context.Request.Form["idArray"].Split(',');
            foreach(var item in ids)
            {
                Student stu = new Student()
                {
                    StudentId = item.ToString(),
                    StudentState = int.Parse(context.Request.Form["state"].ToString())
                };
                if (stuBll.UpdateStuExamState(stu) <= 0)
                {
                    res = 0;
                    context.Response.Write(res);
                    return;
                }
                else
                     res = 1;
                    
            }
            if(res == 1)
                context.Response.Write(res);
            
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}