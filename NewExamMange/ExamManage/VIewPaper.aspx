<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeFile="VIewPaper.aspx.cs" Inherits="ExamManage_VIewPaper" %>

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

            $.goup({
                trigger: 100,
                bottomOffset: 150,
                locationOffset: 100,
                title: '返回到第一题',

                titleAsText: true

            });

            $(".back").click(function () {
                window.location.href = "ExamePeriodManage.aspx?theExamId=<%= theExamId%>";
            })

            var nowPage = parseInt('<%= pageNumber%>');
            var totalPage = parseInt('<%= totalPage%>');
            var examId = '<%= examId%>'

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
                window.location = "VIewPaper.aspx?pageNumber=" + page + "&examId=" + examId; + "&examId=" + examId;

            })

            //下一页
            $("#next").click(function () {
                var page = parseInt(<%= pageNumber+1%>)
                window.location.href = "VIewPaper.aspx?pageNumber=" + page + "&examId=" + examId;;

            })



            //跳转制定页面
            $("#turnTo").click(function () {
                var targetPage = $("#targetPage").val();
                if (isNaN(targetPage) || targetPage === '') {
                    alert("请输入正确的页码");
                    return false;
                }
                else if (parseInt(targetPage) < 0) {
                    targetPage = 1;
                }
                else if (parseInt(targetPage) > parseInt(String('<%= totalPage%>'))) {
                    targetPage = parseInt(String('<%= totalPage%>'));
                }

                window.location.href = "VIewPaper.aspx?pageNumber=" + targetPage + "&examId=" + examId;;
            })

            $(" .right ul li").hover(function () {
                $(this).toggleClass("blueOption");
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
            <h3><b><%= examName %>&nbsp;(第&nbsp;<%= pageNumber %>&nbsp;套试卷)</b></h3>

            <div class="right">
                <div id="topic">
                    <%if (sorts != null)
                      {%>
                    <% int sortIndex = 0; %>
                    <% foreach (var item in sorts)
                       {%>
                    <h4 class="SortName"><%= ++sortIndex %>.<%= item.SortName %>&nbsp; (共<%= item.TopicSortNumber %>题&nbsp; 每题<%= item.TopicSortScore %>分)</h4>

                    <% topics = new ExamBLL().GetTopicByPaperIdBySortId(paper.PaperId.ToString(), item.SortId.ToString());  %>
                    <%if (topics != null)
                      {%>
                    <% int topicIndex = 0;  %>
                    <% foreach (var topic in topics)
                       {%>
                    <div class="theTitle">
                        <div class="titleContent">
                       <span class="titleIndex"><%= ++topicIndex %></span>.&nbsp;(<%= topic.TopicType %>)&nbsp;<%= topic.TopicTitle %>
                        </div>
                        <%if (topic.TopicType.Contains("多"))
                          { %>
                        <ul>
                            <li>
                                <input type="checkbox" disabled="disabled" <%= topic.TitleAnswer.ToLower().Contains("a") == true ? "checked" : "" %> />
                                A&nbsp;<%= topic.OptionA %>
                            </li>
                            <li>
                                <input type="checkbox" disabled="disabled" <%= topic.TitleAnswer.ToLower().Contains("b") == true ? "checked" : "" %> />
                                B&nbsp;<%= topic.OptionB %>
                            </li>
                            <li>
                                <input type="checkbox" disabled="disabled" <%= topic.TitleAnswer.ToLower().Contains("c") == true ? "checked" : "" %> />
                                C&nbsp;<%= topic.OptionC %>
                            </li>
                            <li>
                                <input type="checkbox" disabled="disabled" <%= topic.TitleAnswer.ToLower().Contains("d") == true ? "checked" : "" %> />
                                D&nbsp;<%= topic.OptionD %>
                            </li>

                        </ul>
                        <%} %>
                        <% else
                          { %>

                        <ul>
                            <li>
                                <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.TitleAnswer.ToLower().Contains("a") == true ? "checked" : "" %> />
                                A&nbsp;<%= topic.OptionA %>
                            </li>
                            <li>
                                <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.TitleAnswer.ToLower().Contains("b") == true ? "checked" : "" %> />
                                B&nbsp;<%= topic.OptionB %>
                            </li>
                            <li>
                                <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.TitleAnswer.ToLower().Contains("c") == true ? "checked" : "" %> />
                                C&nbsp;<%= topic.OptionC %>
                            </li>
                            <li>
                                <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.TitleAnswer.ToLower().Contains("d") == true ? "checked" : "" %> />
                                D&nbsp;<%= topic.OptionD %>
                            </li>

                        </ul>
                        <%} %>
                    </div>

                    <%} %>
                    <%} %>
                    <%} %>

                    <%} %>
                </div>


            </div>



            <div style="float: right; margin-right: 50px; margin-bottom: 50px;">
                <button type="button" class="btn btn-primary btn-xs back">返回</button>
                <button id="prev" type="button" class="btn btn-primary btn-xs">上一页</button>
                <button id="next" type="button" class="btn btn-primary btn-xs">下一页</button>
                &nbsp;第<input value="<%= pageNumber %>" id="targetPage" style="width: 35px; height: 22px; text-align: center" />
                <button type="button" class="btn btn-primary btn-xs" id="turnTo">转到</button>
                共&nbsp;<b><%= totalPage %></b>&nbsp;套试卷 &nbsp;&nbsp;&nbsp;&nbsp;
       
            </div>
        </div>
    </form>

</body>
</html>
