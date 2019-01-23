<%@ WebHandler Language="C#" Class="DeleteExam" %>

using System;
using System.Web;
using System.Collections.Generic;


//取消考试
public class DeleteExam : IHttpHandler {
    
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
                    TheExamId = decimal.Parse(item.TheExamId),
                    ExamBegTime = DateTime.Parse(item.ExamBegTime),
                    ExamEndTime = DateTime.Parse(item.ExamEndTime),
                    ExamPeriod = item.ExamPeriod,
                    NowPeriod = int.Parse(item.NowPeriod),
                    PaperNumber = int.Parse(item.PaperNumber.ToString())
                };
                newExams.Add(exam);
            }
            

            int flag = 1;

            foreach (var item in newExams)
            {
                flag = examBll.DeletePaperByExamId(item);
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