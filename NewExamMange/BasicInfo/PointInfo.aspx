<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PointInfo.aspx.cs" Inherits="BasicInfo_PointInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {

            //编辑二级知识点
            $("#editSecondPoint").click(function () {
                var checkedInput = $("#firstPointTab input:checkbox:checked")
                if (checkedInput <= 0) {
                    alert("请选择一个知识点")
                }
                else {
                    var rows = $("#firstPointTab").find("tr")
                    rows.each(function () {

                        if ($(this).find("input:checkbox").eq(0).is(":checked")) {
                            var id = $(this).find(".FirstPointId").html()
                            window.location.href = "SecondPointInfo.aspx?firstId=" + id;
                        }

                    })

                }
            })

            //添加知识点
            $("#addPoint").click(function () {
                var index = $("#firstPointTab tbody").find("tr").length + 1

                var trStr = '<tr>' +

                       ' <td>' +
                          '  <input type="checkbox" /></td>' +
                        '<td>' + index + '</td>' +
                        '<td>' +
                          '  <input value="" class="form-control" style="width: 350px;" />' +
                       ' </td>' +
                        '<td>' +
                ' <input type="text" value="" style="width: 55px;" class="form-control" /></td>' +
        ' </tr>"';
                $("#firstPointTab").append(trStr)
            })
        })


    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                    <li class="active"><a style="color: red" href="PointInfo.aspx">知识点设置</a></li>
                <%--    <li><a href="TopicTypeInfo.aspx">题目类别设置</a></li>--%>
                    <li><a href="TopicSoureManage.aspx">题库设置</a></li>

                </ul>

                <div style="width: 740px; border-radius: 8px; margin: 15px auto;">
                    <table id="firstPointTab" class="table table-bordered table-hover table-striped">
                        <thead>
                            <tr class="info">
                                <td></td>
                                <td>序号</td>
                                <td>一级知识点名称</td>
                                <td>一级知识点排序号</td>

                            </tr>
                        </thead>
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Repeater ID="Repeater1" runat="server">
                                    <ItemTemplate>
                                        <tr>

                                            <td>
                                                <asp:CheckBox ID="CheckBox1" runat="server" /></td>
                                            <td><%# Container.ItemIndex+1%></td>
                                            <td class="hidden FirstPointId">

                                                <asp:Label ID="idLabel" runat="server" Text='<%# Eval("FirstPointId") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="FirstPointName_td" Width="350" CssClass="form-control" runat="server" Text='<%# Eval("FirstPointName") %>'></asp:TextBox>

                                            </td>
                                            <td>
                                                <asp:TextBox ID="FirstPointOrder_td" Width="55px" CssClass="form-control" runat="server" Text='<%# Eval("FirstPointOrder") %>'></asp:TextBox>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                </table>
                            <asp:Button CssClass="btn btn-primary" ID="addPoint_btn" OnClick="addPoint_btn_Click" runat="server" Text="添加一级知识点" />

                                <asp:Button ID="editSecond_btn" CssClass="btn btn-primary" OnClick="editSecond_btn_Click" runat="server" Text="编辑二级知识点" />

                                <asp:Button Style="margin-left: 5px;" OnClick="save_btn_Click" CssClass="btn btn-primary" ID="save_btn" runat="server" Text="保存修改" />

                                <asp:Button ID="delete_btn" CssClass="btn btn-danger" OnClick="delete_btn_Click" runat="server" Text="删除" OnClientClick="confirm('是否确认删除?')" />

                                <a href="AllPoints.aspx" class="btn btn-primary">所有知识点</a>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </table>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
