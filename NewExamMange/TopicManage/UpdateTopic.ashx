<%@ WebHandler Language="C#" Class="UpdateTopic" %>

using System;
using System.Web;


//修改题目信息
public class UpdateTopic : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {

        TopicBLL topicBll = new TopicBLL();
        string answer = "";
        if (context.Request.Form["answerA"] == "on")
            answer += "A";
        if (context.Request.Form["answerB"] == "on")
            answer += "B";
        if (context.Request.Form["answerC"] == "on")
            answer += "C";
        if (context.Request.Form["answerD"] == "on")
            answer += "D";

        Topic topic = new Topic()
        {
            TopicId = decimal.Parse(context.Request.Form["topicId"]),
            SortId = int.Parse(context.Request.Form["sort"]),
            SecondPointId = int.Parse(context.Request.Form["second"]),
            TopicTitle = context.Request.Form["title"],
            OptionA = context.Request.Form["optionA"],
            OptionB = context.Request.Form["optionB"],
            OptionC = context.Request.Form["optionC"],
            OptionD = context.Request.Form["optionD"],
            TitleAnswer = answer,
            TopicState = int.Parse(context.Request.Form["TopicState"].ToString()),

            TopicType = context.Request.Form["type"],
            TopicSourceId = decimal.Parse(context.Request.Form["source"])
        };

        
        if (topicBll.UpdateTopic(topic) > 0)
            context.Response.Write("1");
        else
            context.Response.Write("0");


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}