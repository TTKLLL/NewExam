<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamTopicScource.aspx.cs" Inherits="Exam_ExamBasicInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />


    <title></title>

    <script type="text/javascript">

        //修改题库选中状态
        function ChangeChose(sourceId) {
            $.post("ChangeSourceChose.ashx", { TopicSourceId: sourceId }, function (data) {
                if (String(data).toLowerCase() === 'false') {
                    alert("修改失败");
                    window.location.href = "";
                }
                else {
                    // alert("修改成功");
                }


            });
        }
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                <li class="active"><a style="color: red" href="">题库选择</a></li>
                <li><a href="ExamPoint.aspx">知识点选择</a></li>
                <li><a href="ExamSort.aspx">题目数量设置</a></li>

            </ul>


            <div style="width: 740px; border-radius: 8px; margin: 15px auto;">
                <table id="sortTable" class="table table-bordered table-hover table-striped">
                    <caption>
                        <h4 style="text-align: center"><b>请选择题库</b></h4>
                    </caption>
                    <thead>
                        <tr class="info">
                            <td style="width: 10px;"></td>
                            <td style="width: 10px;">序号</td>
                            <td>题库名称</td>
                        </tr>
                    </thead>
                    <%int index = 0; %>
                    <%foreach (var item in source)
                      {%>
                    <tr>
                        <td style="width: 10px; line-height: 37px;">
                            <input type="checkbox" onchange="ChangeChose(<%= item.TopicSourceId %>)"
                                <%= item.IsChose == 1 ? "checked" : "" %> /></td>
                        <td style="width: 10px; line-height: 37px;"><%= ++index %></td>
                        <td class="hidden"><%= item.TopicSourceId %></td>
                        <td style="width: 325px; height: 37px; line-height: 37px;">
                            <%= item.TopicSourceName %></td>

                    </tr>
                    <%} %>
                </table>

            </div>
        </div>
    </form>
</body>
</html>
