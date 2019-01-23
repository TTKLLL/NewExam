<%@ Page Language="C#" AutoEventWireup="true" Debug="true" CodeFile="PassCheckStu.aspx.cs" Inherits="InvigilateTeacher_PassCheckStu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>
    <title></title>

    <style type="text/css">
        #queryTab tr td {
            line-height: 37px !important;
        }

        body {
            font-size: 14px !important;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            var nowPage = parseInt('<%= pageNumber%>');
            var totalPage = parseInt('<%= totalPage%>');


            $("#prev").attr("disabled", false)
            $("#next").attr("disabled", false)

            if (totalPage == 0) {
                $("#next").attr("disabled", true);;
                $("#prev").attr("disabled", true);
            }

            if (nowPage == 1) {
                $("#prev").attr("disabled", true);
                if (totalPage == 1) {
                    $("#next").attr("disabled", true);
                }
            }
            if (totalPage == nowPage) {
                $("#next").attr("disabled", true)
            }

            //上一页
            $("#prev").click(function () {
                var page = parseInt(<%= pageNumber-1%>)
                window.location = "PassCheckStu.aspx?pageNumber=" + page + "&para=" + $("#para").val();

            })

            //下一页
            $("#next").click(function () {
                var page = parseInt(<%= pageNumber+1%>)
                window.location.href = "PassCheckStu.aspx?pageNumber=" + page + "&para=" + $("#para").val();

            })

            //查询
            $("#querty_btn").click(function () {
                window.location.href = "PassCheckStu.aspx?pageNumber=" + 1 + "&para=" + $("#para").val();
            })

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

                window.location.href = "PassCheckStu.aspx?pageNumber=" + targetPage + "&para=" + $("#para").val();
            })


            $(".checkStu").click(function () {

                var sId = $(this).parent().siblings(".StudentId").html();
                var page = parseInt(<%= pageNumber+1%>)
                window.location.href = "PassCheckStu.aspx?pageNumber=" + page
                    + "&para=" + $("#para").val() + "&sId=" + sId;
            })

            //全选
            $("#allCheck").click(function () {
                var isCheck = $(this).is(":checked")

                $("#stuTab").find("input:checkbox").each(function () {
                    $(this).attr("checked", isCheck);
                });

            })

            //登记考生
            $("#checkInStu").click(function () {
                var cks = $("#stuTab").find("input:checkbox:checked");
                if (cks.length <= 0)
                    infoAlert("请选择要返回待登记的考生");
                else {
                    if (confirm("确认取消登记")) {
                        var sIds = new Array();
                        cks.each(function () {
                            var sId = $(this).parent().siblings(".StudentId").html();
                            sIds.push(sId);
                        });

                        window.location.href = window.location.href = "PassCheckStu.aspx?pageNumber=" + nowPage
                            + "&para=" + $("#para").val() + "&sIds=" + String(sIds);
                    }
                }
            })
        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                <li><a href="WaitCheckStu.aspx">待登记考生</a></li>
                <li class="active"><a style="color: red" href="PassCheckStu.aspx">已登记考生</a></li>
            </ul>
        </div>

        <table class="table table-striped table-hover table-bordered" id="stuTab">
            <thead>
                <tr class="info">
                    <td></td>
                    <td>序号</td>
                    <td>学号</td>
                    <td>姓名</td>
                    <td>班级</td>
                    <td>联系方式</td>

                </tr>
            </thead>

            <%if (passCheckStu != null)
              {%>
            <% int index = 0; %>
            <%foreach (var item in passCheckStu)
              { %>
            <tr>
                <td>
                    <input class="choseStu" type="checkbox" /></td>
                <td><%= ++index + (pageNumber-1)*ExamBLL.CheckStuPageSize %></td>
                <td class="StudentId"><%= item.StudentId %></td>
                <td><%= item.StudentName %></td>
                <td><%= item.Class %></td>
                <td><%= item.StudentPhone %></td>

            </tr>
            <%} %>
            <%} %>
            <%else
              { %>
            <tr>
                <td colspan="6">
                    <h4><b>查询无结果</b></h4>
                </td>
            </tr>
            <%} %>
        </table>
        <span style="margin-left: 15px;"></span>
        <input type="checkbox" id="allCheck" />&nbsp;&nbsp;全选&nbsp;&nbsp;
        <button type="button" id="checkInStu" class="btn btn-danger btn-sm">返回待登记</button>

        <div style="float: right; margin-right: 50px;">
            <button id="prev" type="button" class="btn btn-primary btn-xs">上一页</button>
            <button id="next" type="button" class="btn btn-primary btn-xs">下一页</button>
            &nbsp;第<input value="<%= pageNumber %>" id="targetPage" style="width: 25px; height: 22px;" />页
                   <button type="button" class="btn btn-primary btn-xs" id="turnTo">转到</button>
            共&nbsp;<b><%= totalPage %></b>&nbsp;页 &nbsp;&nbsp;&nbsp;&nbsp;
                    共&nbsp;<b><%= count %></b>&nbsp;名考生
        </div>

        <table id="queryTab" style="line-height: 50px; margin-top: 10px;" class="table table-bordered table-condensed">
            <tr>
                <td style="width: 155px; line-height: 45px;">请输入考生信息
                </td>
                <td style="width: 200px;">
                    <input class="form-control" id="para" value="<%= para %>" />
                </td>
                <td style="width: 80px; text-align: center">
                    <button type="button" class="btn btn-primary" id="querty_btn">查询</button>
                </td>
                <td></td>

            </tr>
        </table>
    </form>
</body>
</html>
