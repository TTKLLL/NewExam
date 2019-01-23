<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PersonInfo.aspx.cs" Inherits="PersonManage_PersonInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
          <div style="margin-bottom:10px; padding:8px 0 8px 15px; background-color:#F5F5F5"><a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
            <a href="PersonInfo.aspx" style="color:red;">个人信息管理</a>&nbsp;&gt;&gt;&nbsp;
           </div>
         <div style="width:800px; margin:0 auto;">
                 <asp:Panel runat="server" ID="pl_CheckPwd" >
              <table style="width:350px; margin:25px auto; text-align:left">
                  <tr style="height:35px"><td colspan="2"> 验证密码：</td></tr><tr><td>
        <asp:TextBox runat="server" Width="200px" TextMode="Password" class="form-control" ID="tb_CheckPwd"></asp:TextBox></td><td>
              <asp:Button runat="server" class="btn btn-primary" ID="bt_confirm" OnClick="bt_confirm_Click" Text="确&nbsp;&nbsp;定" />
                      </td> 
                      </tr> 
              </table>
            </asp:Panel>
        <asp:Panel ID="pl_AdmInfo" Visible="false" runat="server">
      <table id="StuInfo" class="table table-bordered table-hover">
            <caption><center><h3><b>修改个人信息</b></h3></center></caption>
            <tbody>
                 <tr>
                     <td style="text-align:right;">手机号：</td>
                    <td ><asp:TextBox runat="server" class="form-control" ID="tb_Phone"   required></asp:TextBox></td>
                     
                    <td >
                        <asp:Button runat="server" ID="bt_Save" class="btn btn-primary" OnClick="bt_Save_Click" Text="保&nbsp;&nbsp;存"/>
                       </td>
                </tr>
            </tbody>
        </table>
            </asp:Panel>
            </div>
    </form>
</body>
</html>
