using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class BasicInfo_SecondPointInfo : BasePage
{
    public static int FirstId;
    PointService pointService = new PointService();
    public static string FirstPointName;
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            //初始化一级知识点Id
            if(Request.QueryString["id"] != null)
            {
                int firstId = int.Parse(Request.QueryString["id"]);
                FirstId = firstId;
                FirstPointName = pointService.GetFirstPoint(FirstId).FirstPointName;
            }

            if (FirstId == 0)
                Response.Redirect("PointInfo.aspx");

            BindSecondPoint(FirstId);

        }
        if (FirstId == 0)
            Response.Redirect("PointInfo.aspx");
       // alert(FirstId.ToString());
    }


    public void BindSecondPoint(int firstId)
    {
        Repeater1.DataSource = pointService.GetSecondPoints(firstId);
        Repeater1.DataBind();
    }

    //添加
    protected void Add_btn_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("SecondPointId"));
        dt.Columns.Add(new DataColumn("SecondPointName"));
        dt.Columns.Add(new DataColumn("SecondPointOrder"));

        foreach (RepeaterItem item in Repeater1.Items)
        {
            try
            {
                DataRow dr = dt.NewRow();
                dr["SecondPointId"] = ((Label)item.FindControl("Label1")).Text;
                dr["SecondPointName"] = ((TextBox)item.FindControl("TextBox1")).Text;
                dr["SecondPointOrder"] = ((TextBox)item.FindControl("TextBox2")).Text;
                dt.Rows.Add(dr);
            }
            catch (Exception ex)
            {

            }
        }
        DataRow drA = dt.NewRow();
        drA["SecondPointId"] = "0";
        drA["SecondPointName"] = "";
        drA["SecondPointOrder"] = "";
        dt.Rows.Add(drA);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }

    //保存修改
    protected void save_btn_Click(object sender, EventArgs e)
    {
        int res = 0;
        for (int i = 0; i < Repeater1.Items.Count; i++)
        {
            int deccomdId = int.Parse(((Label)Repeater1.Items[i].FindControl("Label1")).Text.ToString());
            string secondPointName = ((TextBox)Repeater1.Items[i].FindControl("TextBox1")).Text.ToString();
            string decondPointOrder = ((TextBox)Repeater1.Items[i].FindControl("TextBox2")).Text.ToString();
            

            if (secondPointName != "" && decondPointOrder.ToString() != "")
            {

                if (!Public.isNumberic(decondPointOrder))
                {
                    alert("请输入合法的排序号");
                    return;
                }

                SecondPoint point = new SecondPoint()
                {
                    SecondPointId = deccomdId,
                    FIrstPointId = FirstId,
                    SecondPointName  = secondPointName,
                    SecondPointOrder = int.Parse(decondPointOrder)
                };
                //alert(pointService.isHaveSecond(FirstId, point.SecondPointName).ToString());
                if (pointService.isHaveSecond(FirstId, point.SecondPointName) && point.SecondPointId == 0)
                {
                    alert(point.SecondPointName + "已存在，请勿重复添加");
                    return;
                }
                res = pointService.SaveSecondPoint(point);
            }

            else
            {
                alert("知识点信息不能为空");
                return;
            }


            if (res == 0)
                alert("保存失败");
        }
        if (res == 1)
        {
            alert("保存成功");
            BindSecondPoint(FirstId);
         
        }
    }

    //删除
    protected void delete_brn_Click(object sender, EventArgs e)
    {
        int res = 0;
        for (int i = 0; i < Repeater1.Items.Count; i++)
        {

            CheckBox ck = (CheckBox)Repeater1.Items[i].FindControl("CheckBox1");
            if (ck.Checked == true)
            {
                int secondId = int.Parse(((Label)Repeater1.Items[i].FindControl("Label1")).Text.ToString());
                if (secondId != 0)
                {
                    if (pointService.SecondPointHasTopic(secondId))
                    {
                        alert(pointService.GetFirstPoint(secondId).FirstPointName
                            + " 存在二级知识点, 无法删除");
                    }
                    else
                    {
                        res = pointService.DeleteSecond(secondId);
                        if (res == 0)
                        {
                            alert("删除失败");
                            break;
                        }
                    }
                }

                
            }
        }
        if (res == 1)
        {
            alert("删除成功");
            
        }
        BindSecondPoint(FirstId);
    }

    //返回
    protected void back_btn_Click(object sender, EventArgs e)
    {
        Response.Redirect("PointInfo.aspx");
    }
}