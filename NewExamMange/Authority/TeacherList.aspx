﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherList.aspx.cs" Inherits="Authority_TeacherList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>


    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <style type="text/css">
        #taaTab tr td{
              padding-top: 4px !important;
            padding-bottom: 4px !important;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
               <div style="margin-bottom:10px; padding:8px 0 8px 15px; background-color:#F5F5F5"><a href="../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
            <a href="TeacherList.aspx" style="color:red;">权限管理</a></div>
    <div>
        <asp:Repeater ID="rp_TeaInfo" runat="server">
            <HeaderTemplate>
                <table class="table table-bordered table-condensed" id="taaTab">
                <tr class="info" style="font-weight:bolder;">
                    <td style="width:5%;">序号</td>
                    <td style="width:10%;">教师工号</td>
                    <td style="width:10%;">教师姓名</td>
                    <td style="width:18%;">联系方式</td>
    
                    
                </tr>
                </HeaderTemplate>
            <AlternatingItemTemplate>
                <tr class="success">
                    <td><%# (Container.ItemIndex + 1) +((Convert.ToBoolean(Request["Page"] != null)) ? (Convert.ToInt32(Request["Page"]) - 1) * 15 : 0)%></td>
                    <td><a href="GrantAuthority.aspx?username=<%#Eval("TId") %>"><%#Eval("TId")%></a></td>
                    <td><a  href="GrantAuthority.aspx?username=<%#Eval("TId") %>"><%#Eval("TName")%></a></td>
                    <td><%#Eval("TPhone")%></td>
                   
                </tr>
            </AlternatingItemTemplate>
            <ItemTemplate>
                 <tr>
                    <td><%# (Container.ItemIndex + 1) +((Convert.ToBoolean(Request["Page"] != null)) ? (Convert.ToInt32(Request["Page"]) - 1) * 15 : 0)%></td>
                    <td><a href="GrantAuthority.aspx?username=<%#Eval("TId") %>"><%#Eval("TId")%></a></td>
                    <td><a  href="GrantAuthority.aspx?username=<%#Eval("TId") %>"><%#Eval("TName")%></a></td>
                    <td><%#Eval("TPhone")%></td>
                   
                </tr>
            </ItemTemplate>
            <FooterTemplate></table></FooterTemplate>
        </asp:Repeater>
        <div style="float:right; padding-right:50px;">
       <asp:hyperlink id="lnkPrev" CssClass="btn btn-primary btn-xs" runat="server">上页</asp:hyperlink>
       <asp:hyperlink id="lnkNext" CssClass="btn btn-primary btn-xs" runat="server">下页</asp:hyperlink>
            &nbsp;第 <asp:TextBox id="lblCurrentPage" runat="server" Width="25px"></asp:TextBox>
       页   <asp:Button class="btn btn-primary btn-xs" runat="server" ID="bt_Skip" Text="转到" OnClick="bt_Skip_Click" /> 
             共
        <asp:label id="lblTotalPage" runat="server"></asp:label>页</div>
    <div>
        <table style="line-height:50px;"  class="table table-bordered">
            <tr>
                <td style="width:160px">
 教师姓名或工号：
                </td>
                <td style="width:200px">
                    <asp:TextBox runat="server" Width="200px" class="form-control" ID="tb_Query"></asp:TextBox>
                </td>
                <td>
                    <asp:Button class="btn btn-primary" runat="server" ID="bt_Query" Text="查&nbsp;&nbsp;询" OnClick="bt_Query_Click" />
                  
                </td>
            </tr>
        </table>
    </div>
    </div>
    </form>
</body>
</html>