<%@ WebHandler Language="C#" Class="OutTopic" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.IO;
using System.Text;

using System.Data.OleDb;
public class OutTopic : IHttpHandler
{
    //导出题目
    TopicBLL topicBll = new TopicBLL();

      public void ProcessRequest(HttpContext context)
    {

        TopicQuery query = new TopicQuery();
        //获取查询参数
        if (context.Request.QueryString["first"] != null)
        {
            string first = context.Request.QueryString["first"].ToString();
            string second = context.Request.QueryString["second"].ToString();
            query = new TopicQuery()
            {
                FirstPointId = int.Parse(first),
                SecondPointId = int.Parse(second),

                TopicSourceId = int.Parse(context.Request.QueryString["source"].Trim().ToString()),
                SortId = int.Parse(context.Request.QueryString["sort"].Trim().ToString()),
                TopicType = context.Request.QueryString["type"].Trim().ToString(),
                TopicTitle = context.Request.QueryString["topicTitle"].Trim().ToString(),
                TopicState = int.Parse(context.Request.QueryString["TopicState"].Trim().ToString())

            };

            List<ImputTopic> topics = topicBll.GetTopicsByQuery(query);





            string filePath = context.Server.MapPath("../ExcelTemplet/Temp/" + Guid.NewGuid().ToString() + ".xls");
            File.Copy(context.Server.MapPath("../ExcelTemplet/Problem.xls"), filePath);
            //使用OleDb驱动程序连接到副本
            OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
            using (conn)
            {
                conn.Open();
                int index = 0;
                //增加记录
                foreach (var item in topics)
                {
                    StringBuilder sql = new StringBuilder();
                    sql.Append("INSERT INTO [Sheet1$]([序号],[题目],[选项A],[选项B],[选项C],[选项D],[答案],[一级知识点],[二级知识点],[题目类别],[题目类型],[题库名称]) VALUES('")
                        .Append((++index).ToString()).Append("','").Append(item.TopicTitle).Append("','")
                        .Append(item.OptionA).Append("','").Append(item.OptionB).Append("','").Append(item.OptionC).Append("','").Append(item.OptionD).Append("','")
                        .Append(item.TitleAnswer).Append("','").Append(item.FirstPointName).Append("','").Append(item.SecondPointName).Append("','")
                        .Append(item.SortName).Append("','").Append(item.TopicType)
                        .Append("','").Append(item.TopicSourceName).Append("')");


                    OleDbCommand cmd = new OleDbCommand(sql.ToString(), conn);
                    cmd.ExecuteNonQuery();

                }
                conn.Close();
                // 输出副本的二进制字节流
                context.Response.ContentType = "application/ms-excel";
                context.Response.AppendHeader("Content-Disposition", "attachment;filename=" + "在线考试系统题库 " + DateTime.Now.ToLocalTime() + ".xls");
                context.Response.BinaryWrite(File.ReadAllBytes(filePath));
                // 删除副本
                File.Delete(filePath);
            }

        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}