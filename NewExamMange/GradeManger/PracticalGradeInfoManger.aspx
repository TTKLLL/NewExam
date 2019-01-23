<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PracticalGradeInfoManger.aspx.cs" Inherits="GradeManger_GradeInfoManger" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>


    <style type="text/css">
        #GradeInfo tr td {
            margin: 0;
            padding: 0;
        }

        table tr td {
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $(".grade").blur(function () {
                var grade = $(this).val();

                if (isNaN(grade) || grade < 0)
                    errAlert("请输入正确的分数");
                else {

                    var sId = $(this).siblings(".sId").eq(0).html()
                    var TheExamId = $(this).siblings(".TheExamId").eq(0).html()
                    var score = $(this).val();
                }
                $.get("ChangePracTcalScore.ashx", { sId: sId, TheExamId: TheExamId, score: score }, function (data) {
                    if (data == "success") {
                        layer.msg("修改成功！");

                        setTimeout(function () {
                            layer.closeAll()
                        }, 500)
                    }
                    else {
                        $(this).val(data);
                        errAlert("修改失败");
                    }

                })


            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
            <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
            <a href="#" style="color: red;">成绩管理</a>
        </div>


        <asp:Repeater ID="rp_GradeInfo" runat="server" OnItemDataBound="rp_GradeInfo_ItemDataBound">
            <HeaderTemplate>
                <table id="GradeInfo" class="table table-bordered table-condensed">
                    <caption>
                        <h4 style="text-align: center"><b><%= TheExamName %></b></h4>
                    </caption>
                    <tr class="info" style="font-weight: bolder;">
                        <td style="width: 3%; text-align: center">序号</td>
                        <td style="width: 10%;">学号</td>
                        <td style="width: 18%;">姓名</td>
                        <td style="width: 15%;">班级</td>
                        <td style="width: 15%;">开始答题时间</td>
                        <td style="width: 15%;">交卷时间</td>
                        <td style="width: 8%;">成绩</td>

                    </tr>
            </HeaderTemplate>
            <AlternatingItemTemplate>
                <tr class="success">
                    <td style="text-align: center"><%# (Container.ItemIndex + 1) +((Convert.ToBoolean(Request["Page"] != null)) ? (Convert.ToInt32(Request["Page"]) - 1) * 30 : 0)%></td>
                    <td>
                        <a href="../TopicMamage/DownPracticalTopic.ashx?sId=<%# Eval("stuno")%>&TheExamId=<%= TheExamId %>"><%#Eval("stuno") %></a>
                    </td>
                    <td>
                        <a href="VIewStuPaper.aspx?sId=<%# Eval("stuno")%>&TheExamId=<%= TheExamId %>"><%#Eval("stname") %></a>
                    </td>
                    <td>
                        <%#Eval("stuclass")%>
                    </td>
                    <td><%#Eval("beginTIme") %></td>
                    <td><%#Eval("endTime") %></td>
                    <td>
                        <asp:TextBox ID="TextBox1" CssClass="form-control grade" Text='<%#Eval("stuscore")%>' runat="server"></asp:TextBox>
                        <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Eval("stuno") %>'></asp:Label>
                        <asp:Label ID="sId" CssClass="hidden sId" runat="server" Text=''></asp:Label>
                        <label class="hidden TheExamId"><%= TheExamId %></label>
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <ItemTemplate>
                <tr>
                    <td style="text-align: center"><%# (Container.ItemIndex + 1) +((Convert.ToBoolean(Request["Page"] != null)) ? (Convert.ToInt32(Request["Page"]) - 1) * 30 : 0)%></td>
                    <td>
                        <a href="../TopicManage/DownPracticalTopic.ashx?sId=<%# Eval("stuno")%>&TheExamId=<%= TheExamId %>"><%#Eval("stuno") %></a>
                    </td>
                    <td>
                        <a href="../TopicManage/DownPracticalTopic.ashx?sId=<%# Eval("stuno")%>&TheExamId=<%= TheExamId %>"><%#Eval("stname") %></a>
                    </td>
                    <td>
                        <%#Eval("stuclass")%>
                    </td>
                    <td><%#Eval("beginTIme") %></td>
                    <td><%#Eval("endTime") %></td>
                    <td>
                        <asp:TextBox ID="TextBox1" CssClass="form-control grade" Text='<%#Eval("stuscore")%>' runat="server"></asp:TextBox>
                        <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Eval("stuno") %>'></asp:Label>
                        <asp:Label ID="sId" CssClass="hidden sId" runat="server" Text=''></asp:Label>
                        <label class="hidden TheExamId"><%= TheExamId %></label>
                    </td>

                </tr>
            </ItemTemplate>
            <FooterTemplate></table></FooterTemplate>
        </asp:Repeater>
        <div style="float: right; padding-right: 50px;">
            <asp:HyperLink ID="lnkPrev" CssClass="btn btn-primary btn-xs" runat="server">上页</asp:HyperLink>
            <asp:HyperLink ID="lnkNext" CssClass="btn btn-primary btn-xs" runat="server">下页</asp:HyperLink>
            &nbsp;第
            <asp:TextBox ID="lblCurrentPage" runat="server" Width="25px"></asp:TextBox>
            页  
            <asp:Button class="btn btn-primary btn-xs" runat="server" ID="bt_Skip" Text="转到" OnClick="bt_Skip_Click" />
            共
        <asp:Label ID="lblTotalPage" runat="server"></asp:Label>页
        </div>


        <div>
            <table style="line-height: 50px;" class="table table-bordered">
                <tr>
                    <td style="width: 180px; line-height: 37px;">学号、姓名或班级名称：
                    </td>
                    <td style="width: 200px">
                        <asp:TextBox runat="server" Width="200px" class="form-control" ID="tb_Query"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button class="btn btn-primary" runat="server" ID="bt_Query" Text="查&nbsp;&nbsp;询" OnClick="bt_Query_Click" />
                        <asp:Button class="btn btn-primary" runat="server" ID="bt_Export" Text="导出成绩" OnClick="bt_Export_Click" />

                    </td>

                </tr>
            </table>
        </div>

    </form>
</body>
</html>
