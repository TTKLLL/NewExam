<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SecondPointInfo.aspx.cs" Inherits="BasicInfo_SecondPointInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/jquery-1.8.3.min.js"></script>

    <script type="text/javascript">
        $(function () {


        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="PointInfo.aspx" style="color: red">知识点设置</a>
                &nbsp;&gt;&gt;&nbsp;
                <a href="SecondPointInfo.aspx" style="color: red">二级知识点</a>
            </div>

            <div style="width: 740px; border-radius: 8px; margin: 15px auto;">
                <table class="table table-bordered table-hover table-striped">
                    <caption>
                        <h4 style="text-align: center"><%= FirstPointName %></h4>
                    </caption>
                    <thead>
                        <tr class="info">
                            <td></td>
                            <td>序号</td>
                            <td>二级知识点名称</td>
                            <td>二级知识点排序号</td>
                        </tr>
                    </thead>

                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBox1" runat="server" /></td>
                                <td><%# Container.ItemIndex+1 %></td>
                                <td class="hidden">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("SecondPointId") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="form-control" Width="350" ID="TextBox1" Text='<%# Eval("SecondPointName") %>' runat="server"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox CssClass="form-control" Width="55" Text='<%# Eval("SecondPointOrder") %>' ID="TextBox2" runat="server"></asp:TextBox></td>

                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>



                </table>
                <span style="margin-left: 5px;"></span>
                <asp:Button CssClass="btn btn-primary" OnClick="save_btn_Click" ID="save_btn" runat="server" Text="保存修改" />
                <asp:Button CssClass="btn btn-primary" ID="Add_btn" OnClick="Add_btn_Click" runat="server" Text="添加二级知识点" />
                <asp:Button ID="delete_brn" OnClick="delete_brn_Click" CssClass="btn btn-danger" runat="server" OnClientClick="confirm('是否确定删除?')" Text="删除" />

                <asp:Button ID="back_btn" OnClick="back_btn_Click" CssClass="btn btn-primary" runat="server" Text="返回" />

            </div>
        </div>


    </form>
</body>
</html>
