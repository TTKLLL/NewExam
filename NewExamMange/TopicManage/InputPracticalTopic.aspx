<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InputPracticalTopic.aspx.cs" Inherits="Admin_TopicManage_InputTopic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="../assets/layer/layer.js"></script>
    <script type="text/javascript" src="../js/MyAlert.js"></script>

    <style type="text/css">
        body {
            margin: 0;
            font-size: 12px;
        }

        .table tr td {
            padding-top: 4px !important;
            padding-bottom: 4px !important;
        }
    </style>

    <script type="text/javascript">
        $(function () {

            

            //添加知识点
            $("#add").click(function () {
                var pointArray = new Array();

                $("#checkTable").find("tbody tr").find("input:checked").each(function () {
                    var data = new Object();
                    data.FirstPointName = $(this).parent().siblings(".first").html();
                    data.SecondPointName = $(this).parent().siblings(".second").html();
                    pointArray.push(JSON.stringify(data));
                })
                if (pointArray.length <= 0) {
                    alert("请选择要添加的知识点");
                }
                else {
                    alert(pointArray);
                    window.location.href = "InputTopic.aspx?pointArray=" + pointArray;
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
                <a href="#" style="color: red">题库管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">导入题目</a>
            </div>

            <asp:Panel ID="Panel1" runat="server">

                <table class="table table-bordered table-striped table-hover">
                    <tr>

                        <td style="text-align: right; width: 400px; line-height: 70px;">题目描述</td>
                        <td>
                            <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" TextMode="MultiLine" Width="800" Height="70"></asp:TextBox></td>
                    </tr>

                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <div style="width: 420px; margin: 0 auto;">

                                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" Width="400px" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <asp:Button ID="btnImport" runat="server" Text="导入" CssClass="btn btn-primary" OnClick="btnImport_Click" />
                            <a id="back" class="btn btn-primary" href="PracticalTopic.aspx" style="margin-left: 20px;">返回</a>
                        </td>
                    </tr>
                  
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
