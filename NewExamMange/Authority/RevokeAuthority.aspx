<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RevokeAuthority.aspx.cs" Inherits="Authority_RevokeAuthority" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        table tr td{
            text-align:center;
        }
    </style>

    <link href="../css/bootstrap.min.css" rel="stylesheet" />

    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
            <a href="../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
           
            <a href="TeacherList.aspx" style="color: red;">权限回收管理</a>
        </div>
        <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;" role="tablist">
            <li role="presentation"><a href="GrantAuthority.aspx?username=<%=userName %>">权限授予</a></li>
            <li role="presentation" class="active"><a style="color: red;" href="RevokeAuthority.aspx?username=<%=userName %>">权限回收</a></li>
        </ul>
        <div role="tabpanel" class="tab-pane active" id="home">
            <asp:Repeater ID="rp_AutorityGrant" runat="server">
                <HeaderTemplate>
                    <table id="AutorityGrant" class="table table-bordered table-condensed table-hover">
                        <tr class="info" style="font-weight: bolder;">
                            <td style="width: 8%;">选择</td>
                            <td style="width: 8%;">序号</td>
                            <td style="width: 84%;">权限名称</td>

                        </tr>
                </HeaderTemplate>
                <AlternatingItemTemplate>
                    <tr class="success">
                        <td>
                            <asp:CheckBox ID="cb_Select" runat="server" /></td>
                        <td><%# (Container.ItemIndex + 1)%><asp:HiddenField runat="server" ID="hi_Id" Value='<%#Eval("AuthorityId") %>' />
                        </td>
                        <td><%#Eval("AuhorityName")%></td>

                    </tr>
                </AlternatingItemTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:CheckBox ID="cb_Select" runat="server" /></td>
                        <td><%# (Container.ItemIndex + 1)%><asp:HiddenField runat="server" ID="hi_Id" Value='<%#Eval("AuthorityId") %>' />
                        </td>
                        <td><%#Eval("AuhorityName")%></td>

                    </tr>
                </ItemTemplate>
                <FooterTemplate></table></FooterTemplate>
            </asp:Repeater>
            <asp:Panel ID="pl_Info" runat="server" Visible="false">
                <div class="noItem" style="margin:20px;">
                 <span style="margin-left:20px;"></span>   <asp:Label ID="lb_NoMessage" runat="server" Text="没有任何权限可以回收！"></asp:Label></div>
            </asp:Panel>
            <div>
                &nbsp;&nbsp;&nbsp;&nbsp;
 <asp:Button ID="btn_GrantGroup" runat="server" Text="权限回收" class="btn btn-primary" OnClick="btn_GrantGroup_Click" />
            </div>
        </div>
    </form>
</body>
</html>
