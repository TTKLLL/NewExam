<%@ WebHandler Language="C#" Class="OutPutSut" %>

using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public class OutPutSut : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string query = context.Request.QueryString["para"];
        int state = int.Parse(context.Request.QueryString["state"]);
        string ExamName = context.Request.QueryString["fileName"];
        List<Student> students = new StudentBLL().GetAllStudentByQuery(query, state);


        var FileAndTitleName = ExamName;

        string filePath = context.Server.MapPath("../ExcelTemplet/Temp/" + Guid.NewGuid().ToString() + ".xls");
        File.Copy(context.Server.MapPath("../ExcelTemplet/StudentInfo.xls"), filePath);
        //使用OleDb驱动程序连接到副本
        OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
        using (conn)
        {
            conn.Open();
            int index = 0;
            //增加记录
            foreach (var item in students)
            {
                StringBuilder sql = new StringBuilder();
                sql.Append("INSERT INTO [Sheet1$]([序号],[学号],[姓名],[班级],[手机号]) VALUES('")
                    .Append((++index).ToString()).Append("','").Append(item.StudentId).Append("','")
                    .Append(item.StudentName).Append("','").Append(item.Class)
                    .Append("','").Append(item.StudentPhone).Append("')");

                //sql.Append("INSERT INTO [Sheet1$]([序号],[班级],[学号],[姓名],[考试科目],[成绩]) VALUES（'").Append(item.rowid).Append("','").Append(item.Class).Append("','").Append(item.StudentId).Append("','").Append(item.StudentName).Append("','").Append(item.ExameTitle).Append("','").Append(item.Score).Append("')");
                OleDbCommand cmd = new OleDbCommand(sql.ToString(), conn);
                cmd.ExecuteNonQuery();

            }
            conn.Close();
            // 输出副本的二进制字节流
            context.Response.ContentType = "application/ms-excel";
            context.Response.AppendHeader("Content-Disposition", "attachment;filename=" + FileAndTitleName + ".xls");
            context.Response.BinaryWrite(File.ReadAllBytes(filePath));
            // 删除副本
            File.Delete(filePath);
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