<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CheckInStu.aspx.cs" Inherits="Teacher_ClassList" %>

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
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
            <a href="" style="color:red">考生登记</a>
            </div>
        </div>

        <table style="line-height: 45px; margin-top: 10px;" class="table table-bordered table-condensed">
            <tr>
                <td style="width:137px;">请输入考场名称：</td>
                <td style="width:100px;"><input  class="form-control col-sm-5" /></td>
                <td style="width:115px;"> 请选择班级：</td>
                <td style="width:200px;">
                    <select class="form-control col-sm-5">
                        <option>全选</option>
                        <option selected="selected">2015级软件工程(1)班</option>
                        <option>2015级计算机科学与技术(1)班</option>
                    </select>
                </td>

                <td style="width: 155px; line-height: 45px;">请输入学生相关信息:
                </td>
                <td style="width: 200px;">
                    <asp:TextBox runat="server" Width="200px" class="form-control" ID="tb_Query"></asp:TextBox>
                </td>
                <td>
                    <button type="button" class="btn btn-primary" id="querty_btn">查询</button>
                </td>
            </tr>
        </table>

        

        <table class="table table-striped table-hover table-bordered">
            <thead>
                <tr class="info">
                    <td>序号</td>
                    <td>学号</td>
                    <td>姓名</td>
                    <td>班级</td>
                    <td>联系方式</td>
                    <td>是否允许开始考试</td>
                    <td>操作</td>

                </tr>
            </thead>
            <tr>
                <td>1</td>
                <td><a href="StuDetailWaitCheck.aspx">201540450119</a></td>
                <td><a href="StuDetailWaitCheck.aspx">李昶</a></td>
                <td>2015级软件工程(1)班</td>
                <td>13995975900</td>
                <td><input type="checkbox" checked="checked" /></td>
                <td>
                    <button class="btn btn-primary">验证通过</button></td>
            </tr>
            <tr>
                <td>1</td>
                <td><a href="StuDetailWaitCheck.aspx">201540450119</a></td>
                <td><a href="StuDetailWaitCheck.aspx">李昶</a></td>
                <td>2015级软件工程(1)班</td>
                <td>13995975900</td>
                <td><input type="checkbox" checked="checked" /></td>
                <td>
                    <button class="btn btn-primary">验证通过</button></td>
            </tr>
            <tr>
                <td>1</td>
                <td><a href="StuDetailWaitCheck.aspx">201540450119</a></td>
                <td><a href="StuDetailWaitCheck.aspx">李昶</a></td>
                <td>2015级软件工程(1)班</td>
                <td>13995975900</td>
                <td><input type="checkbox" checked="checked" /></td>
                <td>
                    <button class="btn btn-primary">验证通过</button></td>
            </tr>
            
        </table>
        <ul class="pagination">
            <li><a href="#">&laquo;</a></li>
            <li class="active"><a href="#">1</a></li>
            <li class="disabled"><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
            <li><a href="#">&raquo;</a></li>
        </ul>


    </form>
</body>
</html>
