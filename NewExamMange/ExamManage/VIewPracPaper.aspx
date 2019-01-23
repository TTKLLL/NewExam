<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeFile="VIewPracPaper.aspx.cs" Inherits="ExamManage_VIewPaper" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/jquery.goup.min.js"></script>
    <script src="../js/main.js"></script>
    <script src="../js/modernizr.js"></script>



    <title></title>

    <script type="text/javascript">
        $(function () {

            //下载题目
            $(".downloadTopic").click(function () {
                var tId = $(this).parent().parent().find(".tId")[0].textContent;
                window.location.href = "../TopicManage/DownPracticalTopic.ashx?tId=" + tId;
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
        })
    </script>

    <style type="text/css">
        .goup-text {
            font-size: 12px;
        }

        #right {
            margin-left: 15px;
        }

        h4 {
            margin-top: 20px;
        }

        h3 {
            text-align: center;
            color: #777777;
        }

        body {
            background-color: #EFF3F7;
        }

        .right {
            width: 1080px;
            width: 800px;
            margin: 15px auto;
            background-color: #FFFFFF;
            /*border-bottom:1px #DEDEDE solid;*/
            /*overflow:hidden;*/
        }

            /*一个题目*/
            .right .theTitle {
                font-size: 16px;
                padding: 30px 0;
                border: 1px #DEDEDE solid;
            }

            .right .titltInfo {
                font-weight: 600;
                font-size: 16px;
                margin-bottom: 10px;
            }


            .right .titleContent {
                margin-bottom: 10px;
                width: 1115px;
                font-size: 16px;
                margin-bottom: 10px;
                line-height: 22px;
                font-weight: 300;
                width: 800px;
                padding-left: 20px;
                padding-right:20px;
                margin-top:0px;
               
            }

            .right li {
                list-style-type: none;
                      font-size:14px;

                font-weight: 400;
                width: 750px;
                font-weight: 300;
                line-height: 20px;
                padding: 10px 15px 10px;
                margin-left:0;
            }

            .right ul {
        
                margin: 0px;
                border-bottom: 1px;
        
            }

        .changeTitle {
            margin-left: auto;
            margin-right: auto;
            padding: 3px;
            width: 260px;
            height: 80px;
        }

        .materiaContnet {
            height: 240px;
            overflow: auto;
            font-size: 16px;
            line-height: 26px;
        }

        #topic {
            width: 800px;
            margin: 15px auto;
            color: #3A3E51;
        }

        .SortName { /*766 62*/
            height: 62px;
            background-color: #FAFAFA;
            line-height: 62px;
            border-bottom: 1px solid #F0F0F7;
            color: #3A3E51;
            padding-left: 22px;
            padding-bottom: 0;
            margin-bottom: 0;
        }
        .titleIndex{
            color:#1A8CFE;
        }

        .blueOption {
            background-color:#FAFAFA;
            color:#1A8CFE;
        }
    </style>



</head>
<body>
    <form id="form1" runat="server">

        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp; 
                <a href="AllExam.aspx" style="color: red">考试管理</a>&nbsp;&gt;&gt;&nbsp;
                <a class="back" href="#" style="color: red">考试场次管理</>&nbsp;&gt;&gt;&nbsp;
               <a href="#" style="color: red">预览试卷</a>
            </div>
            <h3><b><%= examName %></b></h3>


            <table id="topicTab" class="table table-bordered table-hover table-striped">
            <thead>
                 <%int index = 0; %>
                <tr class="info">
                    <td style="width: 4%">序号</td>
                    <td style="width: 20%">题目名称</td>
                    <td style="width: 40%">题目描述</td>
                    <td style="width:20%">上传时间</td>
                    <td style="width: 9%">操作
                        </td>
                </tr>
            </thead>
           <%foreach(var item in topics) {%>
                <tr>
                    <td><%= ++index%> </td>
                    <td><a href="#" class="downloadTopic"><%= item.TopicName %></a><span class="hidden"><%= item.Tid %></span></td>
                    <td><%= item.TopicDesc %></td>
                    <td><%= item.TopicUpTime %></td>
                    <td><a href="#" class="downloadTopic">下载</a></td>
                    <td class="hidden"><span class="tId" ><%= item.Tid %></span></td>
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
        </div>
    </form>

</body>
</html>
