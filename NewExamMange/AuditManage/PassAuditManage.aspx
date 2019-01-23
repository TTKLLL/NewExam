<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PassAuditManage.aspx.cs" Inherits="AuditManage_PassAuditManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                <li ><a  href="WaitAuditManage.aspx">待审核考生</a></li>
                <li class="active"><a style="color: red" href="PassAuditManage.aspx">审核通过考生</a></li>
                <li><a href="FailAuditManage.aspx">审核不通过考生</a></li>
            </ul>

            <table class="table table-hover table-striped table-bordered">
                <thead>
                    <tr class="info">
                        <td></td>
                        <td>序号</td>
                        <td>学号</td>
                        <td>姓名</td>
                        <td>班级</td>
                        <td>注册时间</td>
                        <td>状态</td>
                    </tr>
                </thead>
                <tr>
                    <td>
                        <input type="checkbox" /></td>
                    <td>1</td>
                    <td>201540450119</td>
                    <td>李昶</td>
                    <td>2015级软件工程(1)班</td>
                    <td>2018-06-11 07:07</td>
                    <td>通过审核</td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" /></td>
                    <td>1</td>
                    <td>201540450119</td>
                    <td>李昶</td>
                    <td>2015级软件工程(1)班</td>
                    <td>2018-06-11 07:07</td>
                    <td>通过审核</td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" /></td>
                    <td>1</td>
                    <td>201540450119</td>
                    <td>李昶</td>
                    <td>2015级软件工程(1)班</td>
                    <td>2018-06-11 07:07</td>
                    <td>通过审核</td>
                </tr>
            </table>
            <span style="float: left; margin-left: 5px;">
                <input type="checkbox" />&nbsp;全选</span>
            <div style="float: right; margin-right: 50px;">
                <button type="button" class="btn btn-primary btn-xs">上一页</button>
                <button type="button" class="btn btn-primary btn-xs">下一页</button>
                &nbsp;第<input value="1" style="width: 25px; height: 22px;" />页
                   <button type="button" class="btn btn-primary btn-xs">转到</button>
                共10页
            </div>
        </div>
        <button class="btn btn-danger" style="margin-left: 5px;">取消通过审核</button>

        <table style="line-height: 50px; margin-top: 10px;" class="table table-bordered table-condensed">
            <tr>
                <td style="width: 155px; line-height: 45px;">请输入学生相关信息
                </td>
                <td style="width: 200px;">
                    <asp:TextBox runat="server" Width="200px" class="form-control" ID="tb_Query"></asp:TextBox>
                </td>
                <td>
                    <button type="button" class="btn btn-primary" id="querty_btn">查询</button>
                </td>
               
            </tr>
        </table>
    </form>
</body>
</html>
