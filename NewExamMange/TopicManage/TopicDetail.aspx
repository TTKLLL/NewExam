<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TopicDetail.aspx.cs" Inherits="Admin_TopicManage_AddTopic" %>
<%--此页面未使用 具体内容已整合到TopicInfo.aspx中--%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <script src="../js/jquery.validate.min.js"></script>
    <script src="../js/jquery.validate.messages_cn.js"></script>
    <script src="../js/jquery-form.js"></script>

    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
 <%--   <link href="../../css/teacher.css" rel="stylesheet" />
    <link href="../../css/TabStyle.css" rel="stylesheet" />
    <link href="../../css/L.layout.css" rel="stylesheet" />
    <link href="../../css/common.css" rel="stylesheet" />--%>

    <style type="text/css">
        body {
            font-size: 14px;
        }

        textarea {
            width: 750px;
            height: 100px;
            overflow: auto;
        }

        #optionA, #optionB, #optionC, #optionD {
            height: 90px;
        }

        .errorInfo {
            color: red;
        }

        #topicDetailTab tr td:first-child{
            text-align:right;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $("#back").click(function () {
                history.back(-1);
            })


            $(".answer").click(function () {
                if ($(".answer:checked").length > 1) {
                    $("#multipleRadio").get(0).checked = true;

                }
                else if ($(".answer:checked").length == 1) {
                    $("#singeleRadio").get(0).checked = true;

                }

            })

            //选择一级知识点
            $("#first").change(function () {
                //alert("a")
                $("#allSecond").siblings().remove();
                var firstId = $(this).val();
                if (firstId != '0') {
                    $.post("GetSecondByFirst.ashx?firstId=" + firstId, function (data) {
                        // alert(String(data))

                        var obj = JSON.parse(data);
                        var array = obj.secondPoints;

                        $("#second").find("option").remove();  //清楚原来的二级知识点
                        for (var i = 0; i < array.length; i++) {
                            var str = '<option value="' + array[i].SecondPointId + '">'
                                + array[i].SecondPointName + '</option>';
                            $("#second").append(str);

                        }
                    })
                }

            })


            //更新
            $("#update").click(function () {

                //c alert($("#updateForm").serialize())

                if ($("#updateForm").valid() == true) {
                    if ($("input:checkbox[class=answer]:checked").length == 0)
                        alert("请选择题目答案");
                    else {
                        $("#updateForm").ajaxSubmit(function (data) {
                            if (String(data) === "1") {
                                alert("修改成功");
                                //history.back(-1);
                            }

                        });
                    }
                }
                else {
                    alert("请填写题目完整信息");
                }

            })

            $("#updateForm").valid(
                {
                    rules: {
                        "title": { required: true },
                        "optionA": { required: true },
                        "optionB": { required: true },
                        "optionC": { required: true },
                        "optionD": { required: true }
                    },
                    errorPlacement: function (error, element) {
                        error.append(element.siblings("span"))
                    }
                }
          );

        })
    </script>
