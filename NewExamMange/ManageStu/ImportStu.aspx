<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImportStu.aspx.cs" Inherits="Admin_ImportSingle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>

    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="../assets/layer/layer.js"></script>
    <script type="text/javascript" src="../js/MyAlert.js"></script>

    <style type="text/css">
       

        body {
     
          
        }
    </style>

    <script type="text/javascript">
        $(function () {
            //全选
            $("#allCheck").change(function () {

                if ($(this).is(":checked")) {


                    $("#stuTable").find(".firstCheck").attr("checked", true)
                }
                else {
                    $("#stuTable").find(".firstCheck").attr("checked", false)
                }
            })

            //导入
            $("#Input").click(function () {
                var idArray = new Array();
                $("#stuTable").find("tbody").find("tr").each(function () {

                    if ($(this).find(".firstCheck").is(":checked") == false)

                        idArray.push($(this).find(".id").eq(0).html())
                })
                //alert(idArray)
                window.location.href = "?idArray=" + String(idArray);
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">考生信息管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">考生信息导入</a>
            </div>
            <asp:Panel ID="Panel1" runat="server">

                <table width="100%" class="table table-bordered table-striped table-hover">
                    <tr>
                        <td style="text-align:center;">
                             <div style="width:420px; margin:0 auto;">
                            <asp:FileUpload ID="fuStu" runat="server"  CssClass="form-control" Width="400px" /></div>
                            </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;" >
                           <asp:Button ID="btnImport"  runat="server" Text="导入" CssClass="btn btn-primary" OnClick="btnImport_Click" />
                            
                            <span style="margin-left:15px;"></span><asp:Button ID="btnDownModle"  runat="server" Text="下载考生信息模板"
                                CssClass="btn btn-primary" OnClick="btnDownModle_Click"  /></td>
                    </tr>
                    <tr>
                        <td style="text-align:center; font-size:14px;">注意：请先下载考生信息模板模版，根据模版的格式制作EXCEL文件，再通过此方式导入考生信息</td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:Panel ID="Panel2" Visible="false" runat="server">

                <table id="stuTable" class="table table-striped table-hover table-bordered" style="line-height: 30px; font-size: 14px;">
                    <caption>
                        <h4 style="text-align: center">以下考生已存在 请勾选需要更新的考生</h4>
                    </caption>
                    <thead>
                        <tr class="info">
                            <td style="width: 3%"></td>
                            <td style="width: 10%">学号</td>
                            <td style="width: 20%">姓名</td>
                            <td style="width: 30%">班级</td>
                            <td style="width: 25%">手机号</td>
                        </tr>
                    </thead>
                    <%foreach (var item in hasStu)
                      {%>
                    <tr>
                        <td>
                            <input class="firstCheck" type="checkbox" /></td>
                        <td class="id"><%=item.StudentId %></td>
                        <td><%=item.StudentName %></td>
                        <td><%=item.Class %></td>
                        <td><%=item.StudentPhone %></td>
                    </tr>
                    <%} %>
                </table>
                <span style="font-size: 14px; margin-left: 10px;">
                    <input type="checkbox" id="allCheck" />全选
                请选择要更新的考生
                <button id="Input" type="button" class="btn btn-primary">导入</button>
                    <asp:Button ID="reInput" runat="server" CssClass="btn btn-primary" OnClick="reInput_Click" Text="重新导入" />
                    <%-- <a href="ImportStu.aspx" id="reInput" class="btn btn-primary">重新导入</a>--%>
                </span>

            </asp:Panel>

        </div>
    </form>
</body>
</html>
