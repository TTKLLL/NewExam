<%@ WebHandler Language="C#" Class="GetSecondByFirst" %>

using System;
using System.Web;
using System.Collections.Generic;


//根据一级知识点获取二级知识点
public class GetSecondByFirst : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        PointService pointBll = new PointService();

        int firstId = int.Parse(context.Request.QueryString["firstId"]);
        
        
        List<SecondPoint> points = pointBll.GetSecondPoints(firstId);

        context.Response.Write(Public.ObjectToJson<SecondPoint>("secondPoints", points));
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}