<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherExamManage.aspx.cs" Inherits="InvigilateTeacher_TeacherExamManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>


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
                window.location = "TeacherExamManage.aspx?pageNumber=" + page + "&para=" + $("#para").val();

            })

            //下一页
            $("#next").click(function () {
                var page = parseInt(<%= pageNumber+1%>)
                window.location.href = "TeacherExamManage.aspx?pageNumber=" + page + "&para=" + $("#para").val();

            })

            //查询
            $("#querty_btn").click(function () {
                window.location.href = "TeacherExamManage.aspx?pageNumber=" + 1 + "&para=" + $("#para").val();
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

                window.location.href = "TeacherExamManage.aspx?pageNumber=" + targetPage + "&para=" + $("#para").val();
            })


            $(".checkStu").click(function () {

                var sId = $(this).parent().siblings(".StudentId").html();
                var page = parseInt(<%= pageNumber+1%>)
                window.location.href = "TeacherExamManage.aspx?pageNumber=" + page
                    + "&para=" + $("#para").val() + "&sId=" + sId;
            })

            //全选
            $("#allCheck").click(function () {
                var isCheck = $(this).is(":checked")

                $("#nowExamStu").find("input:checkbox").each(function () {
                    $(this).attr("checked", isCheck);
                });

            })


            //登记考生
            $("#checkInStu").click(function () {
                var flag = 1;
                var cks = $("#nowExamStu").find("input:checkbox:checked");
                if (cks.length <= 0)
                    infoAlert("请选择考生");
                else {
                    if (confirm("确定重置考试状态？")) {
                        var sIds = new Array();
                        cks.each(function () {

                            var input = $(this).parent().parent().find("input[name=StudentId]")


                            var state = $(this).parent().parent().find(".ExamStateDes").html();
                            if (state === '<%= EnumHelper.GetDescription(ExamBLL.StuExamDesc.WaitCheck) %>') {
                                errAlert("该考生还未登记，无法重置");
                                flag = 0;
                                $(this).attr("checked", false);
                                return false;
                            }

                            input.attr("disabled", false);

                        });

                        if (flag == 1) {
                            $("input[name=flag]").val("0");
                            $("#form1").submit();
                        }

                    }

                }

            })

            //考生作弊
            $("#stuCheat").click(function () {
                var cks = $("#nowExamStu").find("input:checkbox:checked");
                var flag = 1;
                if (cks.length <= 0)
                    infoAlert("请选择考生");
                else {
                    if (confirm("确定设置选中的考生作弊？")) {
                        var sIds = new Array();
                        cks.each(function () {
                            var input = $(this).parent().parent().find("input[name=StudentId]")
                            var state = $(this).parent().parent().find(".ExamStateDes").html();
                            if (state === '<%= EnumHelper.GetDescription(ExamBLL.StuExamDesc.WaitCheck) %>') {
                                errAlert("该考生还未登记，无法重置");
                                flag = 0;
                                $(this).attr("checked", false);
                                return false;
                            }
                            input.attr("disabled", false);

                        });
                        if (flag == 1) {
                            $("input[name=flag]").val("1");
                            $("#form1").submit();
                        }

                    }

                }

            })
        })
    </script>


    <style type="text/css">
        #nowExamStu tr td {
            padding: 3px !important;
            line-height: 25px !important;
        }

        #queryTab tr td {
            line-height: 37px !important;
        }

        body {
            font-size: 14px !important;
        }

        .table tr td {
            padding-top: 4px !important;
            padding-bottom: 4px !important;
        }
    </style>
</head>

<body>

    <form id="form1" action="UnusualManage.aspx" method="post" runat="server">
        <div>
            <input class="hidden" name="flag" value="" />
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">考场管理</a>
            </div>

            <table class="table  table-hover table-bordered table-striped" id="nowExamStu">
                <caption>
                    <h3 style="text-align: center"><b><%= examTitle %></b></h3>
                    <%-- <%= nowExam.ExamId %>--%>
                </caption>
                <thead>
                    <tr class="info">
                        <td></td>
                        <td>序号</td>
                        <td>考号</td>
                        <td>姓名</td>
                        <td>班级</td>
                        <td>开始答题时间</td>
                        <td>交卷时间</td>
                        <td>IP地址</td>
                        <td>考试状态</td>
                    </tr>
                </thead>
                <%if (stus != null)
                  {%>
                <%int index = 0; %>
                <%foreach (var item in stus)
                  { %>
                <tr>
                    <td>
                        <input type="checkbox" /></td>
                    <td><%= ++index + (pageNumber-1)*ExamBLL.UnusualPageSize %></td>
                    <td><%= item.StudentId %></td>
                    <td class="hidden ">
                        <input disabled="disabled" name="StudentId" value="<%= item.StudentId %>" /></td>
                    <td><%= item.StudentName %></td>
                    <td><%= item.Class %></td>
          

                    <td><%= item.BeginExamTIme%></td>
                    <td><%= item.ReplyEndTime %></td>
                    <td><%= item.IPAddress %></td>
                    <% if (EnumHelper.GetDescription(ExamBLL.StuExamDesc.Cheat) == item.ExamStateDes)
                       {%>
                    <td class="ExamStateDes" style="color: red"><%= item.ExamStateDes %></td>

                    <%} %>
                    <%else
                       { %>
                    <td class="ExamStateDes"><%= item.ExamStateDes %></td>
                    <%} %>
                </tr>
                <%} %>
                <%} %>
                <%else
                  { %>
                <tr>
                    <td colspan="8">
                        <h4 style="margin-left: 20px;">查询无结果</h4>
                    </td>
                </tr>
                <%} %>
            </table>


            <div>
                <span style="margin-left: 15px;"></span>
               <%-- <input type="checkbox" id="allCheck" />&nbsp;&nbsp;全选&nbsp;&nbsp;
        <button type="button" id="checkInStu" class="btn btn-primary btn-sm">重置考生考试</button>
                <button type="button" id="stuCheat" class="btn btn-danger btn-sm">考生作弊</button>--%>
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
            </div>
        </div>
    </form>
</body>
</html>
