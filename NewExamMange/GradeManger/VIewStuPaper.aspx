<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeFile="VIewStuPaper.aspx.cs" Inherits="ExamManage_VIewPaper" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/jquery.goup.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $.goup({
                trigger: 100,
                bottomOffset: 150,
                locationOffset: 100,
                title: '返回到第一题',

                titleAsText: true

            });

            $(" .right ul li").hover(function () {
                $(this).toggleClass("blueOption");
            })
        })
    </script>


    <title></title>



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
            margin-top: 60px;
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
                padding-right: 20px;
                margin-top: 0px;
            }

            .right li {
                list-style-type: none;
                font-size: 14px;
                font-weight: 400;
                width: 750px;
                font-weight: 300;
                line-height: 20px;
                padding: 10px 15px 10px;
                margin-left: 0;
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

        .titleIndex {
            color: #1A8CFE;
        }

        .blueOption {
            background-color: #FAFAFA;
            color: #1A8CFE;
        }

        #stuInfo {
            width: 1200px;
            margin: 15px auto;
            position: relative;
            left: 200px;
        }

            #stuInfo ul {
                width: 1000px;
            }

                #stuInfo ul li {
                    list-style: none;
                    width: 160px;
                    float: left;
                }
                #stuInfo ul li.classInfo{
                    width:240px;
                }

                    #stuInfo ul li span {
                        padding-bottom: 1px;
                        border-bottom: 1px solid black;
                    }

        .red {
            color: red;
        }
    </style>



</head>
<body>
    <form id="form1" runat="server">

        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp; 
                <a href="AllExam.aspx" style="color: red">成绩管理</a>&nbsp;&gt;&gt;&nbsp;
                <a class="back" href="#" style="color: red">查看学生答题记录</a>
            </div>
            <h3><b><%= examName %>&nbsp;</b></h3>

            <div id="stuInfo">
                <ul>
                    <li><b>学号：</b><span><%= studnet.StudentId %></span></li>
                    <li><b>姓名：</b><span><%= studnet.StudentName %></span></li>
                    <li class="classInfo"><b>班级：</b><span><%= studnet.Class %></span></li>
                    <li><b>成绩:&nbsp;</b><span><%= new ExamBLL().GetStuScore(sId, exam.ExamId.ToString()) %></span>&nbsp;分</li>
                </ul>

            </div>

            <div class="right">
                <%if (sorts != null)
                  {%>
                <% int sortIndex = 0; %>
                <% foreach (var item in sorts)
                   {%>
                <h4 class="SortName"><%= ++sortIndex %>.<%= item.SortName %>&nbsp; (共<%= item.TopicSortNumber %>题&nbsp; 每题<%= item.TopicSortScore %>分)</h4>

                <% topics = new StuExamBLL().GetExamTopicBySortId(sId, exam.ExamId.ToString(), item.SortId.ToString());  %>
                <%if (topics != null)
                  {%>
                <% int topicIndex = 0;  %>
                <% foreach (var topic in topics)
                   {%>
                <div class="theTitle">
                    <div class="titleContent">
                        <%= ++topicIndex %>.&nbsp;(<%= topic.TopicType %>&nbsp; <%= topic.TopicSortScore %>分)&nbsp;
                    <span class="<%= new StuExamBLL().FormatAnswer(topic.StuAnswer) == new StuExamBLL().FormatAnswer(topic.TitleAnswer) ? "" : "red" %>"><%= topic.TopicTitle %></span>

                        (正确答案: <b><%= new StuExamBLL().FormatAnswer(topic.TitleAnswer) %></b>）
                    </div>
                    <%if (topic.TopicType.Contains("多"))
                      { %>
                    <ul>
                        <li>
                            <input type="checkbox" disabled="disabled" <%= topic.StuAnswer.ToLower().Contains("a") == true ? "checked" : "" %> />
                            A&nbsp;<%= topic.OptionA %>
                        </li>
                        <li>
                            <input type="checkbox" disabled="disabled" <%= topic.StuAnswer.ToLower().Contains("b") == true ? "checked" : "" %> />
                            B&nbsp;<%= topic.OptionB %>
                        </li>
                        <li>
                            <input type="checkbox" disabled="disabled" <%= topic.StuAnswer.ToLower().Contains("c") == true ? "checked" : "" %> />
                            C&nbsp;<%= topic.OptionC %>
                        </li>
                        <li>
                            <input type="checkbox" disabled="disabled" <%= topic.StuAnswer.ToLower().Contains("d") == true ? "checked" : "" %> />
                            D&nbsp;<%= topic.OptionD %>
                        </li>

                    </ul>
                    <%} %>
                    <% else
                      { %>

                    <ul>
                        <li>
                            <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.StuAnswer.ToLower().Contains("a") == true ? "checked" : "" %> />
                            A&nbsp;<%= topic.OptionA %>
                        </li>
                        <li>
                            <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.StuAnswer.ToLower().Contains("b") == true ? "checked" : "" %> />
                            B&nbsp;<%= topic.OptionB %>
                        </li>
                        <li>
                            <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.StuAnswer.ToLower().Contains("c") == true ? "checked" : "" %> />
                            C&nbsp;<%= topic.OptionC %>
                        </li>
                        <li>
                            <input type="radio" disabled="disabled" name="<%= sortIndex.ToString()+topicIndex.ToString() %>" <%= topic.StuAnswer.ToLower().Contains("d") == true ? "checked" : "" %> />
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
    </form>

</body>
</html>
