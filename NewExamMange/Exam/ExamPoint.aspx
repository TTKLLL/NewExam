<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamPoint.aspx.cs" Inherits="Exam_ExamPoint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />


    <style type="text/css">
      
        .secondPoint ul {
            width: 900px;
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

            .secondPoint ul li {
                width: 300px;
                float: left;
            }

        #head {
            padding-top: 8px;
            padding-bottom: 8px;
            color: #777;
            text-align: left;
     
            width:380px;
            margin-left:auto;
            margin-right:auto;
        }
    </style>

    <script type="text/javascript">
        $(function () {

            //点击伸缩二级知识点
            $(".firstPoint").click(function () {
                $(this).parent().siblings(".secondPoint").slideToggle()
            })

            //全选二级知识点
            $(".allCheck").click(function () {
                var firstId = $(this).siblings(".firstId").eq(0).html();
                // alert(firstId);

                var cks = $(this).parent().parent().siblings(".secondPoint").find("input")
                var isCheck = $(this).is(":checked");
                var state = String(isCheck).toLowerCase() == "true" ? 1 : 0;
                $.post("ChangePointChose.ashx", { firstId: firstId, state: state }, function (data) {
                    if (String(data).toLowerCase() == "false") {
                        alert("修改失败");
                    }
                    else {
                        //  alert("修改成功");
                        if (isCheck) {
                            cks.attr("checked", "checked");
                        }
                        else {

                            cks.attr("checked", false);
                        }
                    }

                })




            })

            //修改二级知识点选中状态
            $(".changeChose").click(function () {
                var that = $(this);
                var secondId = $(this).siblings(".secondId").html();
           
                var state
                var isCheck = $(this).is(":checked")
                if (isCheck)
                    state = 1;
                else
                    state = 0;

                $.post("ChangePointChose.ashx", { secondId: secondId, state: state }, function (data) {
                    // alert(String(data).toUpperCase())
                    if (String(data).toLowerCase() === 'false') {
                        alert("修改失败")
                        that.attr("checked", !isCheck);
                    }
                    else {
                        var cks = that.parent().parent().parent().find("input:checkbox");
                        var flag = 1;  //判断该这些二级知识点是否为全选
                        cks.each(function () {
                            if (!$(this).is(":checked"))
                                flag = 0;
                        })

                        //该一级知识点的全选框
                        var allCheck = that.parent().parent().parent().siblings(".panel-heading").find(".allCheck").eq(0);
                        if (flag == 0)
                            allCheck.attr("checked", false);
                        else
                            allCheck.attr("checked", true);

                    }

                })
            })

        })


    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
                <li><a href="ExamTopicScource.aspx">题库选择</a></li>
                <li class="active"><a style="color: red" href="ExamPoint.aspx">知要考试的识点</a></li>
                <li><a href="ExamSort.aspx">题目数量设置</a></li>

            </ul>

            <h4 id="head" style="text-align: center"><b>请选择知识点</b></h4>
            <% int firstIndex = 0; %>
            <%if (ExamPoint_S != null)
              {%>

            <%foreach (var item in ExamPoint_S)
              { %>
            <div class="panel panel-default thePoint">
                <div class="panel-heading ">
                    <h4 class="panel-title firstPoint"><%= ++firstIndex %>&nbsp; <%= item.firstPoint.FirstPointName %> </h4>
                    <span style="float: right; margin-right: 15px; position: relative; top: -15px;">
                        <input type="checkbox" class="allCheck"
                            <%= item.IsAllChose == 1 ? "checked" : "" %> />&nbsp;全选
                        <span class="hidden firstId"><%=item.firstPoint.FirstPointId %></span>
                    </span>
                </div>

                <% int secondIndex = 0; %>
                <div class="panel-body secondPoint" style="display: none; margin-left: 15px;">
                    <%foreach (var subItem in item.secondPoints)
                      {%>

                    <ul>
                        <li><%= firstIndex+ "."+ ++secondIndex %>&nbsp; <%= subItem.SecondPointName %><b>(<%=subItem.canChoseNumber%>)</b>
                            <input type="checkbox" class="changeChose"
                                <%=subItem.IsChose == 1 ? "checked" : "" %> /> 
                            <%--<span style="width:40px; float:right; margin-right:20px;"><input style="width:40px" /></span> --%>
                            <span class="hidden secondId"><%=subItem.SecondPointId %></span>
                        </li>
                    </ul>



                    <%} %>
                </div>
            </div>
            <%} %>
            <%} %>
        </div>
    </form>
</body>
</html>