</head>
<body>
    <form id="updateForm" method="post" action="UpdateTopic.ashx">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
            <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">题库管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">题目详情</a>
        </div>

            <div class="addTopic">
                <table class="addTitle table table-bordered table-striped" id="topicDetailTab">
                    <tr>
                        <td>知识点：</td>
                        <td>
                            <div class="input-group" style="width:800px;">
                                 <select name="first" style="width:284px;" id="first" class="form-control">
                               
                                <%foreach (var point in firstPoint)
                                  { %>
                                <option value="<%= point.FirstPointId %>"
                                    <%= new PointService().GetSecondPointById(int.Parse(topic.SecondPointId.ToString())).FIrstPointId ==  point.FirstPointId ? "selected" : ""%>><%= point.FirstPointName %></option>
                                <%} %>
                            </select>&nbsp;<span class="errorInfo"></span>
                          
                       <select name="second" style="width:284px; margin-left:20px;" id="second" class="form-control">
                           
                           <%foreach (var item in secondPoint)
                             { %>
                           <option value="<%=item.SecondPointId %>" <%= item.SecondPointId == topic.SecondPointId ? "selected" : "" %>><%= item.SecondPointName %></option>
                           <%} %>
                       </select>
                            </div>
                           
                        </td>
                    </tr>
                    <tr>
                        <td>题目类别：</td>
                        <td>
                            <select name="sort" class="form-control" style="width:284px;">
                                <%foreach (var item in sort)
                                  {%>
                                <option value="<%=item.SortId %>" <%= item.SortId == topic.SortId ? "selected" : "" %>><%=item.SortName %></option>
                                <%} %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>所属题库：</td>
                        <td>
                            <select name="source" class="form-control" style="width:284px;">
                                <%foreach (var item in topicSource)
                                  {%>
                                <option value="<%=item %>" <%= item.TopicSourceId == topic.TopicSourceId ? "selected" : "" %>><%=item.TopicSourceName %></option>
                                <%} %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>题目标题：</td>
                        <td>
                            <textarea class="form-control" name="title" id="title" ><%= topic.TopicTitle %></textarea>


                        </td>
                    </tr>
                    <tr>
                        <td>选项A：</td>
                        <td>
                            <textarea class="form-control" name="optionA" id="optionA" ><%= topic.OptionA %></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>选项B：</td>
                        <td>
                            <textarea class="form-control" name="optionB" id="optionB" ><%= topic.OptionB %></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>选项C：</td>
                        <td>
                            <textarea class="form-control" name="optionC" id="optionC" ><%= topic.OptionC %></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>选项D：</td>
                        <td>
                            <textarea class="form-control" name="optionD" id="optionD" ><%= topic.OptionD %></textarea>
                        </td>
                    </tr>

                    <tr>
                        <td>正确答案：</td>
                        <td>
                            <div class="multipleTopic">
                                <input name="answerA" class="answer " type="checkbox" <%= topic.TitleAnswer.Contains("A") ? "checked" : "" %> />
                                A
                                <input name="answerB" class="answer" type="checkbox" <%= topic.TitleAnswer.Contains("B") ? "checked" : "" %> />
                                B
                                <input name="answerC" class="answer" type="checkbox" <%= topic.TitleAnswer.Contains("C") ? "checked" : "" %> />
                                C
                                <input name="answerD" class="answer" type="checkbox" <%= topic.TitleAnswer.Contains("D") ? "checked" : "" %> />
                                D
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>题目类型：</td>
                        <td>
                            <input name="type" value="单选题" type="radio" class="topicType" <%= topic.TopicType.Contains("单") ? "checked" : "" %> id="singeleRadio" name="topicType" />单选题
                            <input name="type" value="多选题" type="radio" class="topicType" <%= topic.TopicType.Contains("多") ? "checked" : "" %> id="multipleRadio" name="topicType" />多选题
                        </td>
                    </tr>
                    <tr>
                        <td>题目审核状态：</td>
                        <td>
                            <select name="TopicState" class="form-control" style="width:130px;">
                                <option value="<%= (int)TopicBLL.TopicState.WaitAudit %>"
                                    <%= (int)TopicBLL.TopicState.WaitAudit == topic.TopicState ? "selected" : ""  %>>待审核</option>
                                <option value="<%= (int)TopicBLL.TopicState.PassAudit %>"
                                    <%= (int)TopicBLL.TopicState.PassAudit == topic.TopicState ? "selected" : ""  %>>通过审核</option>
                                <option value="<%= (int)TopicBLL.TopicState.FailAudit %>"
                                    <%= (int)TopicBLL.TopicState.FailAudit == topic.TopicState ? "selected" : ""  %>>未通过审核</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <button type="button" id="update" class="btn btn-primary" >确认修改</button>&nbsp;&nbsp;
                            <button type="button" class="btn btn-primary" id="back">返回</button>

                        </td>
                    </tr>
                </table>
            </div>
            <input name="topicId" type="hidden" value="<%= topic.TopicId %>" />
        </div>



    </form>
</body>
</html>
