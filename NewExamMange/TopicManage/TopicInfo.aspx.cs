using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_TopicManage_ManageTopic : BasePage
{
    public TopicBLL topicBll = new TopicBLL();

    public static List<Sort> sort = new List<Sort>();
    public static List<string> topicType = new List<string>();
    public static List<TopicSource> topicSource = new List<TopicSource>();
    public static List<FirstPoint> firstPoint = new List<FirstPoint>();


    //题目详情部分
    public static Topic topic = new Topic();

    public static List<SecondPoint> secondPoint = new List<SecondPoint>();


    DataClassesDataContext db = new DataClassesDataContext();

    public static string TopicId = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["ExamType"] == null)
        {
            Response.Write("<script>window.parent.location.href = '../LogIn.aspx'</script>");
        }
        else if (Request.Cookies["ExamType"].Value == ((int)AuthorityBLL.AuthorityExamType.Practical).ToString())
            Response.Redirect("PracticalTopic.aspx");

        if (!IsPostBack)
        {
            bindInfo();

            BindData();
        }
    }

    //绑定题目列表
    public void bindInfo()
    {
        sort = topicBll.GetTpicSort();
        topicType = topicBll.GetTopicType();
        topicSource = topicBll.GetTopicSource();
        firstPoint = new PointService().GetFirstPoint();
    }

    //绑定某个题目
    public void BindData()
    {
        sort = topicBll.GetTpicSort();

        topicSource = topicBll.GetTopicSource();
        firstPoint = new PointService().GetFirstPoint();
        topicType = topicBll.GetTopicType();
    }

}