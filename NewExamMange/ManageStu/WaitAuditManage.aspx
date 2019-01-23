﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WaitAuditManage.aspx.cs" Inherits="Authority_WaitAuditManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../js/uploadPreview.min.js"></script>

    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>

    <style type="text/css">
        .table tr td {
            padding-top: 4px !important;
            padding-bottom: 4px !important;
        }

        #queryTab tr td {
            line-height: 37px !important;
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
                window.location = "WaitAuditManage.aspx?pageNumber=" + page + "&para=" + $("#para").val();

            })

            //下一页
            $("#next").click(function () {
                var page = parseInt(<%= pageNumber+1%>)
                window.location.href = "WaitAuditManage.aspx?pageNumber=" + page + "&para=" + $("#para").val();

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

                window.location.href = "WaitAuditManage.aspx?pageNumber=" + targetPage + "&para=" + $("#para").val();
            })

            //全选
            $("#allCheck").change(function () {

                var isChecked = $(this).prop("checked");

                $("#stuTable").find("input:checkbox").each(function () {
                    $(this).prop("checked", isChecked);
                });
            })

            //查询
            $("#querty_btn").click(function () {

                window.location.href = "?pageNumber=1&para=" + $("#para").val();
            })


            //修改某个学生考试状态
            $(".examSate").click(function () {

                var sId = $(this).parent().parent().find(".idLink").eq(0).html()
                var state = $(this).is(":checked") === true ? 1 : 0;
                $.post("ChangeExamState.ashx", { sId: sId, state: state }, function (data) {
                    if (data === "1") {
                        SuAlert("修改成功");
                    }
                    else {
                        alert("修改失败");
                        window.location.href = "?pageNumber=" + nowPage + "&para=" + $("#para").val();
                    }
                })


            })

            //批量修改考试状态
            $("#admit").click(function () {
                var idArray = new Array();
                $("#stuTable").find(".firstCheck:checked").each(function () {
                    var id = $(this).parent().parent().find(".idLink").eq(0).html()
                    idArray.push(id);
                })

                if (idArray.length <= 0) {
                    infoAlert("请选择学生!");
                    return;
                }
                $.post("ChangeState.ashx", { idArray: String(idArray), state: 2 }, function (data) {
                    if (data === "1") {
                        //$("#stuTable").find(".firstCheck:checked").each(function () {
                        //  //  alert($(this).parent().parent().find(".examSate").length)
                        //    $(this).parent().pavrent().find(".examSate").eq(0).attr("checked", true)
                        //}) 
                        layer.alert("审核成功", { icon: 1 }, function () {
                            window.location.href = "?pageNumber=" + nowPage + "&para=" + $("#para").val();
                        })
                        // SuAlert ("审核成功");


                        $("#stuTable").find(".firstCheck").attr("checked", false);
                    }
                    else {
                        layer.alert("审核失败", { icon: 1 }, function () {
                            window.location.href = "?pageNumber=" + nowPage + "&para=" + $("#para").val();
                        })

                    }
                })
            })

            $("#refuse").click(function () {
                var idArray = new Array();
                $("#stuTable").find(".firstCheck:checked").each(function () {
                    var id = $(this).parent().parent().find(".idLink").eq(0).html()
                    idArray.push(id);
                })
                if (idArray.length <= 0) {
                    alert("请选择学生!");
                    return;
                }
                else {
                    if (confirm("确定修改该学生的审核状态?")) {
                        var idArray = new Array();
                        $("#stuTable").find(".firstCheck:checked").each(function () {
                            var id = $(this).parent().parent().find(".idLink").eq(0).html()
                            idArray.push(id);
                        })


                        $.post("ChangeState.ashx", { idArray: String(idArray), state: 0 }, function (data) {
                            if (data === "1") {
                                //$("#stuTable").find(".firstCheck:checked").each(function () {
                                //  //  alert($(this).parent().parent().find(".examSate").length)
                                //    $(this).parent().parent().find(".examSate").eq(0).attr("checked", true)
                                //}) 
                                alert("修改成功");
                                window.location.href = "?pageNumber=" + nowPage + "&para=" + $("#para").val();

                                $("#stuTable").find(".firstCheck").attr("checked", false);
                            }
                            else {
                                alert("修改失败");
                                window.location.href = "?pageNumber=" + nowPage + "&para=" + $("#para").val();
                            }
                        })
                    }
                }


            })

            //导出学生信息
            $("#outPut").click(function () {

                window.location.href = "OutPutSut.ashx?para=" + $("#para").val() + "&state=1&fileName=待审核考生信息";
                //$.post("OutPutSut.ashx", { para: $("#para").val() }, function () {

                //})
            })

        })
    </script>

