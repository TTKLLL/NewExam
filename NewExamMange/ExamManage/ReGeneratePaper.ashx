<%@ WebHandler Language="C#" Class="ReGeneratePaper" %>

using System;
using System.Web;
using System.Collections.Generic;

public class ReGeneratePaper : IHttpHandler {
    
    
    //重新生成试卷  
    public void ProcessRequest (HttpContext context) {
        if (context.Request.Form["examArray"] != null)
        {
            context.Response.ContentType = "text/plain";

            ExamBLL examBll = new ExamBLL(); ;
            List<MyExam> exams = Public.getObjectByJson<MyExam>(context.Request.Form["examArray"].ToString());

            List<Exam> newExams = new List<Exam>();
            foreach (var item in exams)
            {
                Exam exam = new Exam()
                {
                    ExamId = decimal.Parse(item.ExamId),
                    PaperNumber = int.Parse(item.PaperNumber.ToString())
                };
                newExams.Add(exam);
            }

            int flag = 1;

            foreach (var item in newExams)
            {
                flag = examBll.ReGenerate(item);
                if (flag <= 0)
                {
                    break;
                }
            }

            context.Response.Write(flag.ToString());
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}