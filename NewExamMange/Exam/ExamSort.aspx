<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamSort.aspx.cs" Inherits="Exam_ExamSort" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <title></title>

    <style type="text/css">
        input {
            font-weight: 600;
            font-size: 14px;
            text-align: center;
        }
        #sortTab tbody tr td{
            line-height:37px !important;
        }
    </style>

    <script type="text/javascript">
        $(function () {

            //y验证题目数量
            $(".TopicNumber input").change(function () {

                var maxNumber = parseInt($(this).parent().siblings(".CanUseNumber").eq(0).find("b").eq(0).html());

                if (isNaN($(this).val())) {
                    alert("请输入合法的数字");
                    $(this).val("")
                    return false;
                }
                var number = parseInt($(this).val());
                if (number > maxNumber || number < 0) {
                    alert("请输入正确的题目数量");
                    $(this).val("")
                    return false;
                }
            })

            //验证题目分数
            $(".TopicSortScore input").change(function () {

                var score = $(this).val();
                if (isNaN(score)) {
                    alert("请输入合法的分值");
                    $(this).val("")
                    return false;
                }

                if (score < 0) {
                    alert("请输入正确的分值");
                    $(this).val("")
                    return false;
                }
            })

            //保存
            $("#svae").click(function () {
                var flag = 1;
                $("#sortTab tbody").find("tr").each(function () {
                    var score = $(this).find(".TopicSortScore input").eq(0).val()
                    var number = $(this).find(".TopicNumber input").eq(0).val()
                    var max = parseInt($(this).find(".CanUseNumber b").html());

                    if (score === '') {
                        alert("请输入题目分值");
                        flag = 0;
                        return false;
                    }
                    if (number === '') {
                        alert("请输入题目数量");
                        flag = 0;
                        return false;
                    }

                    if (number > max) {
                        alert("请输入正确的题目数量");
                        flag = 0;
                        return false;
                    }
                });
                if(flag == 1)
                    $("#form1").submit();
            });
        })
    </script>
</head>
<body>
    <form id="form1" action="ExamSort.aspx" method="post">
        <div>
            <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                <li><a href="ExamTopicScource.aspx">题库选择</a></li>
                <li><a href="ExamPoint.aspx">知识点选择</a></li>
                <li class="active"><a style="color: red" href="ExamSort.aspx">题目类别设置</a></li>

            </ul>

            <table class="table table-hover table-bordered table-striped" id="sortTab">
                <caption>
                    <h4 style="text-align: center"><b>设置题目类别</b></h4>
                </caption>
                <thead>
                    <tr class="info">
                        <td>题目类别名称
                        </td>
                        <td>可用题目数量
                        </td>
                        <td>选择题目数量
                        </td>
                        <td>每题分值
                        </td>
                    </tr>
                </thead>
                <%if (examSorts != null)
                  {%>
                <%foreach (var item in examSorts)
                  {%>
                <tr>
                    <td class="hidden id">
                        <input class="hidden" name="SortId" value="<%= item.SortId %>" /></td>
                    <td><%=item.SortName %></td>
                    <td class="CanUseNumber"><b><%= item.CanUseNumber %></b> 题</td>
                    <td class="TopicNumber">
                        <input style="width: 70px;" class="form-control" required name="TopicSortNumber" value="<%= item.TopicSortNumber %>" />
                      </td>
                    <td class="TopicSortScore"><input class="form-control" name="TopicSortScore" required style="width: 70px;" value="<%= item.TopicSortScore %>" />
                    </td>

                </tr>

                <%} %>
                <%} %>
                <tr style="height: 40px;">
                    <td colspan="4" style="line-height: 40px;">试卷总分&nbsp;<b><%=totalScore %></b>&nbsp;分
                    </td>
                </tr>
                <tfoot>
                    <tr>
                        <td colspan="4">
                            <button style="margin-left: 20px;" id="svae" type="button" class="btn btn-primary">保存</button>
                        </td>
                    </tr>
                </tfoot>
            </table>

            
        </div>
    </form>
</body>
</html>
