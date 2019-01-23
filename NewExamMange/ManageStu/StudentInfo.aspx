<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentInfo.aspx.cs" Inherits="Admin_ManageStu_StudentInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../js/uploadPreview.min.js"></script>

    <script type="text/javascript">



        $(function () {

            var nowPage = $("#toPage").val();

            //  $(".pageLink").attr("href", $("#pageLink").attr("href")+"&query="+$("#query").val())
            var oldLink = $(".pageLink").attr("href");

            var query = $("#query").val()
            $(".pageLink").attr("href", oldLink + "&query=" + query)
            var old_idLInk = $(".idLInk").attr("href");
            // $(".idLink").attr("herf", old_idLInk + "&pageNumber=" + nowPage + "&query=" + $("#query").val());

            $("#query").change(function () {
                var query = $("#query").val()
                $(".pageLink").attr("href", oldLink + "&query=" + query)
                // $(".idLink").attr("herf", old_idLInk + "&pageNumber=" + nowPage + "&query=" + $("#query").val());
            })

            //跳转指定页
            $("#turnTo").click(function () {
                var number = $("#toPage").val();
                if (number == "" || isNaN(number)) {
                    alert("请输入正确的页码");
                }
                else
                    window.location.href = "?pageNumber=" + number;
            })

            //全选
            $("#allCheck").change(function () {

                if ($(this).is(":checked")) {


                    $("#stuTable").find(".firstCheck").attr("checked", true)
                }
                else {
                    $("#stuTable").find(".firstCheck").attr("checked", false)
                }


            })

            //查询
            $("#querty_btn").click(function () {

                window.location.href = "?pageNumber=1&query=" + $("#query").val();
            })


            //修改某个学生考试状态
            $(".examSate").click(function () {

                var sId = $(this).parent().parent().find(".idLink").eq(0).html()
                var state = $(this).is(":checked") === true ? 1 : 0;
                $.post("ChangeExamState.ashx", { sId: sId, state: state }, function (data) {
                    if (data === "1") {
                        alert("修改成功");
                    }
                    else {
                        alert("修改失败");
                        window.location.href = "?pageNumber=" + nowPage + "&query=" + $("#query").val();
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
                $.post("ChangeExamState.ashx", { idArray: String(idArray), state: 1 }, function (data) {
                    if (data === "1") {
                        //$("#stuTable").find(".firstCheck:checked").each(function () {
                        //  //  alert($(this).parent().parent().find(".examSate").length)
                        //    $(this).parent().parent().find(".examSate").eq(0).attr("checked", true)
                        //}) 
                        alert("修改成功");
                        window.location.href = "?pageNumber=" + nowPage + "&query=" + $("#query").val();

                        $("#stuTable").find(".firstCheck").attr("checked", false);
                    }
                    else {
                        alert("修改失败");
                        window.location.href = "?pageNumber=" + nowPage + "&query=" + $("#query").val();
                    }
                })
            })

            $("#refuse").click(function () {
                if (confirm("确定取消该学生考试状态?")) {
                    var idArray = new Array();
                    $("#stuTable").find(".firstCheck:checked").each(function () {
                        var id = $(this).parent().parent().find(".idLink").eq(0).html()
                        idArray.push(id);
                    })
                    $.post("ChangeExamState.ashx", { idArray: String(idArray), state: 0 }, function (data) {
                        if (data === "1") {
                            //$("#stuTable").find(".firstCheck:checked").each(function () {
                            //  //  alert($(this).parent().parent().find(".examSate").length)
                            //    $(this).parent().parent().find(".examSate").eq(0).attr("checked", true)
                            //}) 
                            alert("修改成功");
                            window.location.href = "?pageNumber=" + nowPage + "&query=" + $("#query").val();

                            $("#stuTable").find(".firstCheck").attr("checked", false);
                        }
                        else {
                            alert("修改失败");
                            window.location.href = "?pageNumber=" + nowPage + "&query=" + $("#query").val();
                        }
                    })
                }

            })

            //导出学生信息
            $("#outPut").click(function () {
          
                window.location.href = "OutPutSut.ashx?query=" + $("#query").val();
                //$.post("OutPutSut.ashx", { query: $("#query").val() }, function () {
                 
                //})
            })

        })
    </script>

</head>
<body>

    <form id="form1" runat="server">


        <div>

            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">考生信息管理</a>
            </div>

            <div>
                <table id="stuTable" class="table table-striped table-hover table-bordered" style="line-height: 30px;">
                    <thead>
                        <tr class="info">
                            <td style="width: 3%"></td>
                            <td style="width: 10%">学号</td>
                            <td style="width: 20%">姓名</td>
                            <td style="width: 30%">班级</td>
                            <td style="width: 25%">手机号</td>
                            <td style="width: 70%">是否允许参加考试</td>

                        </tr>
                    </thead>
                    <%foreach (var item in stus)
                      {%>
                    <tr>
                        <td>
                            <input class="firstCheck" type="checkbox" /></td>
                        <td><a href="StudentDetail.aspx?sId=<%=item.StudentId %>" class="idLink"><%=item.StudentId %></a></td>
                        <td><a href="StudentDetail.aspx?sId=<%=item.StudentId %>" class="idLink"><%=item.StudentName %></a></td>
                        <td><%=item.Class %></td>
                        <td><%=item.StudentPhone %></td>
                        <td>

                            <input class="examSate" type="checkbox" <%=item.StuExamState != 0 ? "checked" : "" %> /></td>

                    </tr>
                    <%} %>
                </table>

                &nbsp;&nbsp;<input type="checkbox" id="allCheck" />&nbsp;全选&nbsp;
                <button type="button" id="admit" class="btn btn-primary btn-sm">允许参加考试</button>&nbsp;
                <button type="button" id="refuse" class="btn btn-danger btn-sm">不允许参加考试</button>

                <div style="float: right; margin-right: 50px;">
                    <%if (pageNumber == 1)
                      {%>
                    <a href="#" class="disabled btn btn-primary btn-xs">上一页</a>
                    <%} %>
                    <%else
                      { %>
                    <a href="StudentInfo.aspx?pageNumber=<%= pageNumber-1 %>" class="pageLink btn btn-primary btn-xs">上一页</a>
                    <%} %>

                    <%if (pageNumber == totalPage)
                      {%>
                    <a href="#" class="disabled btn btn-primary btn-xs">下一页</a>
                    <%} %>
                    <%else
                      { %>
                    <a href="StudentInfo.aspx?pageNumber=<%= pageNumber+1 %>" class="pageLink btn btn-primary btn-xs">下一页</a>
                    <%} %>

                    &nbsp;第<input id="toPage" value="<%= pageNumber %>" style="width: 25px; height: 22px;" />页
                   <button type="button" id="turnTo" class="btn btn-primary btn-xs">转到</button>
                    共&nbsp;<%= totalPage %>&nbsp;页
                </div>

                <table style="line-height: 50px; margin-top: 10px;" class="table table-bordered table-condensed">
                    <tr>
                        <td style="width: 155px; line-height: 45px;">请输入学生姓名或班级
                        </td>
                        <td style="width: 200px;">
                            <input class="form-control" id="query" value="<%= query %>" />
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary" id="querty_btn">查询</button>
                        </td>
                        <td>
                            <a href="ImportStu.aspx" type="button"  class="btn btn-primary">导入考生信息</a>
                            <button type="button" class="btn btn-primary" id="outPut">导出考生信息</button>

                        </td>
                    </tr>
                </table>
            </div>
        </div>


    </form>
</body>
</html>--%>
