<%@ Page Language="C#" AutoEventWireup="true" Debug="true" CodeFile="ExamTeacher.aspx.cs" Inherits="TeacherManage_ExamTeacher" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />

       <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>

    <style type="text/css">
        #queryTab tr td {
            height: 37px !important;
            line-height: 37px !important;
        }
    </style>

    
    <script type="text/javascript">
        $(function () {
            $(":hidden[name='reportType']").each(function () {
                var obj = $(this).prev();
                if (obj.attr('checked')) { $(this).val(obj.val()); }
            });

            $("table tr:even").css("background-color", "#F9F9F9");
        })
    </script>
</head>
<body>  
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <%--<div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                    <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
            <a href="" style="color: red">教师信息管理</a>--%>


                <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                    <li><a href="ManageTeacher.aspx">教师</a></li>
                    <li class="active"><a style="color: red" href="ExamTeacher.aspx">监考老师</a></li>
                    <li><a href="AdminInfo.aspx">管理员</a></li>

                </ul>
                </div>
                <div>
                    <asp:Panel ID="Panel2" Visible="false" runat="server">
                        <table class="table table-bordered table-condensed border-striped">
                            <tr class="info" style="font-weight: bolder;">
                                <td style="width: 5%;">序号</td>
                                <td style="width: 10%;">教师工号</td>
                                <td style="width: 20%;">教师姓名</td>
                                <td style="width: 20%;">联系方式</td>
                                <td style="width: 15%;">是否为监考老师</td>

                            </tr>
                        </table>
                        <span style="margin-left: 20px; font-weight: 400;">
                            <asp:Label ID="Label1" runat="server" Text="暂无数据"></asp:Label></span>
                    </asp:Panel>


                    <asp:Repeater OnItemDataBound="rp_TeacherInfo_ItemDataBound" ID="rp_TeacherInfo" runat="server">
                        <HeaderTemplate>
                            <table class="table table-bordered table-condensed border-striped">
                                <tr class="info" style="font-weight: bolder;">
                                    <td style="width: 5%;">序号</td>
                                    <td style="width: 10%;">教师工号</td>
                                    <td style="width: 20%;">教师姓名</td>
                                    <td style="width: 20%;">联系方式</td>
                                    <td style="width: 15%;">是否为监考老师</td>

                                </tr>
                        </HeaderTemplate>


                        <ItemTemplate>
                            <tr>
                                <td><%# (Container.ItemIndex + 1) +((Convert.ToBoolean(Request["Page"] != null)) ? (Convert.ToInt32(Request["Page"]) - 1) * 15 : 0)%></td>
                                <td><a href="TeacherDetail.aspx?fileNo=<%#Eval("TId")%>"><%#Eval("TId")%></a>  </td>
                                <td><a href="TeacherDetail.aspx?fileNo=<%#Eval("TId")%>"><%#Eval("TName")%></a></td>
                                <td><%#Eval("TPhone")%></td>
                                    <asp:Label ID="Label3" runat="server" Visible="false" Text='<%#Eval("TId")%>'></asp:Label>
                                </td>
                                <td>

                                    <asp:CheckBox ID="isExamTeacher" runat="server" OnCheckedChanged="isExamTeacher_CheckedChanged" AutoPostBack="true" />
                                    <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Eval("isExamTeacher") %>'></asp:Label>
                                </td>

                                <%--       <td><%#Eval("TeacherCreateDate")%> </td>--%>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate></table></FooterTemplate>
                    </asp:Repeater>


                    <div>


                        <asp:Panel ID="Panel1" runat="server">
                            <%--<div style="float: right; margin-right: 50px;">
                                <asp:HyperLink ID="lnkPrev" CssClass="btn btn-primary btn-xs" runat="server">上页</asp:HyperLink>
                                <asp:HyperLink ID="lnkNext" CssClass="btn btn-primary btn-xs" runat="server">下页</asp:HyperLink>
                                &nbsp;第
                <asp:Label ID="lblCurrentPage" runat="server"></asp:Label>
                                页 共
        <asp:Label ID="lblTotalPage" runat="server"></asp:Label>页
                            </div>--%>

                            <table id="queryTab" style="line-height: 50px;" class="table table-bordered table-condensed">
                                <tr>
                                    <td style="width: 170px; line-height: 45px;">请输入教师姓名或工号
                                    </td>
                                    <td style="width: 200px;">
                                        <asp:TextBox runat="server" Width="200px" class="form-control" ID="tb_Query"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="bt_Query" runat="server" CssClass="btn btn-primary" Text="查&nbsp;&nbsp;询" OnClick="bt_Query_Click" />


                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>



    </form>


</body>
</html>
