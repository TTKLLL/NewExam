<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PracticalTopic.aspx.cs" Inherits="TopicManage_PracticalTopic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <%--    <script src="../js/jquery-1.8.3.min.js"></script>--%>
    <script src="../js/jquery1.7.min.js"></script>
    <script src="../js/jquery-form.js"></script>

    <script src="../js/jquery.validate.min.js"></script>
    <script src="../js/jquery.validate.messages_cn.js"></script>
    <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>
    <script src="../js/jquery-form.js"></script>

    <script type="text/javascript">
        $(function () {

            //下载题目
            $(".downloadTopic").click(function () {
                var tId = $(this).parent().parent().find(".tId")[0].textContent;
                window.location.href = "DownPracticalTopic.ashx?tId=" + tId;
            });

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
                window.location = "?pageNumber=" + page + "&para=" + $("#para").val();

            })

            //下一页
            $("#next").click(function () {
                var page = parseInt(<%= pageNumber+1%>)
                window.location.href = "?pageNumber=" + page + "&para=" + $("#para").val();

            })

            //跳转制定页面
            $("#turnTo").click(function () {
                var targetPage = $("#targetPage").val();
                if (isNaN(targetPage) || targetPage === '' || parseInt(targetPage) <= 0) {
                    infoAlert("请输入正确的页码");
                    return false;
                }
                else if (parseInt(targetPage) < 0) {
                    targetPage = 1;
                }
                else if (parseInt(targetPage) > parseInt(String('<%= totalPage%>'))) {
                    targetPage = parseInt(String('<%= totalPage%>'));
                }

                window.location.href = "?pageNumber=" + targetPage + "&para=" + $("#para").val();
            })


            //查询
            $("#querty_btn").click(function () {
                window.location.href = "?pageNumber=" + 1 + "&para=" + $("#para").val();
            })

            $(".deleteTopic").click(function () {

                var tId = $(this).parent().parent().find(".tId")[0].textContent;
                layer.confirm('确定删除该题目', { btn: ['确认', '取消'] }, function () {
                   
                    window.location.href = "?tId=" + tId + "&delete=1";

                },
                    function () {
                        layer.closeAll();
                    })
            })
        })
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">题库管理</a>
            </div>

            <table id="topicTab" class="table table-bordered table-hover table-striped">
                <thead>
                    <%int index = 0; %>
                    <tr class="info">
                        <td style="width: 4%">序号</td>
                        <td style="width: 20%">题目名称</td>
                        <td style="width: 40%">题目描述</td>
                        <td style="width: 20%">上传时间</td>
                        <td style="width: 9%">操作
                        </td>
                    </tr>
                </thead>
                <%foreach (var item in topics)
                  {%>
                <tr>
                    <td><%= ++index%> </td>
                    <td><a href="#" class="downloadTopic"><%= item.TopicName %></a><span class="hidden"><%= item.Tid %></span></td>
                    <td><%= item.TopicDesc %></td>
                    <td><%= item.TopicUpTime %></td>
                    <td><a href="#" class="downloadTopic">下载</a>
                        <a href="#" style="color:red; margin-left:20px;" class="deleteTopic">删除</a>
                    </td>
                    <td class="hidden"><span class="tId"><%= item.Tid %></span></td>
                </tr>

                <%} %>
            </table>
            <div style="float: right; margin-right: 50px;">
                <button id="prev" type="button" class="btn btn-primary btn-xs">上一页</button>
                <button id="next" type="button" class="btn btn-primary btn-xs">下一页</button>
                &nbsp;第<input value="<%= pageNumber %>" id="targetPage" style="width: 25px; height: 22px;" />页
                   <button type="button" class="btn btn-primary btn-xs" id="turnTo">转到</button>
                共&nbsp;<b><%= totalPage %></b>&nbsp;页 &nbsp;&nbsp;&nbsp;&nbsp;
                    共&nbsp;<b><%= count %></b>&nbsp;题
            </div>


            <table style="line-height: 50px; margin-top: 10px;" id="queryTab" class="table table-bordered table-condensed">
                <tr>
                    <td style="width: 155px; line-height: 45px;">请输入题目标题或描述
                    </td>
                    <td style="width: 200px;">
                        <input class="form-control" id="para" value="<%= para %>" />
                    </td>
                    <td style="width: 80px; text-align: center">
                        <button type="button" class="btn btn-primary" id="querty_btn">查询</button>
                    </td>
                    <td>
                        <%--       <a href="ImportStu.aspx" type="button" class="btn btn-primary">导入考生信息</a>--%>
                        <a href="InputPracticalTopic.aspx" style="margin-left: 10px;" class="btn btn-primary">添加题目</a>

                    </td>
                </tr>
            </table>


        </div>
    </form>
</body>
</html>
