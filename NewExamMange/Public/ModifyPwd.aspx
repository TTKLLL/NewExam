<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModifyPwd.aspx.cs" Inherits="Public_ModifyPwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../js/jquery.js"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $("#btnOk").click(function () {
                if ($("#tbOldPwd").val() == "") {
                    alert("请输入旧密码"); return false;
                }
                if ($("#tbNewPwd").val() == "") {
                    alert("请输入新密码"); return false;
                }
                if ($("#tbANewPwd").val() == "") {
                    alert("请再次输入新密码"); return false;
                }
                if ($("#tbANewPwd").val() != $("#tbNewPwd").val()) {
                    alert("请输入相同的新密码"); return false;
                }
            });
            $("#back").click(function () {
                if (confirm("确定返回吗？")) {
                    parent.frames["main"].location.href = "../Desktop.aspx";
                }
            })
        })
    </script>
    <style type="text/css">
       #back{ margin-left:20px;}
      
        .td1{
            text-align:right; padding-right:10px;
	        width:140px;
        }
        .td2{
            padding-left:10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
                <div style="margin-bottom:10px; padding:8px 0 8px 15px; background-color:#F5F5F5"><a href="Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
            <a href="#" style="color:red;">密码修改</a></div>
    <div>
        <div style="width:400px; margin:10px auto;">
            <table class="table table-bordered"> 
                <caption><center><h3><b>密码修改</b></h3></center> </caption>
            <tr>
                <td class="td1">原密码：</td>
                <td class="td2">
                    <asp:TextBox ID="tbOldPwd" runat="server" TextMode="Password" CssClass="form-control"
                        Width="220px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="td1">新密码：</td>
                <td class="td2">
                    <asp:TextBox ID="tbNewPwd" runat="server" TextMode="Password"  CssClass="form-control"
                        Width="220px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="td1">确认密码：</td>
                <td class="td2">
                    <asp:TextBox ID="tbANewPwd" runat="server" TextMode="Password"  CssClass="form-control"
                        Width="220px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="padding-left:120px;"><asp:Button ID="btnOk"  runat="server" CssClass="btn btn-primary" Text="确定" OnClick="btnOk_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="back" value="取消" class="btn btn-primary"/>&nbsp;</td>
            </tr>
        </table>
        </div>
    </div>
    </form>
</body>
</html>


