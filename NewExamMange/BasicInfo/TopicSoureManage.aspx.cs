using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BasicInfo_TopicSoureManage : BasePage
{
    public static List<TopicSource> source;
    public TopicBLL topicBll = new TopicBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //alert("Get");
            //删除
            if (Request.QueryString["deleteArray"] != null)
            {
                List<TopicSource> oldSource = Public.getObjectByJson<TopicSource>(Request.QueryString["deleteArray"].ToString());
                int res = 0;
                foreach (var item in oldSource)
                {
                    //跳过刚新添加的一行
                    if (item.TopicSourceId == 0)
                        continue;

                    if (topicBll.isHaveTopicOfSource(int.Parse(item.TopicSourceId.ToString())))
                    {
                        alert("题库中存在" + item.TopicSourceName + "相关题目,无法删除");
                        return;
                    }
                    else
                        res = topicBll.DeleteSource(int.Parse(item.TopicSourceId.ToString()));
                        if(res == 0)
                        {
                            alert("删除失败");
                            break;
                        }
                    
                }

                if (res == 1)
                    alert("删除成功");
                source = topicBll.GetAllSource();
            }
            else
            {
                source = topicBll.GetAllSource();
            }
        }
        else
        {
            // alert("Post");
            //更新
            if (Request.Form["allSorts"] != null)
            {
                string jsonString = Request.Form["allSorts"].ToString();
                List<TopicSource> oldSource = Public.getObjectByJson<TopicSource>(jsonString);

                int res = 0;
                foreach (var item in oldSource)
                {
                   if(topicBll.IsHaveSource(item.TopicSourceName) && item.TopicSourceId == 0)
                   {
                     //  alert(item.TopicSourceId.ToString());
                       alert(item.TopicSourceName + " 题库已存在,请勿重复添加");
                       return;
                   }

                    res = topicBll.SaveSource(item);
                    if (res == 0)
                    {
                        alert("保存失败");
                        break;
                    }
                }
                if (res == 1)
                    alert("保存成功");
                source = topicBll.GetAllSource();
            }
        }

    }

    public void alert(string str)
    {
        Response.Write("<script>alert('" + str + "')</script>");
    }
}