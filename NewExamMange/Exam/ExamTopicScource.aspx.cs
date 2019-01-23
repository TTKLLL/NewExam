using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Exam_ExamBasicInfo : BasePage
{
    public static List<TopicSource> source;
    public TopicBLL topicBll = new TopicBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["ExamType"] == null)
        {
            Response.Write("<script>window.parent.location.href = '../LogIn.aspx'</script>");
        }
        else if (Request.Cookies["ExamType"].Value == ((int)AuthorityBLL.AuthorityExamType.Practical).ToString())

            Response.Redirect("PracticalTopicChose.aspx");
        else

            source = topicBll.GetAllSource();
    }
}