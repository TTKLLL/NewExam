using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GradeManger_ExamList : BasePage
{
    DataClassesDataContext db = new DataClassesDataContext();
    string Query = "";
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack == true)
        {

           //// if (Session["uId"] == null || Session["uId"].ToString() == string.Empty)
           // if()
           // {

           //     ClientScript.RegisterClientScriptBlock(this.GetType(), "error", "<script>alert('登录过期，请重新登录！');window.parent.location='../Login.aspx'</script>");
           //     return;
           // }

            if (Request.QueryString["Query"] != null)
            {
                Query = Request.QueryString["Query"].ToString();

            }

            tb_Query.Text = Query;
            BindData();

        }
    }



    //获取次考试开始时间
    public String GetTheExamBeginTime(string theExamId)
    {
        var query = db.Exam.Where(t => t.TheExamId == int.Parse(theExamId)).OrderBy(t => t.ExamBegTime);

        int count = query.Count();
        if (count == 0)
            return "该考试暂无场次";
        else
        {
            List<Exam> exams = query.ToList();

            DateTime? minTime = exams[0].ExamBegTime;
            foreach (var item in exams)
            {
                if (item.ExamBegTime < minTime)
                    minTime = item.ExamBegTime;
            }

            return minTime.ToString();
        }
    }

    //获取次考试结束时间
    public String GetTheExamEndTime(string theExamId)
    {
        var query = db.Exam.Where(t => t.TheExamId == int.Parse(theExamId)).OrderBy(t => t.ExamBegTime);

        int count = query.Count();
        if (count == 0)
            return "该考试暂无场次";
        else
        {
            List<Exam> exams = query.ToList();
            DateTime? maxTime = exams[0].ExamBegTime;
            foreach (var item in exams)
            {
                if (item.ExamEndTime > maxTime)
                    maxTime = item.ExamEndTime;
            }
            return maxTime.ToString();
        }
    }
  public void BindData()
    {
        //(from p in db.TheExam
        // join b in db.Exam on p.TheExamId equals b.TheExamId
        // join c in db.Paper on b.ExamId equals c.ExamId
        // join d in db.StuExam on c.PaperId equals d.PaperId
        // group new
        // {
        //     p.TheExamId,
        //     p.TheExamName,
        //     begintime = GetTheExamBeginTime(p.TheExamId.ToString()),
        //     endExamtime = GetTheExamEndTime(p.TheExamId.ToString()),
        // } by new { p.TheExamId } into grps
        // select new
        // {
        //     TheExamid = grps.Key.TheExamId,
        //     ExamStuCount = grps.Count()
        // });
      var resultTheExam = (from p in db.TheExam   
                         join b in db.Exam on p.TheExamId  equals b.TheExamId  
                         join c in db.Paper on b.ExamId equals c.ExamId
                         join d in db.StuExam on c.PaperId equals d.PaperId 
                         where p.TheExamName.Contains(Query)
                         group  new {p.TheExamId }
                        by new{p.TheExamId,p.TheExamName} into grps
                        //orderby  GetTheExamBeginTime(grps.Key.TheExamId.ToString()).ToString() descending
                        select  new{
                        TheExamid=grps.Key.TheExamId,
                        begintime = GetTheExamBeginTime(grps.Key.TheExamId.ToString()),
                        TheExamName=grps.Key.TheExamName,
                        endExamtime = GetTheExamEndTime(grps.Key.TheExamId.ToString()),
                        ExamStuCount=grps.Count()
                        }).ToList();

 

        //   数据源
        PagedDataSource Pgds = new PagedDataSource();
        //        
        Pgds.DataSource = resultTheExam;
        //        设置允许分页
        Pgds.AllowPaging = true;
        //        每页显示为15行
        Pgds.PageSize = 15;
        //        显示总共页数
        //
        lblTotalPage.Text = Pgds.PageCount.ToString();
        //        当前页
        int CurrentPage;
        //        请求页码为不为null设置当前页，否则为第一页
        if (Request.QueryString["Page"] != null)
        {
            CurrentPage = Convert.ToInt32(Request.QueryString["Page"]);
        }

        else
        {
            CurrentPage = 1;
        }
        //   当前页所引为页码-1
        Pgds.CurrentPageIndex = CurrentPage - 1;
        //   显示当前页码
        lblCurrentPage.Text = CurrentPage.ToString();
        //   如果不是第一页，通过参数Page设置上一页为当前页-1，否则不显示连接
        if (!Pgds.IsFirstPage)
        {
            //            Request.CurrentExecutionFilePath为当前请求虚拟路径
            lnkPrev.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage - 1) + "&Query=" + Query;
        }
        //        End If
        //   如果不是最后一页，通过参数Page设置下一页为当前页+1，否则不显示连接
        if (!Pgds.IsLastPage)
        {
            //    Request.CurrentExecutionFilePath为当前请求虚拟路径
            lnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurrentPage + 1) + "&Query=" + Query;
        }
        //   模板绑定数据源  
        rp_TeaInfo.DataSource = Pgds;
        rp_TeaInfo.DataBind();




    }


   // public string GettheExam(string theExamId) { 
    
   //var resut=(from f in db.TheExam where f.TheExamId==Int32.Parse(theExamId)  select new {f.TheExamName});
   




    
   // return  
    
   // }

    protected void bt_Skip_Click(object sender, EventArgs e)
    {

        Query = tb_Query.Text;
        Response.Redirect("ExamList.aspx?Query=" + Query + "&Page=" + lblCurrentPage.Text);
    }
    protected void bt_Query_Click(object sender, EventArgs e)
    {
        Query = tb_Query.Text;
        Response.Redirect("ExamList.aspx?Query=" + Query + "&Page=1");
    }
}