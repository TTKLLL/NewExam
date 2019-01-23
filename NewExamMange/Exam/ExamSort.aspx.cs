using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Exam_ExamSort : BasePage
{
    TopicBLL topicBll = new TopicBLL();
    public static int totalScore = 0;  //总分
    public static List<ExamSort> examSorts;
    protected void Page_Load(object sender, EventArgs e)
    {
        BindData();

        //保存修改
        if (Request.Form["SortId"] != null)
        {
            Array ids = Request.Form["SortId"].ToString().Split(',');
            Array numbers = Request.Form["TopicSortNumber"].ToString().Split(',');
            Array scores = Request.Form["TopicSortScore"].ToString().Split(',');

            for (int i = 0; i < ids.Length; i++)
            {

                Sort sort = new Sort()
                {
                    SortId = int.Parse(ids.GetValue(i).ToString()),
                    TopicSortNumber = int.Parse(numbers.GetValue(i).ToString()),
                    TopicSortScore = int.Parse(scores.GetValue(i).ToString())
                };

                ExamBLL examBll = new ExamBLL();
                if (examBll.UpdateExamSort(sort) < 0)
                {
                    alert("修改失败");
                    return;
                }
            }
            BindData();

            alert("修改成功", "ExamSort.aspx");

        }
        BindData();
    }

    public void BindData()
    {
        totalScore = 0;
        List<Sort> sorts = topicBll.GetTopiciSort();
        List<ExamSort> temp_sort = new List<ExamSort>();
        foreach (var item in sorts)
        {
            int maxNumber = topicBll.GetNumberOfTopicBySort(item.SortId.ToString());
            ExamSort examSort = new ExamSort()
            {
                SortId = item.SortId,
                SortName = item.SortName,
                TopicSortScore = item.TopicSortScore,
                TopicSortNumber = item.TopicSortNumber,
                CanUseNumber = maxNumber
            };

            temp_sort.Add(examSort);
            totalScore += int.Parse((examSort.TopicSortNumber * examSort.TopicSortScore).ToString());
        }
        examSorts = temp_sort;
    }




}