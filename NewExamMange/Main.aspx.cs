using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class left : BasePage
{

    public static List<Authority> aus = new List<Authority>();
    public static Teacher teacher = new Teacher();
    public static string uId;

    public static string FunctionName = "后台管理";
    public static ExamType choseExanType; //被选中的考试类型
    public static DataClassesDataContext db = new DataClassesDataContext();
    public static List<ExamType> noChoseExamType;

    protected void Page_Load(object sender, EventArgs e)
    {
     
        if (Request.QueryString["examTypeId"] != null)
        {
            List<ExamType> types = db.ExamType.ToList();
           
            foreach(var item in types)
            {
                if (item.ExamTypeId == int.Parse(Request.QueryString["examTypeId"]))
                    item.IsChose = 1;
                else
                    item.IsChose = 0;
            }
            db.SubmitChanges();
        }

        if (!IsPostBack)
        {
            //获取考试类型

            choseExanType = db.ExamType.First(t => t.IsChose == 1);
            noChoseExamType = db.ExamType.Where(t => t.IsChose == 0).ToList();
            Response.Cookies["ExamType"].Value = choseExanType.ExamTypeFlag.ToString();  //用cookie保存当前的考试类型

            //if (Session["uId"] == null)
            if(Request.Cookies["uId"] == null)
                ReLogIn();
            // ClientScript.RegisterClientScriptBlock(this.GetType(), "error", "<script>alert('登陆过期，请重新登陆！');window.parent.parent.location='Login.aspx'</script>");
            else
                bindAthority();
        }
    }

    protected void bindAthority()
    {
        uId = Request.Cookies["uId"].Value.ToString();
        AuthorityBLL auBll = new AuthorityBLL();
        DataClassesDataContext db = new  DataClassesDataContext();

        teacher = db.Teacher.First(t => t.TId == uId);

        if (Request.Cookies["UserType"] != null)
        {
            string para = Request.Cookies["UserType"].Value.ToString();
            string tId = Request.Cookies["uId"].Value.ToString();

            if (para == "2")
            {
                Panel1.Visible =false;
                FunctionName = "监考管理";
            }   
            else
                FunctionName = "后台管理";
            int type;
            if(choseExanType.ExamTypeName.Contains("基础"))
                type = (int)AuthorityBLL.AuthorityExamType.Basic;
            else
                type = (int)AuthorityBLL.AuthorityExamType.Practical;
            aus = auBll.GetTeacherAu(uId, int.Parse(para), type);  //根据考试类型获取权限
        }


      
       // lr_UserName.Text = res.TName;

    }
}