<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AllExam.aspx.cs" Inherits="ExamManage_AllExam" %>

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
        .table tr td {
            padding-top: 4px !important;
            padding-bottom: 4px !important;
        }
        
    </style>

    <script type="text/javascript">

        function ValidTime(starttime, endtime) {
            var starTimeStamp = Date.parse(starttime) / 1000;
            var endTimeStamp = Date.parse(endtime) / 1000;

            return (String(starTimeStamp) < String(endTimeStamp))
        }

        $(function () {
            var nowPage = parseInt('<%= pageNumber%>');
            var totalPage = parseInt('<%= totalPage%>');

            $("#prev").attr("href", "AllExam.aspx?pageNumber=<%=pageNumber-1 %>");
            $("#next").attr("href", "AllExam.aspx?pageNumber=<%=pageNumber+1 %>");
            $("#prev").attr("disabled", false)
            $("#next").attr("disabled", false)

            if (nowPage == 1) {
                $("#prev").attr("href", "#");
                $("#prev").attr("disabled", true);
                if (totalPage == 1) {
                    $("#next").attr("href", "#");
                    $("#next").attr("disabled", true);
                }
            }
            if (totalPage == nowPage) {
                $("#next").attr("href", "#");
                $("#next").attr("disabled", true)
            }

            //跳转制定页面
            $("#turnTo").click(function () {
                var targetPage = $("#targetPage").val();
                if (isNaN(targetPage) || targetPage === '') {
                    infoAlert("请输入正确的页码");
                    return false;
                }
                else if (parseInt(targetPage) < 0) {
                    targetPage = 1;
                }
                else if (parseInt(targetPage) > parseInt(String('<%= totalPage%>'))) {
                    targetPage = parseInt(String('<%= totalPage%>'));
                }

                window.location.href = "AllExam.aspx?pageNumber=" + targetPage;
            })

            $("body").on("click", ".change", function () {
                var TheExamId = $(this).parent().siblings(".TheExamId").html();

                if (confirm("是否确认修改")) {
                    var flag = 1;
                    var endTime = $(this).parent().siblings(".endTime").html();
                    if (!ValidTime(new Date(), new Date(endTime))) {
                        if (!confirm("当前考试已结束，是否确认修改？")) {
                            flag = 0;
                            window.location.href = "AllExam.aspx";
                            return false;
                        }
                    }

                    if (flag == 0)
                        return false;

                    $.post("ChangeNowTheExam.ashx", { TheExamId: TheExamId }, function (data) {
                        if (String(data).toLowerCase() === 'false') {
                            alert("修改失败");
                            window.location.href = "AllExam.aspx";
                        }
                        else {
                            SuAlert("修改成功");
                        }
                    })
                }
                else {
                    window.location.href = "AllExam.aspx";
                }

            })
        })
    </script>

</head>
<body>
    <form id="form1">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">考试管理</a>
            </div>

            <div id="content">
                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr class="info">
                            <%--    <td></td>--%>
                            <td>序号</td>
                            <td>考试名称</td>
                            <td>考试开始时间</td>
                            <td>考试结束时间</td>
                            <td>是否为当前考试</td>
                        </tr>
                    </thead>
                    <%if (theExams != null)
                      {%>
                    <% int index = 0; %>
                    <%foreach (var item in theExams)
                      { %>
                    <tr>
                        <%--<td>
                            <input type="checkbox" /></td>--%>
                        <td><%= ++index + (pageNumber-1)*ExamBLL.theExamPageSize %></td>
                        <td><a href="ExamePeriodManage.aspx?theExamId=<%= item.TheExamId %>"><%= item.TheExamName %></a></td>
                        <td><%= new ExamBLL().GetTheExamBeginTime(item.TheExamId.ToString()) %></td>
                        <td class="endTime"><%= new ExamBLL().GetTheExamEndTime(item.TheExamId.ToString()) %></td>
                        <td class="hidden TheExamId"><%= item.TheExamId %></td>
                        <td>
                            <input type="radio" class="change" name="nowTheExam" <%= item.IsNowTheExam == 1 ? "checked" : "" %> /></td>
                    </tr>
                    <%} %>
                    <%} %>
                </table>

                <div style="float: right; margin-right: 50px;">
                    <a id="prev" href="AllExam.aspx?pageNumber=<%=pageNumber-1 %>" class="btn btn-primary btn-xs">上一页</a>
                    <a id="next" href="AllExam.aspx?pageNumber=<%=pageNumber+1 %>" class="btn btn-primary btn-xs">下一页</a>
                    &nbsp;第<input value="<%= pageNumber %>" id="targetPage" style="width: 25px; height: 22px;" />页
                   <button type="button" class="btn btn-primary btn-xs" id="turnTo">转到</button>
                    共&nbsp;<b><%= totalPage %></b>&nbsp;页 &nbsp;&nbsp;&nbsp;&nbsp;
                    共&nbsp;<b><%= count %></b>&nbsp;次考试
                </div>
            </div>

        </div>
        <a href="/Exam/PublishExam.aspx" class="btn btn-primary" style="margin-left: 15px;">发布考试</a>
    </form>
</body>
</html>
