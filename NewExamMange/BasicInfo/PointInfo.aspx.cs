using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;



public partial class BasicInfo_PointInfo : BasePage
{
    public List<FirstPoint> FirstPoints = new List<FirstPoint>();
    PointService pointService = new PointService();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindFirstPoint();
        }

    }

    public void BindFirstPoint()
    {
        FirstPoints = new PointService().GetFirstPointByPage(1);
        Repeater1.DataSource = FirstPoints;
        Repeater1.DataBind();
    }
    public void alert(string str)
    {
        Response.Write("<script>alert('" + str + "')</script>");
    }

    //删除一级知识点
    protected void delete_btn_Click(object sender, EventArgs e)
    {
        int res = 0;
        for (int i = 0; i < Repeater1.Items.Count; i++)
        {

            CheckBox ck = (CheckBox)Repeater1.Items[i].FindControl("CheckBox1");
            if (ck.Checked == true)
            {
                int firstdId = int.Parse(((Label)Repeater1.Items[i].FindControl("idLabel")).Text.ToString());
                if (firstdId != 0)
                {
                    if (pointService.HasSecond(firstdId))
                    {
                        alert(pointService.GetFirstPoint(firstdId).FirstPointName
                            + " 存在二级知识点, 无法删除");
                        return;
                    }
                    else
                    {
                        res = pointService.DeleteFirst(firstdId);
                        if (res == 0)
                        {
                            alert("删除失败");
                            return;
                        }
                    }
                }

            }
        }
        if (res == 1)
        {
            alert("删除成功");

        }
        BindFirstPoint();


    }

    //保存修改
    protected void save_btn_Click(object sender, EventArgs e)
    {

        int res = 0;
        for (int i = 0; i < Repeater1.Items.Count; i++)
        {

            

            int firstId = int.Parse(((Label)Repeater1.Items[i].FindControl("idLabel")).Text.ToString());
            string firstPointName = ((TextBox)Repeater1.Items[i].FindControl("FirstPointName_td")).Text.ToString();
            string firstPointOrder = ((TextBox)Repeater1.Items[i].FindControl("FirstPointOrder_td")).Text.ToString();

            if (!Public.isNumberic(firstPointOrder))
            {
                alert("请输入合法的排序号");
                return;
            }

            if (firstPointName != "" && firstPointOrder.ToString() != "")
            {
                FirstPoint point = new FirstPoint()
                {
                    FirstPointId = firstId,
                    FirstPointName = firstPointName,
                    FirstPointOrder = int.Parse(firstPointOrder)
                };
                if (pointService.isHaveFist(point.FirstPointName) && firstId == 0)
                {
                    alert(point.FirstPointName + "已存在, 请务重复添加");
                    return;
                }

                res = pointService.SaveFirstPoint(point);
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
            BindFirstPoint();
        }
    }

    //添加知识点
    protected void addPoint_btn_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("FirstPointId"));
        dt.Columns.Add(new DataColumn("FirstPointName"));
        dt.Columns.Add(new DataColumn("FirstPointOrder"));

        foreach (RepeaterItem item in Repeater1.Items)
        {
            try
            {
                DataRow dr = dt.NewRow();
                dr["FirstPointId"] = ((Label)item.FindControl("idLabel")).Text;
                dr["FirstPointName"] = ((TextBox)item.FindControl("FirstPointName_td")).Text;
                dr["FirstPointOrder"] = ((TextBox)item.FindControl("FirstPointOrder_td")).Text;
                dt.Rows.Add(dr);
            }
            catch (Exception ex)
            {

            }
        }
        DataRow drA = dt.NewRow();
        drA["FirstPointId"] = "0";
        drA["FirstPointName"] = "";
        drA["FirstPointOrder"] = "";
        dt.Rows.Add(drA);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }

    //编辑二级知识点
    protected void editSecond_btn_Click(object sender, EventArgs e)
    {
        foreach (RepeaterItem item in Repeater1.Items)
        {
            CheckBox ck = (CheckBox)item.FindControl("CheckBox1");
            if (ck.Checked == true)
            {
                int firstId = int.Parse(((Label)item.FindControl("idLabel")).Text.ToString());
                if(firstId == 0)
                {
                    alert("请选择有效的一级知识点");
                    return;
                }
                Response.Redirect("SecondPointInfo.aspx?id=" + firstId);
            }
        }
        alert("请选择一个以及知识点");

    }
}