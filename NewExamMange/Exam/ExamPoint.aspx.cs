using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Exam_ExamPoint :  BasePage
{

    public static List<ExamPoint> ExamPoint_S = new List<ExamPoint>();
    PointService pointBll = new PointService();
    protected void Page_Load(object sender, EventArgs e)
    {
        BindPoitn();
    }

    public void BindPoitn()
    {
        List<ExamPoint> exam_temp = new List<ExamPoint>();
        List<FirstPoint> first = pointBll.GetFirstPoint();
        if (first != null)
        {
            foreach (var item in first)
            {
                ExamPoint examPoint = new ExamPoint();
                examPoint.firstPoint = item;
                examPoint.IsAllChose = pointBll.SecondHaveAllChose(int.Parse(item.FirstPointId.ToString()));

                List<secondPont> second = pointBll.GetSecondPoint_Plus(int.Parse(item.FirstPointId.ToString()));
                if (second != null)
                {
                    foreach (var subItem in second)
                    {
                        examPoint.secondPoints.Add(subItem);
                    }
                    exam_temp.Add(examPoint);
                }

            }
            ExamPoint_S = exam_temp;
        }



    }

}