</head>
<body>

    <form id="form1" runat="server">
        <div>
            <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                <li class="active"><a style="color: red" href="WaitAuditManage.aspx">待审核考生</a></li>
                <li><a href="PassAuditManage.aspx">审核通过考生</a></li>
                <li><a href="FailAuditManage.aspx">未通过审核考生</a></li>
                <li><a href="AddStudent.aspx">学生信息采集</a></li>
            </ul>

            <div>
                <table id="stuTable" class="table table-striped table-hover table-bordered" style="line-height: 30px;">
                    <thead>
                        <tr class="info">
                            <td style="width: 3%"></td>
                            <td style="width: 5%">序号</td>
                            <td style="width: 10%">学号</td>
                            <td style="width: 20%">姓名</td>
                            <td style="width: 30%">班级</td>
                            <td style="width: 20%">手机号</td>

                        </tr>
                    </thead>
                    <% int index = 0; %>
                    <%if (stus != null)
                      {%>
                    <%foreach (var item in stus)
                      {%>
                    <tr>

                        <td>
                            <input class="firstCheck" type="checkbox" /></td>
                        <td><%=(pageNumber-1)*StudentBLL.StudentPageSize + (++index) %></td>
                        <td><a href="StudentDetail.aspx?sId=<%=item.StudentId %>" class="idLink"><%=item.StudentId %></a></td>
                        <td><a href="StudentDetail.aspx?sId=<%=item.StudentId %>" class="idLink"><%=item.StudentName %></a></td>
                        <td><%=item.Class %></td>
                        <td><%=item.StudentPhone %></td>


                    </tr>
                    <%} %>
                    <%} %>
                </table>


                <%if (stus != null)
                  {%>
                <div>
                    &nbsp;&nbsp;<input type="checkbox" id="allCheck" />&nbsp;全选&nbsp;
                <button type="button" id="admit" class="btn btn-primary btn-sm">通过审核</button>&nbsp;
                 <button type="button" id="refuse" class="btn btn-danger btn-sm">审核不通过</button>&nbsp;

                <div style="float: right; margin-right: 50px;">
                    <button id="prev" type="button" class="btn btn-primary btn-xs">上一页</button>
                    <button id="next" type="button" class="btn btn-primary btn-xs">下一页</button>
                    &nbsp;第<input value="<%= pageNumber %>" id="targetPage" style="width: 25px; height: 22px;" />页
                   <button type="button" class="btn btn-primary btn-xs" id="turnTo">转到</button>
                    共&nbsp;<b><%= totalPage %></b>&nbsp;页 &nbsp;&nbsp;&nbsp;&nbsp;
                    共&nbsp;<b><%= count %></b>&nbsp;名考生
                </div>


                </div>

                <%} %>
                <%else
                  { %>
                <span style="margin-left: 20px; font-weight: 400;">暂无数据</span>

                <%} %>

                <table id="queryTab" style="line-height: 50px; margin-top: 10px;" class="table table-bordered table-condensed">
                    <tr>
                        <td style="width: 155px; line-height: 45px;">请输入学生姓名或班级
                        </td>
                        <td style="width: 200px;">
                            <input class="form-control" id="para" value="<%= query %>" />
                        </td>
                        <td style="width: 80px; text-align: center">
                            <button type="button" class="btn btn-primary" id="querty_btn">查询</button>
                        </td>
                        <td>
                            <%--       <a href="ImportStu.aspx" type="button" class="btn btn-primary">导入考生信息</a>--%>
                            <button type="button" class="btn btn-primary" id="outPut">导出考生信息</button>

                        </td>
                    </tr>
                </table>

            </div>
        </div>


    </form>
</body>
</html>
