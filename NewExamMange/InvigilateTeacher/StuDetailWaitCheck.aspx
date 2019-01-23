<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StuDetailWaitCheck.aspx.cs" Inherits="CheckIn_StuDetailWaitCheck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../js/uploadPreview.min.js"></script>



    <script type="text/javascript">
        $(function () {
            //预览图片
            $("#face").uploadPreview({ Img: "ImgPr", Width: 220, Height: 220 });

            $("#cancle").click(function () {
                window.history.go(-1);
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">考生登记</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">考生详细信息</a>
            </div>


            <table id="StuInfo" class="table table-bordered table-hover">
                <caption>
                    <center><h3><b>考生详细信息</b></h3></center>
                </caption>
                <tbody>
                    <tr>
                        <td rowspan="4">
                            <img id="ImgPr" src="../StuImg/201540450119.jpg" class="pull-left" style="width: 120px; height: 120px;" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;">学号：</td>
                        <td>201540450119</td>
                        <td style="width: 110px; text-align: right;">姓名：</td>
                        <td>李昶</td>
                    </tr>
                    <tr>
                        <td style="width: 120px; text-align: right;" required>班级：</td>
                        <td>2015级软件工程(1)班 </td>
                        <td style="width: 120px; text-align: right;">手机号：</td>
                        <td>
                            13995975900
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <asp:Button runat="server" ID="bt_Save" class="btn btn-primary" Text="验证通过" />
                            <button class="btn  btn-danger">取消验证</button>
                            <button id="cancle" class="btn btn-primary">返&nbsp;&nbsp;回</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
