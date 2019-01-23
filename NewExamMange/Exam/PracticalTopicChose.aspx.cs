using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Exam_Default : System.Web.UI.Page
{
    public TopicBLL topicBll = new TopicBLL();
    public static int totalPage;
    public static int pageNumber = 1;
    public static int count;
    public static string para = "";
    public static List<PracticalTopic> topics = new List<PracticalTopic>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["para"] != null)
        {
            para = Request.QueryString["para"].ToString();
            pageNumber = int.Parse(Request.QueryString["pageNumber"]);
            
        }

        BindTopic();

    }

    public void BindTopic()
    {
        topics = topicBll.GetPracticalTopicsByPage(ref pageNumber, ref totalPage, para, ref count, 1);
    }
}