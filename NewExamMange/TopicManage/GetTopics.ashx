<%@ WebHandler Language="C#" Class="GetTopics" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using System.Runtime.Serialization.Json;


public class GetTopics : IHttpHandler
{
    TopicBLL topicBll = new TopicBLL();

    public void ProcessRequest(HttpContext context)
    {
        int pageNumber = int.Parse(context.Request.QueryString["page"].ToString());
        int totalPage = 1;

        TopicQuery query = new TopicQuery();
    
        if(context.Request.QueryString["first"] != null)
        {
            string first = context.Request.QueryString["first"].ToString();
            string second = context.Request.QueryString["second"].ToString();
            query = new TopicQuery()
            {
                FirstPointId = int.Parse(first),
                SecondPointId = int.Parse(second),

                TopicSourceId = int.Parse(context.Request.QueryString["source"].Trim().ToString()),
                SortId = int.Parse(context.Request.QueryString["sort"].Trim().ToString()),
                TopicType = context.Request.QueryString["type"].Trim().ToString(),
                TopicTitle = context.Request.QueryString["topicTitle"].Trim().ToString(),
                TopicState = int.Parse(context.Request.QueryString["TopicState"].Trim().ToString())
                
            };
        }

        int totalCount = 0;
        List<ImputTopic> topics = topicBll.GetTopicsByPage(ref pageNumber, ref totalPage, query, ref totalCount);
        if(pageNumber > totalPage)
        {
            pageNumber = totalPage;
            topics = topicBll.GetTopicsByPage(ref pageNumber, ref totalPage, query, ref totalCount);
        }
        if(pageNumber < 1)
        {
            pageNumber = 1;
            topics = topicBll.GetTopicsByPage(ref pageNumber, ref totalPage, query, ref totalCount);
        }
        
        ArrayList arrayList = new ArrayList();
        arrayList.Add(topics);
        arrayList.Add(pageNumber);
        arrayList.Add(totalPage);
        context.Response.Write(Public.ObjectToJson<ImputTopic>("topics", topics, 
            pageNumber, totalPage, TopicBLL.TopicPageSize, totalCount));
        
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}