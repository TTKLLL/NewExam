using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_ExamMain : BasePage
{
    DataClassesDataContext db = new DataClassesDataContext();
    public string examId;
    public string studentId;
    public string endTime;
    PagedDataSource pds = new PagedDataSource();
    StuExamBLL stuExamBll = new StuExamBLL();
    

    private static string Param;  //向本页面传递的参数

    private static int Flag = 0;
    private static int Flag2 = 0;

    ExamBLL examBll = new ExamBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (examBll.GetChoseExamType() == 2)
            Response.Redirect("PracticalExam.aspx");
        Flag++;
        //  if (Request.Cookies["examId"] == null || Session["sId"] == null)
        if (Request.Cookies["examId"] == null || Request.Cookies["sId"] == null)
        {

            Response.Redirect("StuLogIn.aspx");
        }
        else
        { 
            studentId = Request.Cookies["sId"].Value.ToString();
            examId = Request.Cookies["examId"].Value.ToString();

            if (examBll.StueIsHaveSumbitPaper(studentId, examId))
            {
                alert("该考生已交卷", "StuLogIn.aspx");
            }

            pds.AllowPaging = true;
            pds.PageSize = 1;


            studentId = Request.Cookies["sId"].Value.ToString();

            if (!IsPostBack)
            {
                bindHeadLine();//绑定试卷标题
                bindStuInfo();  //绑定学生信息

                if (!IsPostBack)
                    bindAllTitleList(); //绑定所有题型

                if (Request.QueryString["page"] != null)
                {
                    int index = int.Parse(Request.QueryString["page"]);
                    string sortId = Request.QueryString["sortId"].ToString();

                    BindTitle(sortId, index);
                }
                else
                {
                    //获取第一个题型
                    if (AllTitleList.Items.Count > 0)
                    {
                        string sortId = ((Label)AllTitleList.Items[0].FindControl("SortId")).Text.ToString();
                        Repeater seondRes = (Repeater)AllTitleList.Items[0].FindControl("theTitleList");
                        if (seondRes.Items.Count > 0)
                        {
                            BindTitle(sortId, 0);
                        }
                    }
                }

            }
        }
    }


    //绑定所有题型
    protected void bindAllTitleList()
    {
        ExamBLL examBll = new ExamBLL();
        Exam nowExam = examBll.GetNowExam();
        if (nowExam != null)
        {
            StuExamBLL stuExamBll = new StuExamBLL();
            List<Sort> sorts = stuExamBll.GetExamTopicBySort(studentId, nowExam.ExamId.ToString());

            AllTitleList.DataSource = sorts;
            AllTitleList.DataBind();
        }


    }

    //绑定试卷标题
    protected void bindHeadLine()
    {
        ExamBLL exambll = new ExamBLL();
        Exam nowExam = examBll.GetNowExam();

        string examName = examBll.GetExamName(nowExam);
        if (examName == null || examName == "")
        {
            //Response.Write("<script>alert('获取试卷信息有误')</script>");
            Response.Redirect("StuLogIn.aspx");
        }

        headLine.Text = examName;
        endTime = nowExam.ExamEndTime.ToString();
    }

    //绑定学生信息
    protected void bindStuInfo()
    {

        StuExamBLL stuExamBll = new StuExamBLL();
        Student student = stuExamBll.GetStuInfo(studentId);
        if (student != null)
        {
            Sname.Text = student.StudentName;
            Sno.Text = student.StudentId;
        }

    }



    //所有题型
    protected void AllTitleList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Label SortIdLabel = (Label)e.Item.FindControl("SortId");
        string sortId = SortIdLabel.Text.ToString();

        Repeater TheTitleList = (Repeater)e.Item.FindControl("theTitleList");
        Label WaitNumberLabe = (Label)e.Item.FindControl("WaitNumber");  //已做题目数量
        Label TotalNumberLabe = (Label)e.Item.FindControl("TotalNumber");  //题目数量

        Flag2++;
        if (Flag2 == 1)
        {

            Param = "&sortId=" + SortIdLabel.Text;
        }
        if (Flag == 1 && Flag2 == 1)
        {
            BindTitle(sortId, 0); //第一次进入该页面时显示第一题
        }

        StuExamBLL stuExamBll = new StuExamBLL();

        int hasDoTopic = 0; //已做的题目数量

        List<StuExamTopic> stuExamTopics = stuExamBll.GetExamTopicBySortId(studentId, examId, sortId);
        foreach (var item in stuExamTopics)
        {
            if (item.StuAnswer != null && item.StuAnswer.Trim() != "")
                hasDoTopic++;
        }
        WaitNumberLabe.Text = hasDoTopic.ToString();
        TotalNumberLabe.Text = stuExamTopics.Count().ToString();

        TheTitleList.DataSource = stuExamTopics;
        TheTitleList.DataBind();
    }

    //某种题型
    protected void theTitleList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //  设置题目序号颜色
        int titleId = int.Parse(((Label)e.Item.FindControl("TopicId")).Text);
        int sortId = int.Parse(((Label)e.Item.FindControl("SortId")).Text);
        int page = int.Parse(((Label)e.Item.FindControl("Page")).Text);

        string StuAnswer = ((Label)e.Item.FindControl("StuAnswer")).Text;


        HyperLink titleLink = (HyperLink)e.Item.FindControl("HyperLink1");
        titleLink.NavigateUrl = "?page=" + page + "&sortId=" + sortId;

        if (StuAnswer != null && StuAnswer != "")
            titleLink.Attributes.CssStyle.Value = "background-color: #0088CC";
    }

    //绑定题目
    protected void BindTitle(string sortId, int index)
    {
        Param = "&sortId=" + sortId;  //动态修改传递参数的值
        List<StuExamTopic> topics = stuExamBll.GetExamTopicBySortId(studentId, examId, sortId);

        int length = topics.Count();
        if (index > length - 1)
            Response.Redirect("ExamMain.aspx");

        pds.DataSource = topics;
        pds.CurrentPageIndex = index;

        string nowTitleId = topics[index].TopicId.ToString();

        //设置当前题目的序号为红色
        for (int i = 0; i < AllTitleList.Items.Count; i++)
        {
            Repeater theTitleList = (Repeater)AllTitleList.Items[i].FindControl("theTitleList");
            for (int j = 0; j < theTitleList.Items.Count; j++)
            {
                string thetitleId = ((Label)theTitleList.Items[j].FindControl("TopicId")).Text;
                if (thetitleId == nowTitleId)
                    ((HyperLink)theTitleList.Items[j].FindControl("HyperLink1")).Attributes.CssStyle.Value = "background-color:red";
            }
        }
        Single.Visible = true;
        Single.DataSource = pds;
        Single.DataBind();



    }


    public void show(string str)
    {
        // Response.Write("<script>alert('" + str + "')<script>");
        ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", "alert('" + str + "');", true);
    }

    //提交单选题 
    protected void SingleRadio1_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton radioButton = (RadioButton)sender;
        string stuAnswer = radioButton.Text.Trim();
        RepeaterItem repeaterItem = (RepeaterItem)radioButton.NamingContainer;
        string SortId = ((Label)repeaterItem.FindControl("SortId")).Text;
        try
        {
            string TopicId = ((Label)repeaterItem.FindControl("TopicId")).Text;
            int index = int.Parse(((Label)repeaterItem.FindControl("Number")).Text.Trim()) - 1;

            int res = stuExamBll.UpdateStuAns(studentId, examId, TopicId, stuAnswer);

            if (res <= 0)
            {
                BindTitle(SortId, index);
            }
        }
        catch (Exception ex)
        {
            BindTitle(SortId, pds.CurrentPageIndex);
        }


    }

    //提交多选题答案
    protected void MultipleCheck1_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ck = (CheckBox)sender;
        RepeaterItem repeterItem = (RepeaterItem)ck.NamingContainer;
        int titleId = int.Parse(((Label)repeterItem.FindControl("TopicId")).Text);
        string SortId = ((Label)repeterItem.FindControl("SortId")).Text;
        CheckBox ckA = (CheckBox)repeterItem.FindControl("MultipleCheck1");
        CheckBox ckB = (CheckBox)repeterItem.FindControl("MultipleCheck2");
        CheckBox ckC = (CheckBox)repeterItem.FindControl("MultipleCheck3");
        CheckBox ckD = (CheckBox)repeterItem.FindControl("MultipleCheck4");

        string answer = "";
        if (ckA.Checked)
            answer += "A";
        if (ckB.Checked)
            answer += "B";
        if (ckC.Checked)
            answer += "C";
        if (ckD.Checked)
            answer += "D";


        try
        {
            string TopicId = ((Label)repeterItem.FindControl("TopicId")).Text;
            int index = int.Parse(((Label)repeterItem.FindControl("Number")).Text.Trim()) - 1;

            int res = stuExamBll.UpdateStuAns(studentId, examId, TopicId, answer);

            if (res <= 0)
            {
                BindTitle(SortId, index);
            }
        }
        catch (Exception ex)
        {
            BindTitle(SortId, pds.CurrentPageIndex);
        }

    }

    //绑定单选题目
    protected void Single_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //Label SortIdLabel = (Label)e.Item.FindControl("SortId");
        Label TitleTypeLabel = (Label)e.Item.FindControl("TopicType");
        Panel singlePanel = (Panel)e.Item.FindControl("Panel1");
        Panel multiplePanel = (Panel)e.Item.FindControl("Panel2");

        string answer = ((Label)e.Item.FindControl("StuAnswer")).Text.Trim();
        if (TitleTypeLabel.Text.Trim().Contains("多"))  //多选题
        {
            singlePanel.Visible = false;

            //绑定学生已做的答案
            int titleId = int.Parse(((Label)e.Item.FindControl("TopicId")).Text);


            CheckBox ckA = (CheckBox)e.Item.FindControl("MultipleCheck1");
            CheckBox ckB = (CheckBox)e.Item.FindControl("MultipleCheck2");
            CheckBox ckC = (CheckBox)e.Item.FindControl("MultipleCheck3");
            CheckBox ckD = (CheckBox)e.Item.FindControl("MultipleCheck4");

            if (answer != null)
            {
                if (answer.Contains("A"))
                    ckA.Checked = true;
                if (answer.Contains("B"))
                    ckB.Checked = true;
                if (answer.Contains("C"))
                    ckC.Checked = true;
                if (answer.Contains("D"))
                    ckD.Checked = true;
            }

        }
        else
        {
            multiplePanel.Visible = false;

            //绑定学生已做的答案 


            RadioButton rA = (RadioButton)e.Item.FindControl("SingleRadio1");
            RadioButton rB = (RadioButton)e.Item.FindControl("SingleRadio2");
            RadioButton rC = (RadioButton)e.Item.FindControl("SingleRadio3");
            RadioButton rD = (RadioButton)e.Item.FindControl("SingleRadio4");

            switch (answer)
            {
                case "A": rA.Checked = true; break;
                case "B": rB.Checked = true; break;
                case "C": rC.Checked = true; break;
                case "D": rD.Checked = true; break;
                default: break;
            }
        }

        //题目序号
        ((Label)e.Item.FindControl("Number")).Text = (pds.CurrentPageIndex + 1).ToString();

        //设置翻页链接
        int count = pds.PageCount;
        int i = pds.CurrentPageIndex;
        HyperLink pre = (HyperLink)e.Item.FindControl("Pre");
        HyperLink next = (HyperLink)e.Item.FindControl("Next");

        pre.NavigateUrl = "";
        pre.NavigateUrl = "";

        if (i <= 0)
        {
            pre.Enabled = false;
            next.Enabled = true;
        }
        else
            pre.NavigateUrl = "?page=" + (i - 1) + Param;

        if (i >= count - 1)
        {
            pre.Enabled = true;
            next.Enabled = false;
        }
        else
            next.NavigateUrl = "?page=" + (i + 1) + Param;

    }





    //交卷
    protected void Submit_Click(object sender, EventArgs e)
    {
        int flag = 1;
        foreach (RepeaterItem item in AllTitleList.Items)
        {
            Label WaitNumberLabe = (Label)item.FindControl("WaitNumber");  //已做题目数量
            Label TotalNumberLabe = (Label)item.FindControl("TotalNumber");  //题目数量
            if (int.Parse(WaitNumberLabe.Text) != int.Parse(TotalNumberLabe.Text))
            {
                flag = 0;
                break;
            }
        }
        if (flag == 0)
            show("题目未做完");

        //db.proc_EndExam(studentId, int.Parse(examId));
        //Response.Redirect("~/Student/StuLogIn.aspx");
    }
}