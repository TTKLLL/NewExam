<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadStuImage.aspx.cs" Inherits="ManageStu_UploadStuImage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../js/uploadPreview.min.js"></script>

    <style type="text/css">
        #main {
            margin: 15px auto;
            width: 600px;
            height: 470px;
            border-radius: 8px;
            background-color: #EEEEEE;
            text-align: center;
            padding-top: 8px;
        }

        #img {
            width: 160px;
            height: 220px;
            margin: 25px auto;
            padding: 5px;
            border-radius: 5px;
            background-color: #286778;
        }

        table {
            width: 80px;
            line-height: 60px;
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            //预览图片
            $("#face").uploadPreview({ Img: "ImgPr", Width: 150, Height: 210 });
        })
    </script>
</head>
<body>
    <form id="form1" action="UploadStuImage.aspx" method="post" enctype="multipart/form-data">
        <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
            <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
            <a href="#">考生信息管理</a>&nbsp;&gt;&gt;&nbsp;
                  <a href="#">考生相片上传</a>
        </div>
        <div id="main">
            <h3><b>考生相片上传</b></h3>
            <div id="img">
                <%if (ImageUrl != null)
                  { %>
                <img id="ImgPr" src="<%= ImageUrl %>" style="width: 150px; height: 210px;" />
                <%} %>
                <%else
                  { %>
                <img id="ImgPr" style="width: 150px; height: 210px;" />
                <%} %>
            </div>
            <p style="color: red;">请上传相件，相件格式为jpg，大小为150*210像素，大小不超过300K！</p>
            <div>
                <table style="width: 350px; margin: 0 auto;">
                    <tr>
                        <td colspan="3">
                            <input id="face" name="face" required="required" class="form-control" type="file" />
                        </td>
                    </tr>
                    <tr>
                        <%--<td style="width: 90px;">
                            <asp:Button runat="server" class="btn btn-default" ID="bt_See" OnClick="bt_See_Click" Text="预览" />
                        </td>--%>
                        <td style="width: 200px;">
                            <input type="submit" value="确认 " class="btn btn-default" />
                            <%--   <asp:Button runat="server" class="btn btn-default" ID="bt_UpLoad" OnClick="bt_UpLoad_Click" Text="确认" />--%>
                        </td>
                        <td><a onclick="javascript: history.back(-1);" class="btn btn-default">取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

    </form>
</body>
</html>
