using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_TopicManage_AddTopic : BasePage
{

    public static Topic topic = new Topic();
    public TopicBLL topicBll = new TopicBLL();

    public static List<Sort> sort = new List<Sort>();
    public static List<TopicSource> topicSource = new List<TopicSource>();
    public static List<FirstPoint> firstPoint = new List<FirstPoint>();
    public static List<SecondPoint> secondPoint = new List<SecondPoint>();
    public static List<string> topicType = new List<string>();

    DataClassesDataContext db = new DataClassesDataContext();

    public static string TopicId = "";

    protected void Page_Load(object sender, EventArgs e)
    {
     
        if (!IsPostBack)
        {
            if (Request.QueryString["topicId"] != null)
            {
                TopicId = Request.QueryString["topicId"];
                BindData();
            }
        }

        if (TopicId != "")
            BindData();
    }
    public void BindData()
    {
        topic = topicBll.GetTopicByTid(int.Parse(TopicId.ToString()));
        sort = topicBll.GetTpicSort();

        topicSource = topicBll.GetTopicSource();
        firstPoint = new PointService().GetFirstPoint();
        topicType = topicBll.GetTopicType();

        SecondPoint second = new PointService().GetSecondPointById(int.Parse(topic.SecondPointId.ToString()));
        secondPoint = new PointService().GetSecondPoints(int.Parse(second.FIrstPointId.ToString()));
    }


   
  
}