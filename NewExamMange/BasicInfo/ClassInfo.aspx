<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClassInfo.aspx.cs" Inherits="BasicInfo_ClassInfo" %>

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
                <li><a href="PointInfo.aspx">知识点设置</a></li>
                <li ><a href="TopicTypeInfo.aspx">题目类别设置</a></li>
                <li class="active"><a style="color: red" href="ClassInfo.aspx">班级信息设置</a></li>
            </ul>


            <div style="width: 740px; border-radius: 8px; margin: 15px auto;">
                <table  class="table table-bordered table-hover table-striped">
                    <thead>
                        <tr>
                            <td>序号</td>
                            <td>班级名称</td>
                        </tr>
                    </thead>
                    <tr>
                        <td style="width:80px;">1</td>
                        <td style="width:320px;"><input class="form-control" value="2015级软件工程(1)班" /></td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td><input class="form-control" value="2015级计算机科学与技术(1)班" /></td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td><input class="form-control" value="2015级计算机科学与技术(2)班" /></td>
                    </tr>
            
                </table>
                   <button type="button" class="btn btn-primary">保存修改</button>
                 <button type="button" class="btn btn-primary">添加班级信息</button>
            </div>

        </div>
    </form>
</body>
</html>