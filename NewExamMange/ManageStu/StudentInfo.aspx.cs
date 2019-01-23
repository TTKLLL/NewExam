//using System;
//using System.Collections.Generic;
//using System.Data.OleDb;
//using System.IO;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//public partial class Admin_ManageStu_StudentInfo : BasePage
//{
//    StudentBLL studentBll = new StudentBLL();
//    public static List<Student> stus = new List<Student>();
//    public static int pageNumber = 1; //当前页码
//    public static int totalPage = 0;  //总页数
//    public static string query = ""; //查询条件


//    protected void Page_Load(object sender, EventArgs e)
//    {
//        if(!IsPostBack)
//        {
//            if (Request.QueryString["pageNumber"] != null)
//            {
//                pageNumber = int.Parse(Request.QueryString["pageNumber"]);
//                query = Request.QueryString["query"].Trim().ToString();
//            }

//            BindData();
//        }
        
        
//    }

//    public void BindData()
//    {
//        stus = studentBll.GetStudentByPage(ref pageNumber, ref totalPage, 0, query);
//    }

//    //protected void bt_Export_Click(object sender, EventArgs e)
//    //{
//    //   // string Query = tb_Query.Text;
//    //    var result = (from p in db.proc_SelectExamName() select p).ToList().First();

//    //    string ExamName = result.ExameTitle;
//    //    var FileAndTitleName = ExamName + "成绩表";
//    //    var StuGradeRes = (from c in db.proc_SelectAllStudentScoreByClassName()
//    //                       where c.Class.Contains(Query) || c.StudentName.Contains(Query) || c.StudentId.Contains(Query)
//    //                       select c).ToList();
//    //    string filePath = Server.MapPath("../ExcelTemplet/Temp/" + Guid.NewGuid().ToString() + ".xls");
//    //    File.Copy(Server.MapPath("../ExcelTemplet/StudentGradeInfo.xls"), filePath);
//    //    //使用OleDb驱动程序连接到副本
//    //    OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
//    //    using (conn)
//    //    {
//    //        conn.Open();
//    //        //增加记录
//    //        foreach (var item in StuGradeRes)
//    //        {
//    //            StringBuilder sql = new StringBuilder();
//    //            sql.Append("INSERT INTO [Sheet1$]([序号],[班级],[学号],[姓名],[考试科目],[成绩]) VALUES('").Append(item.rowid).Append("','").Append(item.Class).Append("','").Append(item.StudentId).Append("','").Append(item.StudentName).Append("','").Append(item.ExameTitle).Append("','").Append(item.Score).Append("')");

//    //            //sql.Append("INSERT INTO [Sheet1$]([序号],[班级],[学号],[姓名],[考试科目],[成绩]) VALUES（'").Append(item.rowid).Append("','").Append(item.Class).Append("','").Append(item.StudentId).Append("','").Append(item.StudentName).Append("','").Append(item.ExameTitle).Append("','").Append(item.Score).Append("')");
//    //            OleDbCommand cmd = new OleDbCommand(sql.ToString(), conn);
//    //            cmd.ExecuteNonQuery();

//    //        }
//    //        conn.Close();
//    //        // 输出副本的二进制字节流
//    //        Response.ContentType = "application/ms-excel";
//    //        Response.AppendHeader("Content-Disposition", "attachment;filename=" + FileAndTitleName + ".xls");
//    //        Response.BinaryWrite(File.ReadAllBytes(filePath));
//    //        // 删除副本
//    //        File.Delete(filePath);

//    //    }






//    //}
//}