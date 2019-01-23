<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTeacher.aspx.cs" Inherits="Admin_AddTeacher" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />

    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>


    <script type="text/javascript">
        $(function () {
            $("#cancle").click(function () {
                if (confirm("是否确定取消？")) {
                    window.history.back();
                }

            })
        })

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">添加教师信息</a>
            </div>

            <table id="StuInfo" class="table table-bordered table-hover">
                <caption>
                    <center><h3><b>添加教师</b></h3></center>
                </caption>
                <tbody>
                    <tr>
                        <td style="text-align: right;">教师工号：</td>
                        <td>

                            <asp:TextBox ID="tb_tid" runat="server" class="form-control"></asp:TextBox>
                        </td>
                        <td style="width: 110px; text-align: right;">密码：</td>
                        <td>
                            <asp:TextBox TextMode="Password" ID="tb_tpwd" runat="server" required class="form-control"></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 120px; text-align: right;">姓名：</td>
                        <td>
                            <asp:TextBox runat="server" class="form-control" ID="tb_name" required></asp:TextBox></td>
                        <td style="width: 120px; text-align: right;">手机号：</td>
                        <td>
                            <asp:TextBox runat="server" class="form-control" ID="tb_phone" required></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td colspan="3">
                            <asp:Button runat="server" ID="bt_Save" class="btn btn-primary" Text="保&nbsp;&nbsp;存" OnClick="bt_Save_Click" />
                            <a href="ManageTeacher.aspx" class="btn btn-danger">取&nbsp;&nbsp;消</a>
                        </td>
                    </tr>
                </tbody>
            </table>


        </div>
    </form>
</body>
</html>
