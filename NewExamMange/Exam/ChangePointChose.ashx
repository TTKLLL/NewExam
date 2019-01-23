<%@ WebHandler Language="C#" Class="ChangePointChose" %>

using System;
using System.Web;

public class ChangePointChose : IHttpHandler
{


    //修改知识点选中状态
    public void ProcessRequest(HttpContext context)
    {
        PointService pointBll = new PointService();
        if (context.Request.Form["secondId"] != null)
        {
            int secondId = int.Parse(context.Request.Form["secondId"]);
            int state = int.Parse(context.Request.Form["state"]);
            bool res = false;
            if (pointBll.ChageSecondChoseBySecond(secondId, state) > 0)
                res = true;
            context.Response.Write(res);
        }

        //全选
        if (context.Request.Form["firstId"] != null)
        {
            int fistId = int.Parse(context.Request.Form["firstId"]);
            int state = int.Parse(context.Request.Form["state"]);
            bool res = false;
            if (pointBll.ChageSecondChoseByFirst(fistId, state) > 0)
                res = true;
            context.Response.Write(res);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}