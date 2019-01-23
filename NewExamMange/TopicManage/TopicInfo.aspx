<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TopicInfo.aspx.cs" Inherits="Admin_TopicManage_ManageTopic" %>

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



    <style type="text/css">
        .table tr td {
            padding-top: 4px !important;
            padding-bottom: 4px !important;
        }

        #advanceQueryTab tr td {
            height: 37px !important;
            line-height: 37px !important;
        }

        #twoQuery table tr td {
            height: 30px !important;
            line-height: 30px;
        }
    </style>


    <script type="text/javascript">

        pageNumber = 1;  //当前页
        totalPage = 1;   //总页数
        //获取数据
        function GetDate(para) {
            $(".noResult").hide(); //隐藏提示信息

            $.ajax({
                url: "GetTopics.ashx?page=" + para + '&' + $("#queryForm").serialize(),
                type: 'post',
                timeout: 150000,

                //获取数据前
                beforeSend: function (XMLHttpRequest) {
                    //index = layer.load(0, { shade: false }); //0代表加载的风格，支持0-2

                },


                //获取数据失败
                error: function (XMLHttpRequest, textStatus, errorThrown) {


                },

                //获取数据成功
                success: function (data) {

                    //   alert($("#queryForm").serialize())
                    //alert(String(data))

                    var obj = JSON.parse(data);

                    $("#topicTab").find("tbody").find("tr").remove();


                    pageNumber = parseInt(obj.pageNumber)
                    totalPage = parseInt(obj.totalPage)
                    $("#pageNumber").val(pageNumber);
                    $("#totalPage").html(totalPage);


                    $(".topicNumber b").html(obj.totalCount);
                    totalPage = obj.totalPage

                    if (totalPage === '0') {  //页数为0时直接跳出
                        $(".noResult").show();
                        $("#pre").attr("disabled", true);
                        $("#next").attr("disabled", true);
                        return false;
                    }

                    //设置翻页按钮
                    if (pageNumber == 1) {

                        $("#pre").attr("disabled", true);
                        $("#next").attr("disabled", false);
                    }
                    if (pageNumber > 1) {
                        $("#pre").attr("disabled", false);
                        $("#next").attr("disabled", false);
                    }

                    if (pageNumber == totalPage) {

                        $("#next").attr("disabled", true);
                        $("#pre").attr("disabled", false);
                    }
                    if ('1' == totalPage) {
                        $("#next").attr("disabled", true);
                        $("#pre").attr("disabled", true);
                    }

                    //alert(String(data))
                    var pageSize = obj.pageSize
                    var topicArray = obj.topics;
                    var totalCount = obj.totalCount; //题目 总数

                    for (var i = 0; i < topicArray.length; i++) {

                        var title = String(topicArray[i].TopicTitle)
                        if (title.length > 25)
                            title = title.substring(0, 25) + '...';
                        var first = String(topicArray[i].FirstPointName)
                        if (first.length > 6)
                            first = first.substring(0, 6);

                        var second = String(topicArray[i].SecondPointName)

                        if (second.length > 6)
                            second = second.substring(0, 6);

                        var sortName = String(topicArray[i].SortName)
                        if (sortName.length > 6)
                            sortName = sortName.substring(0, 6);
                        var tid = topicArray[i].TopicType;
                        var str = '<tr>' +
                           ' <td>' + (i + 1 + (pageNumber - 1) * pageSize) + '</td>' +
                            '<td class="topicId"><a href="#" >' + title + '</a></td>' +
                            '<td class="first">' + first + '</td>' +
                            '<td class="second" >' + second + '</td>' +
                            '<td class="sortName">' + sortName + '</td>' +
                            '<td class="TopicType" >' + topicArray[i].TopicType + '</td>' +
                           ' <td class="TopicSourceName" >' + topicArray[i].TopicSourceName + '</td>' +
                           ' <td class="TopicState" >' + GetTopicState(topicArray[i].TopicState) + '</td>' +
                           '<td class="hidden">' + topicArray[i].TopicId + '</td>'
                        ' </tr>';
                        $("#topicTab").append(str);
                    }

                    //$("#doing").empty();
                }

            })



        }

        //返回题目审核状态
        function GetTopicState(type) {
            // alert(type)
            if (type == 0)
                return "未通过审核"
            if (type == 1)
                return "待审核"
            if (type == 2)
                return "通过审核"
        }

        //根据一级知识点获取二级知识点
        function GetSecondByFirstId(firtId) {
            $.post("GetSecondByFirst.ashx?firstId=" + firtId, function (data) {
                //alert(String(data))

                var obj = JSON.parse(data);
                var array = obj.secondPoints;

                $("#secondDea").find("option").remove();  //清楚原来的二级知识点
                for (var i = 0; i < array.length; i++) {
                    var str = '<option value="' + array[i].SecondPointId + '">'
                        + array[i].SecondPointName + '</option>';
                    $("#secondDea").append(str);

                }
            })
        }



        $(function () {
            $('#test4').on('click', function () {
                var ii = layer.load();
                $("#doing").append(li);
                //此处用setTimeout演示ajax的回调
                setTimeout(function () {
                    layer.close(ii);
                }, 1000);
            });



            $("#advanceQuery_btn").click(function () {
                var name = $(this).html()

                if (name === "高级查询") {

                    $(this).html("取消高级查询");
                }

                if (name === "取消高级查询") {

                    $(this).html("高级查询");
                }

                $("#advanceQueryTab").toggleClass("hidden");
                $("#basicQuery").toggleClass("hidden");
                $("#confirm_btn").toggleClass("hidden");
                $("#query").toggleClass("hidden");
            })


            GetDate(pageNumber);  //页面初始化



            //下一页
            $("#next").click(function () {
                $("#topicTab").find("tbody").find("tr").remove();
                GetDate((pageNumber + 1));
            })

            //上一页
            $("#pre").click(function () {
                $("#topicTab").find("tbody").find("tr").remove();
                GetDate((pageNumber - 1));
            })

            //转到
            $("#turnTo").click(function () {
                var value = $("#pageNumber").val()
                if (value === '' || isNaN(value)) {
                    infoAlert('请输入页号')
                    $("#pageNumber").val("")
                }
                else {
                    $("#topicTab").find("tbody").find("tr").remove();
                    GetDate(value);
                }

            })

            //选择一级知识点
            $("#first").change(function () {

                $("#allSecond").siblings().remove();
                var firstId = $(this).val();
                if (firstId != '0') {
                    $.post("GetSecondByFirst.ashx?firstId=" + firstId, function (data) {
                        // alert(String(data))
                        var obj = JSON.parse(data);
                        var array = obj.secondPoints;


                        for (var i = 0; i < array.length; i++) {
                            var str = '<option value="' + array[i].SecondPointId + '">'
                                + array[i].SecondPointName + '</option>';
                            $("#second").append(str);
                        }
                    })
                }

            })

            //查询
            $("#query").click(function () {
                var btn_name = $(this).html()
                if (btn_name === '查询') {
                    $("#twoQuery").toggleClass("hidden");

                    $("#cancleQuery").toggleClass("hidden");
                    $(this).html("确认查询");
                }
                else {
                    $("#confirm_btn").toggleClass("hidden");
                    GetDate(1)
                }

            })

            //导出题库
            $("#outTopic").click(function () {
                window.location.href = "OutTopic.ashx?" + $("#queryForm").serialize();
            })
        })


    </script>



    <%--    题目详情--%>
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

        #topicDetailTab tr td:first-child {
            text-align: right;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $("#back").click(function () {
                //history.back(-1);
                $("#topicDetail").hide();
                $("#topicList").show();
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
            $("#firstDea").change(function () {
                //alert("a")
                $("#allSecond").siblings().remove();
                var firstId = $(this).val();
                if (firstId != '0') {
                    GetSecondByFirstId(firstId)
                }
            })


            // 更新
            $("#update").click(function () {


                if ($("#title").val() != '' && $("#optionA").val() != '' && $("#optionB").val() != '' &&
                    $("#optionC").val() != '' && $("#optionD").val() != '') {
                    if ($("input:checkbox[class=answer]:checked").length == 0)
                        infoAlert("请选择题目答案");
                    else {
                        $("#updateForm").ajaxSubmit(function (data) {
                            if (String(data) === "1") {
                                var topicId = $("#hiddenTopicId").val();

                                //更新列表中额题目信息
                                GetDate(pageNumber)
                                layer.alert("修改成功！", { icon: 1 }, function () {
                                    $("#topicDetail").hide();
                                    $("#topicList").show();
                                    layer.closeAll();

                                })

                            }

                        });
                    }
                }
                else {
                    infoAlert("请填写题目完整信息");
                }

            })

            //  $("#updateForm").valid(
            //      {
            //          rules: {
            //              "title": { required: true },
            //              "optionA": { required: true },
            //              "optionB": { required: true },
            //              "optionC": { required: true },
            //              "optionD": { required: true }
            //          },
            //          errorPlacement: function (error, element) {
            //              error.append(element.siblings("span"))
            //          }
            //      }
            //);

        })

    </script>


    <%--绑定某个题目的信息--%>
    <script type="text/javascript">
        $(function () {

            //获取题目详情
            $("body").on("click", ".topicId", function () {
                var topicId = $(this).siblings(".hidden").html();
                $("#topicList").hide();  //隐藏题目列表
                $("#topicDetail").show();//显示单个题目详情

                $.post("GetTopicByTid.ashx", { topicId: topicId }, function (data) {
                    // alert(String(data));
                    var topic = JSON.parse(data).topic[0];

                    //绑定一级知识点
                    $("#topicDetail select[name=first] option").each(function () {

                        if ($(this).html() === topic.FirstPointName) {
                            $(this).attr("selected", true);
                        }
                    })

                    //绑定二级知识点
                    $.post("GetSecondByFirst.ashx?firstId=" + topic.FirstPointId, function (data) {
                        //alert(String(data))

                        var obj = JSON.parse(data);
                        var array = obj.secondPoints;

                        $("#secondDea").find("option").remove();  //清楚原来的二级知识点
                        for (var i = 0; i < array.length; i++) {

                            if (array[i].SecondPointName === topic.SecondPointName) {
                                var str = '<option value="' + array[i].SecondPointId + '" selected="selected" >'
                                + array[i].SecondPointName + '</option>';
                                $("#secondDea").append(str);
                            }
                            else {
                                var str = '<option value="' + array[i].SecondPointId + '">'
                                + array[i].SecondPointName + '</option>';
                                $("#secondDea").append(str);
                            }
                        }
                    })

                    //绑定题目类别

                    $("#topicDetail select[name=sort] option").each(function () {
                        if ($(this).html() === topic.SortName) {
                            $(this).attr("selected", true);
                        }
                    })

                    //绑定题库
                    $("#topicDetail select[name=source] option").each(function () {
                        if ($(this).html() === topic.TopicSourceName) {
                            $(this).attr("selected", true);
                        }
                    })

                    $("#title").val(topic.TopicTitle)
                    $("#optionA").val(topic.OptionA);
                    $("#optionB").val(topic.OptionB);
                    $("#optionC").val(topic.OptionC);
                    $("#optionD").val(topic.OptionD);

                    //绑定答案
                    //先初始化checnkbox的选中状态
                    $("#answerA").attr("checked", false);
                    $("#answerB").attr("checked", false);
                    $("#answerC").attr("checked", false);
                    $("#answerD").attr("checked", false);

                    var ansert = String(topic.TitleAnswer).toUpperCase();
                    var flag = 0;

                    if (ansert.indexOf("A") >= 0) {
                        flag++;
                        $("#answerA").attr("checked", true);
                    }
                    if (ansert.indexOf("B") >= 0) {
                        flag++;
                        $("#answerB").attr("checked", true);
                    }

                    if (ansert.indexOf("C") >= 0) {
                        flag++;

                        $("#answerC").attr("checked", true);
                    }
                    if (ansert.indexOf("D") >= 0) {
                        flag++;

                        $("#answerD").attr("checked", true);
                    }

                    $("#singeleRadio").attr("checked", true);
                    if (flag > 1)
                        $("#multipleRadio").attr("checked", true);


                    //绑定审核状态
                    var autidState = topic.TopicState;
                    $("select[name=TopicState] option").each(function () {
                        if ($(this).val() === autidState) {
                            $(this).attr("selected", true);
                        }
                    })

                    //绑定topicId
                    $("#topicDetail  #hiddenTopicId").val(topic.TopicId);
                })
            })

            //删除
            $("#delete").click(function () {
                layer.confirm("是否确认删除此题目？", function () {

                    var topicId = $("#topicDetail  #hiddenTopicId").val();
                    if (topicId != '') {
                        $.post("DeleTopic.ashx", { topicId: topicId }, function (data) {

                            if (data === '1') {
                                var theLyaer = layer.alert("删除成功！", { icon: 1 }, function () {
                                    GetDate(pageNumber);
                                    $("#topicList").show();  //显示题目列表
                                    $("#topicDetail").hide();//隐藏单个题目详情
                                    layer.closeAll();
                                })
                                return;

                            }
                            if (data === '-1') {
                                infoAlert("改题目已存在于试卷中，无法删除！");
                            }
                            else {

                                errAlert("删除失败！");
                            }
                        })
                    }
                },
                function () {
                    layer.closeAll();

                })
            })

        })
    </script>

