using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BasicInfo_AllPoints : BasePage
{
    public PointService pointService = new PointService();
    public List<Point> allPoints;
    public static int pageNumber = 1; //当前页号
    public static long totalPage = 0;//中页数


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["pageNumber"] != null)
        {
            pageNumber = int.Parse(Request.QueryString["pageNumber"].ToString());
            allPoints = pointService.GetAllPoints(ref pageNumber, ref totalPage);
        }
        else
        {
            allPoints = pointService.GetAllPoints(ref pageNumber, ref totalPage);
            
        }
       
       
    }
}