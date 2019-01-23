<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeFile="SingInExamRoom.aspx.cs" Inherits="InvigilateTeacher_SingInExamRoom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>

    <style type="text/css">
        table tr td:first-child{
            text-align:right;
       line-height:37px;
        }
        table tr td{
           
            line-height:37px !important;
        }
    </style>
</head>

    
<body>
    <form id="form1" runat="server"  method="post" action="SingInExamRoom.aspx">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">考场登记</a>
            </div>

            <%if(nowExam != null) {%>
            <div id="setDetail" style="width: 740px; margin: 15px auto; border-radius: 8px;">
                <table class="table table-bordered table-hover table-striped">
                    <caption><h3 style="text-align:center"> <b>考场登记</b></h3></caption>
                    <tr>
                        <td>考试名称</td>
                         <td><%= new ExamBLL().GetExamName(nowExam) %></td>
                    </tr>
                    <tr>
                        <td>考试开始时间</td>
                        <td><%= nowExam.ExamBegTime %></td>
                    </tr>
                    <tr>
                        <td>考试结束时间</td>
                        <td><%= nowExam.ExamEndTime %></td>
                    </tr>
                     <tr>
                        <td>考场名称</td>
                         <td><input name="ExamRoomName" class="form-control" value="<%= invigilate.ExamRoomName %>"  required /></td>
                    </tr>
                     <tr>
                        <td>考场地址</td>
                         <td><input name="ExamRoomPosition" value="<%= invigilate.ExamRoomPosition %>" class="form-control" required/></td>
                    </tr>
                     <tr>
                        <td>主监考老师</td>
                        <td><%= tname %></td>
                      
                    </tr>
                    <tr>
                        <td>非主考老师</td>
                        <td><input class="form-control" required name="OtherTeacher" value="<%= invigilate.OtherTeacher %>"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><button type="submit" class="btn btn-primary">保存</button></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <% else{ %>
                <h3 style="text-align:center"><b>暂无考试</b></h3>
            <%} %>
        </div>
    </form>
</body>
</html>