</head>


<body>

    <div id="topicList">
        <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
            <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">题库管理</a>
        </div>

        <div id="#doing" class="hidden"></div>
        <table id="topicTab" class="table table-bordered table-hover table-striped">
            <thead>
                <tr class="info">
                    <td style="width: 4%">序号</td>
                    <td style="width: 40%">题目标题</td>
                    <td style="width: 10%">一级知识点</td>
                    <td style="width: 10%">二级知识点</td>
                    <td style="width: 10%">题目类别</td>
                    <td style="width: 10%">题目类型</td>
                    <td style="width: 7%">题库名称</td>
                    <td style="width: 9%">题目状态</td>
                </tr>
            </thead>

        </table>
        <h4 class="noResult" style="padding-left: 15px; display: none;"><b>查询无结果</b></h4>

        <div class="bottomQuery" style="float: right; margin-right: 45px;">

            <button type="button" id="pre" class="btn btn-primary btn-xs">上一页</button>
            <button type="button" id="next" class="btn btn-primary btn-xs">下一页</button>
            &nbsp;第<input id="pageNumber" value="1" style="width: 25px; height: 22px;" />页
                   <button type="button" id="turnTo" class="btn btn-primary btn-xs">转到</button>
            共&nbsp<span id="totalPage"></span>&nbsp;页   <span class="topicNumber">共&nbsp;<b></b>&nbsp;题</span>

        </div>


        <div id="twoQuery" class="hidden" style="margin-top: 10px; clear: both;">
            <form id="queryForm" method="post" action="GetTopics.ashx">

                <table style="line-height: 50px; background-color: #F9F9F9; margin-bottom: 0 !important; padding-bottom: 0 !important" id="basicQuery" class="table table-bordered table-condensed">
                    <tr>
                        <td style="line-height: 35px; width: 105px;">请选择知识点:
                        </td>
                        <td style="width: 320px;">
                            <select name="first" id="first" class="form-control" style="width: 320px;">
                                <option selected="selected" value="0">全部</option>
                                <%foreach (var point in firstPoint)
                                  { %>
                                <option value="<%= point.FirstPointId %>"><%= point.FirstPointName %></option>
                                <%} %>
                            </select>
                        </td>
                        <td style="width: 320px;">
                            <select name="second" id="second" class="form-control" style="width: 320px;">
                                <option selected="selected" id="allSecond" value="0">全部</option>
                            </select>

                        </td>
                        <td>审核状态:
                        </td>
                        <td>
                            <select class="form-control" name="TopicState">
                                <option value="-1">全部</option>
                                <option value="1">待审核</option>
                                <option value="0">未通过审核</option>
                                <option value="2">通过审核</option>
                            </select>
                        </td>

                    </tr>

                </table>


                <table style="line-height: 35px !important; background-color: #F9F9F9; margin-top: 0 !important; padding-top: 10px !important" class=" table table-bordered table-condensed" id="advanceQueryTab">
                    <tr>
                        <td style="width: 130px; line-height: 45px;">请选择题目类别：</td>
                        <td style="width: 150px;">
                            <select name="sort" class="form-control">
                                <option value="0">全部</option>
                                <%foreach (var item in sort)
                                  {%>
                                <option value="<%=item.SortId %>"><%=item.SortName %></option>
                                <%} %>
                            </select></td>
                        <td style="width: 120px;">请选择题目类型</td>
                        <td style="width: 140px;">
                            <select name="type" style="width: 120px;" class="form-control">
                                <option value="" selected="selected">全部</option>
                                <%foreach (var item in topicType)
                                  { %>
                                <option value="<%= item %>"><%=item %></option>
                                <%} %>
                            </select></td>
                        <td style="line-height: 35px;">请选择题库:
                        </td>
                        <td style="width: 100px;">
                            <select name="source" class="form-control" style="width: 100px;">
                                <option selected="selected" value="0">全部</option>
                                <%foreach (var item in topicSource)
                                  { %>
                                <option value="<%= item.TopicSourceId %>"><%=item.TopicSourceName %></option>
                                <%} %>
                            </select>
                        </td>

                        <td>请输入题目内容</td>
                        <td>
                            <input name="topicTitle" class="form-control" />
                        </td>
                    </tr>

                </table>

            </form>


        </div>
        <table style="line-height: 50px; margin-top: 20px;" class="table table-bordered table-condensed">
            <tr>

                <td style="width: 216px;">
                    <%-- <button class="btn btn-primary" id="advanceQuery_btn" type="button">高级查询</button></td>
                        <td>--%>
                    <a href="InputTopic.aspx" style="margin-left: 10px;" class="btn btn-primary">导入题目</a>

                    <button type="button" id="outTopic" class="btn btn-primary">导出题目</button>
                </td>
                <td>
                    <button id="query" class="btn btn-primary" type="button">查询</button>
                    <a class="btn btn-primary hidden" id="cancleQuery" href="TopicInfo.aspx">取消查询</a>
                </td>
            </tr>
        </table>
    </div>

    <div id="topicDetail" style="display: none;">
        <form id="updateForm" method="post" action="UpdateTopic.ashx">
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">题库管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">题目详情</a>
            </div>

            <div class="addTopic">
                <table class="addTitle table table-bordered table-striped" id="topicDetailTab">
                    <tr>
                        <td style="width: 190px;">一级知识点：</td>
                        <td style="width: 300px;">
                            <div class="input-group" style="width: 300px;">
                                <select name="first" style="width: 284px;" id="firstDea" class="form-control">

                                    <%foreach (var point in firstPoint)
                                      { %>
                                    <option value="<%= point.FirstPointId %>"><%= point.FirstPointName %></option>
                                    <%} %>
                                </select>&nbsp;<span class="errorInfo"></span>



                            </div>

                        </td>
                        <td style="width: 190px; text-align: right">二级知识点：
                        </td>
                        <td>
                            <select name="second" style="width: 284px; margin-left: 20px;" id="secondDea" class="form-control"></select>
                        </td>
                    </tr>
                    <tr>
                        <td>题目类别：</td>
                        <td>
                            <select name="sort" class="form-control" style="width: 284px;">
                                <%foreach (var item in sort)
                                  {%>
                                <option value="<%=item.SortId %>"><%=item.SortName %></option>
                                <%} %>
                            </select>
                        </td>

                        <td style="text-align: right">所属题库：</td>
                        <td>
                            <select name="source" class="form-control" style="width: 284px; margin-left: 20px;">
                                <%foreach (var item in topicSource)
                                  {%>
                                <option value="<%=item.TopicSourceId %>"><%=item.TopicSourceName %></option>
                                <%} %>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>题目标题：</td>
                        <td colspan="3">
                            <textarea style="height: 90px;" class="form-control" name="title" id="title"></textarea>


                        </td>
                    </tr>
                    <tr>
                        <td>选项A：</td>
                        <td colspan="3">
                            <textarea class="form-control" name="optionA" id="optionA"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>选项B：</td>
                        <td colspan="3">
                            <textarea class="form-control" name="optionB" id="optionB"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>选项C：</td>
                        <td colspan="3">
                            <textarea class="form-control" name="optionC" id="optionC"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>选项D：</td>
                        <td colspan="3">
                            <textarea class="form-control" name="optionD" id="optionD"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <td>正确答案：</td>
                        <td>
                            <div class="multipleTopic">
                                A:<input name="answerB" class="answer" id="answerA" type="checkbox" />&nbsp;
                                
                                B:<input name="answerB" class="answer" id="answerB" type="checkbox" />&nbsp;
                                
                                C:<input name="answerC" class="answer" id="answerC" type="checkbox" />&nbsp;
                               
                                D:<input name="answerD" class="answer" id="answerD" type="checkbox" />&nbsp;
                                
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>题目类型：</td>
                        <td>
                            <input name="type" checked="checked" value="单选题" type="radio" class="topicType" id="singeleRadio" />单选题
                            <input name="type" value="多选题" type="radio" class="topicType" id="multipleRadio" />多选题
                        </td>
                    </tr>
                    <tr>
                        <td>题目审核状态：</td>
                        <td>
                            <select name="TopicState" class="form-control" style="width: 130px;">
                                <option value="1" id="wait">待审核</option>
                                <option value="2" id="pass">通过审核</option>
                                <option value="0" id="fail">未通过审核</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input name="topicId" id="hiddenTopicId" type="hidden" value="<%= topic.TopicId %>" /></td>
                        <td colspan="2">
                            <button type="button" id="update" class="btn btn-primary">确认修改</button>&nbsp;&nbsp;
                              <button type="button" class="btn btn-danger" id="delete">删除</button>&nbsp;&nbsp;
                            <button type="button" class="btn btn-primary" id="back">返回</button>


                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>


</body>
</html>
