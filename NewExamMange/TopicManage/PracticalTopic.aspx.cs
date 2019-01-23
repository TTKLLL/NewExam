using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TopicManage_PracticalTopic : BasePage
{
    public TopicBLL topicBll = new TopicBLL();
    public static int totalPage;
    public static int pageNumber = 1;
    public static int count;
    public static string para  ="";
    public static List<PracticalTopic> topics = new List<PracticalTopic>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["para"] != null)
            {
                para = Request.QueryString["para"].ToString();
                pageNumber = int.Parse(Request.QueryString["pageNumber"]);
         
            }
            if(Request.QueryString["delete"] != null)
            {
                string tId = Request.QueryString["tId"];
                string res = topicBll.DeletePracTopic(tId);
                if (res == "success")
                    SuAlert("删除成功");
                else
                    errAlert(res);
            }

            BindTopic();
        }
    }

    public void BindTopic()
    {
        topics = topicBll.GetPracticalTopicsByPage(ref pageNumber, ref totalPage, para, ref count);
    }
}