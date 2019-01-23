using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class ManageStu_UploadStuImage : BasePage
{
    public static string SId;
    public string ImageUrl;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["sId"] != null)
        {
            SId = Request.QueryString["sId"].ToString();
        }
        BindImage();

        if (Request.Files["face"] != null)
        {
           
            UploadIiamge();
        }
    }

    public void BindImage()
    {
        DataClassesDataContext db = new DataClassesDataContext();
        if(SId != null)
        {
            string url = db.Student.First(t => t.StudentId == SId).StuImage;
           // alert(url);
            if (url != null && url != "")
                ImageUrl = url;
        }
        
    }

    public void UploadIiamge()
    {
        HttpPostedFile file = Request.Files["face"]; //获取提交的数据流

        try
        {
            string fileExtension = Path.GetExtension(file.FileName);  //获取文件的扩展名


            if (fileExtension != ".jpg" && fileExtension != ".JPG")
            {
                alert("请上传jpg格式的图片！");
                return;
            }
            else
            {
                //判断文件时候出阿来
                string fileName = Path.GetFileName(file.FileName);//获取扩展名与文件名
                string filePreName = "/StuImg/";
                string newFileName = filePreName + SId + ".jpg";
                string physicFileNaem = Server.MapPath(newFileName);
                if (File.Exists(physicFileNaem))
                    File.Delete(physicFileNaem);
                


                file.SaveAs(Server.MapPath(newFileName));
                string sql = "update student set StuImage={0} where StudentId={1}";
                DataClassesDataContext db = new DataClassesDataContext();
                int res = db.ExecuteCommand(sql, new object[] { newFileName, SId });
                db.SubmitChanges();
               
                alert("上传成功", "WaitAuditManage.aspx");
  
            }
        }
        catch (Exception ex)
        {
            alert("上传失败");
        }
       
    }
}