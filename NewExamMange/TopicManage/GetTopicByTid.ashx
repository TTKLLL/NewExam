<%@ WebHandler Language="C#" Class="GetTopicByTid" %>

using System;
using System.Web;
using System.Collections.Generic;


//根据题目Id获取题目信息
public class GetTopicByTid : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        if (context.Request.Form["topicId"] != null)
        {
            TopicBLL topicBll = new TopicBLL();
            string topicId = context.Request.Form["topicId"];
            ImputTopic topic = topicBll.GetTopicByTid(topicId);
            List<ImputTopic> topics = new List<ImputTopic>();
            topics.Add(topic);

            context.Response.Write(Public.ObjectToJson<ImputTopic>( "topic", topics));
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}