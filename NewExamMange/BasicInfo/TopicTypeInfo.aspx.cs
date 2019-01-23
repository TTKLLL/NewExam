using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization.Json;

public partial class BasicInfo_TopicTypeInfo : BasePage
{
    TopicBLL topicBll = new TopicBLL();
    public static List<Sort> sorts;
    protected void Page_Load(object sender, EventArgs e)
    {
        sorts = topicBll.GetTopiciSort();

        if (!IsPostBack)
        {
            //删除
            if (Request.QueryString["deleteArray"] != null)
            {
                List<Sort> oldSorts = Public.getObjectByJson<Sort>(Request.QueryString["deleteArray"].ToString());
                int res = 0;
                foreach (var sort in oldSorts)
                {
                    //跳过刚新添加的一行
                    if (sort.SortId == 0)
                        continue;

                    if (topicBll.HasTopicInSort(int.Parse(sort.SortId.ToString())))
                    {
                        alert("题库中存在" + sort.SortName + "相关题目,无法删除");
                    }
                    else
                        res = topicBll.DeleteSort(int.Parse(sort.SortId.ToString()));
                    if (res != 1)
                    {
                        alert("删除失败");
                        return;
                    }

                }
                if (res == 1)
                    alert("删除成功");
                sorts = topicBll.GetTopiciSort();
            }
            else
            {
                sorts = topicBll.GetTopiciSort();
            }
        }
        else
        {
            // alert("Post");
            //更新
            if (Request.Form["allSorts"] != null)
            {
                string jsonString = Request.Form["allSorts"].ToString();
                List<Sort> oldSorts = Public.getObjectByJson<Sort>(jsonString);

                int res = 0;
                foreach (var item in oldSorts)
                {
                    if (topicBll.IsHaveSort(item.SortName) && item.SortId == 0)
                    {
                        alert(item.SortName + " 已存在， 请勿重复添加");
                        return;
                    }

                    res = topicBll.SaveSort(item);
                    if (res == 0)
                    {
                        alert("保存失败");
                        break;
                    }
                }
                if (res == 1)
                    alert("保存成功");

            }
        }
        sorts = topicBll.GetTopiciSort();
    }


}