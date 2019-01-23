<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherDetail.aspx.cs" Inherits="TeacherManage_TeacherDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/jquery-1.8.3.min.js"></script>

    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>

    <script type="text/javascript">
        $(function () {
            

            $("#cancle").click(function () {
                window.history.go(-1);
            })
        })
    </script>
</head>


<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color:red">教师详细信息</a>
            </div>

 
            <table id="StuInfo" class="table table-bordered table-hover">
                <caption>
                    <center><h3><b>教师信息</b></h3></center>
                </caption>
                <tbody>
                    <tr>
                        <td style="text-align: right;">教师工号：</td>
                        <td>
                           <asp:Label ID="la_TeaNo" runat="server"  class="form-control"></asp:Label>
                        </td>
                        <td style="width:110px; text-align: right;">手机号：</td>
                        <td>  
                        <asp:TextBox ID="te_phone" runat="server" class="form-control" ></asp:TextBox>
                    </tr>
                    <tr>
                        <td style="width: 120px; text-align:right;">姓名：</td>
                        <td>
                            <asp:TextBox ID="tb_name" runat="server"  class="form-control"  ></asp:TextBox></td>
                      <%-- <td style="text-align:right">工作职责：</td>
                         <td>
                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                        </td>--%>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3"> 
                             
                            <asp:Button runat="server" ID="bt_Save" class="btn btn-primary" Text="保存修改" OnClick="bt_Save_Click" />
                            <asp:Button ID="RestPwd_btn"   runat="server" CssClass="btn btn-danger" Text="密码重置" OnClick="RestPwd_btn_Click"/>
                            <asp:Button ID="Delete_btn" OnClientClick="confirm('是否确认删除？')" CssClass="btn btn-danger" OnClick="Delete_btn_Click" runat="server" Text="删除" />
                            <button id="cancle" class="btn btn-primary" onclick="location.href='ManageTeacher.aspx'">返&nbsp;&nbsp;回</button>
                        </td>
                    </tr>
                </tbody>
            </table>


        </div>
    </form>
</body>
</html>
