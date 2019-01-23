<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamePeriodManage.aspx.cs" Inherits="Exam_ExamePeriodManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/bootstrap-datetimepicker.js"></script>
    <script src="../js/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../assets/layer/layer.js"></script>

    <script src="../js/MyAlert.js"></script>

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

        .error {
            color: red;
            padding-left: 2px;
            display: none;
        }

        table tr td {
            line-height: 30px !important;
        }
    </style>

    <script type="text/javascript">

        function GetNowDate() {
            return (new Date()).Format("yyyy-M-d h:m:s.S");
        }

        Date.prototype.Format = function (fmt) {
            var o = {
                "M+": this.getMonth() + 1, //月份 
                "d+": this.getDate(), //日 
                "h+": this.getHours(), //小时 
                "m+": this.getMinutes(), //分 
                "s+": this.getSeconds(), //秒 
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
                "S": this.getMilliseconds() //毫秒 
            };
            if (/(y+)/.test(fmt))
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o) {
                if (new RegExp("(" + k + ")").test(fmt)) {
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                }
            }
            return fmt;
        }

        function strFormatDate(str) {

            return new Date(Date.parse(str.replace(/-/g, "/")));

            return str;
        }

        //比较考试开始结束时间
        function ValidTime(starttime, endtime) {
            var starTimeStamp = strFormatDate(starttime) / 1000;
            var endTimeStamp = strFormatDate(endtime) / 1000;

            return (String(starTimeStamp) < String(endTimeStamp))
        }

        function convertDateToJSONDate(date) {
            var i = date.getTime();
            var dateString = "\/Date(" + i + ")\/";
            return dateString;
        }


        $(function () {


            //重新生成试卷
            $("#reGenerate").click(function () {
                var this_btn = $(this);

                var flag = 1;
                var btn = $(this);
                var btn_name = $(this).html();

                if (btn_name === '重新生成试卷') {
                    var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                    if (trs.length == 0) {

                        infoAlert("请选择要重新生成试卷的考试");
                        return false;
                    }
                    else {

                        trs.each(function () {
                            var that = $(this);
                            var row = trs.eq(0).parent().parent();
                            var examId = row.find(".ExamId").val();


                            if (examId == 0) {
                                infoAlert("该考试还未发布");
                                flag = 0;
                                that.attr("checked", false);
                                return false;
                            }

                            var begInTIime = row.find(".beginTime").val();
                            if (!ValidTime(GetNowDate(), begInTIime)) {
                                infoAlert("该考试已开始，不能重新生成试卷!");
                                that.attr("checked", false);
                                flag = 0;
                                return false;
                            }

                            if (flag == 0) {
                                return false;
                            }
                            else {
                                var row = $(this).parent().parent();

                                row.find(".paperNumber").attr("disabled", false);
                                btn.html("确认重新生成");
                            }
                        })

                    }
                }
                else {

                    var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                    if (trs.length == 0) {
                        infoAlert("请选择要重新生成试卷的考试");
                        return false;
                    }
                    else {
                        var examArray = new Array();
                        trs.each(function () {
                            var data = new Object();
                            var row = $(this).parent().parent();
                            data.PaperNumber = row.find(".paperNumber").val();
                            data.ExamId = row.find(".ExamId").val();



                            if (data.PaperNumber === '') {
                                flag = 0;
                                infoAlert("请输入试卷份数！");
                                return false;
                            }

                            if (parseInt(data.PaperNumber) <= 0) {
                                flag = 0;
                                infoAlert("请输入试卷份数！");
                                return false;
                            }
                            else {
                                examArray.push(JSON.stringify(data));
                            }
                        })

                        if (flag == 0) {
                            return false
                        }

                        $.ajax({
                            url: "ReGeneratePaper.ashx",
                            type: "post",
                            data: { examArray: String(examArray) },

                            beforeSend: function () {
                                this_btn.attr("disabled", true);
                                var index = layer.msg('正在重新生成试卷', {icon:16, shade:0});

                            },
                            error: function () {
                                layer.closeAll();
                                errAlert("重新生成试卷失败");
                                this_btn.attr("disabled", false);
                                layer.closeAll();
                            },
                            success: function (data) {
                                layer.closeAll();
                                var res = parseInt(data);
                                if (res > 0) {
                                    layer.alert("重新生成试卷成功", { icon: 1 }, function () {
                                        window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                                    })

                                } else {
                                    layer.alert("该考试已有学生答题， 无法重新神生成", { icon: 2 }, function () {
                                        window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                                    })

                                }

                            }
                        })
                    }

                }
            })

            //预览试卷
            $("#viewPaper").click(function () {
                var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                if (trs.length == 0) {
                    infoAlert("请选择要预览试卷的考试");
                    return false;
                }
                else {
                    var row = trs.eq(0).parent().parent();
                    var examId = row.find(".ExamId").val();
                    if (examId != '0') {
                        var examType = '<%= examFlag%>';
                        if (examType == '1')
                            window.location.href = "VIewPaper.aspx?examId=" + examId + "&pageNumber=1";
                        else
                            window.location.href = "VIewPracPaper.aspx?examId=" + examId + "&pageNumber=1";
                    }
                    else {
                        infoAlert("该场考试还未发布, 请在发布后预览该场考试的试卷!");
                    }
                }
            })

            //双击预览试卷
            $("#periodTab tbody tr").dblclick(function () {
                var examId = $(this).find(".ExamId").val()
                if (examId != '0') {
                    var examType = '<%= examFlag%>';
           
                    if (examType == '1')
                        window.location.href = "VIewPaper.aspx?examId=" + examId + "&pageNumber=1";
                    else
                        window.location.href = "VIewPracPaper.aspx?examId=" + examId + "&pageNumber=1";
                }

            })

            //取消修改
            $("#cnacleModify").click(function () {
                if (confirm("确定取消修改？")) {
                    window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                }
            })

            //取消添加
            $("#cnacleAdd").click(function () {
                if (confirm("确定取消添加？")) {
                    window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                }
            })

            //修改
            $("#modify").click(function () {
                var name = $(this).html();
                var flag = 1;


                if (name == '修改') {

                    var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                    if (trs.length == 0) {
                        infoAlert("请选择要修改的考试场次");
                        $(this).html("修改");
                        return false;
                    }

                    if (flag == 0) {
                        $(this).html("修改");
                        return;
                    }

                    trs.each(function () {
                        var that = $(this);
                        var tag = 0;

                        var row = $(this).parent().parent();
                        if (row.find(".ExamId").val() === '0') {
                            infoAlert("该考试未发布，请勿修改");

                            that.attr("checked", false);
                            flag = 0;
                            return false;
                        }

                        if (row.find("input:radio").is(":checked")) {
                            if (!confirm("当前考试正在进行，是否确认修改?")) {
                                that.attr("checked", false);
                                flag = 0;
                                return false;
                            }


                        }
                        var endTime = row.find(".endTime").val();


                        if (ValidTime(endTime, GetNowDate())) {
                            if (!confirm("第 " + row.find(".period").val() + " 场考试已结束, 是否确定修改?")) {
                                that.attr("checked", false);
                                flag = 0;
                                return false;
                            }
                        }


                    })

                    if (flag == 0)
                        return false;

                    trs.each(function () {
                        var data = new Object();
                        var row = $(this).parent().parent();
                        data.ExamId = row.find(".ExamId").val();



                        row.find(".beginTime").attr("disabled", false);
                        row.find(".endTime").attr("disabled", false);
                        row.find(".period").attr("disabled", false);
                        //row.find(".paperNumber").attr("disabled", false);

                    })
                    $("#periodTab tbody").find("tr").each(function () {
                        $(this).find("input:radio").attr("disabled", true);
                    })


                    $(this).html("保存修改");
                    $("#cnacleModify").toggleClass("hidden");
                }
                else {
                    var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                    if (trs.length == 0) {
                        infoAlert("请选择要修改的考试场次");

                        flag = 0;
                        return false;
                    }
                    if (flag == 0)
                        return false;

                    var examArray = new Array();
                    var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                    trs.each(function () {
                        var that = $(this)
                        var data = new Object();
                        var row = $(this).parent().parent();
                        data.ExamId = row.find(".ExamId").val();

                        row.find(".beginTime").attr("disabled", false);
                        row.find(".endTime").attr("disabled", false);
                        row.find(".period").attr("disabled", false);
                        //row.find(".paperNumber").attr("disabled", false);

                        data.ExamId = row.find(".ExamId").val();
                        data.TheExamId = $("#TheExamId").html();
                        data.ExamBegTime = row.find(".beginTime").val();
                        data.ExamEndTime = row.find(".endTime").val();
                        data.ExamPeriod = row.find(".period").val();
                        data.NowPeriod = row.find(".nowExam").is(":checked") == true ? "1" : "0";
                        data.PaperNumber = row.find(".paperNumber").val();

                        if (row.find(".ExamId").val() === '0') {
                            infoAlert("该考试未发布，请勿修改");

                            that.attr("checked", false);
                            flag = 0;
                            return false;
                        }

                        if (data.ExamBegTime === '' || data.ExamEndTime === '' || data.ExamPeriod === ''
                            || data.PaperNumber === '') {
                            infoAlert("请输入考试场次相关信息");
                            flag = 0;
                            return false;
                        }
                        if (parseInt(data.PaperNumber) <= 0) {
                            infoAlert("试卷份数必须大于0");
                            flag = 0;
                            return false;
                        }

                        //if (!ValidTime(new Date(), data.ExamBegTime)) {
                        //    infoAlert("场次 " + data.ExamPeriod + " 的开始时间必须晚于当前时间");
                        //    flag = 0;
                        //    return false;
                        //}

                        if (!ValidTime(data.ExamBegTime, data.ExamEndTime)) {
                            infoAlert("场次 " + data.ExamPeriod + " 的结束时间必须大于开始时间");
                            flag = 0;
                            return false;
                        }



                        examArray.push(JSON.stringify(data));

                    })
                    if (flag == 0)
                        return;

                    var index;
                    if (flag != 0) {
                        $.ajax({
                            url: "SaveExamPeriod.ashx",
                            type: 'POST',
                            timeout: 150000,
                            data: { examArray: String(examArray) },

                            beforeSend: function () {
                                index = layer.load(0, { shade: false });
                            },

                            error: function () {
                                errAlert("修改试卷失败");
                                layer.close(index);
                            },

                            success: function (data) {

                                if (data === '1') {
                                    layer.alert("修改成功", { icon: 1 }, function () {
                                        window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>';
                                    });

                                }
                                else { 

                                    layer.alert("修改失败", { icon: 2 }, function () {
                                        window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>';
                                        return false;
                                    })

                                }
                                layer.close(index);
                            }


                        })

                        $(this).html("修改");
                        $("#cnacleModify").toggleClass("hidden");

                    }

                }


            })


            //生成试卷
            $("#generatePaper").click(function () {
                var this_btn = $(this);

                var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                if (trs.length == 0) {
                    infoAlert("请选择要添加的考试场次");
                    return false;
                }


                var examArray = new Array();
                var flag = 1;
                trs.each(function () {

                    var data = new Object();
                    var row = $(this).parent().parent();
                    data.ExamId = row.find(".ExamId").val();
                    data.TheExamId = $("#TheExamId").html();
                    data.ExamBegTime = row.find(".beginTime").val();
                    data.ExamEndTime = row.find(".endTime").val();
                    data.ExamPeriod = row.find(".period").val();
                    data.NowPeriod = row.find(".nowExam").is(":checked") == true ? "1" : "0";

                    data.PaperNumber = row.find(".paperNumber").val();

                    if (data.ExamId != '' && data.ExamId != '0') {
                        infoAlert("第 " + data.ExamPeriod + " 场考试试卷已生成，请勿重复操作");
                        $(this).attr("checked", false);

                        flag = 0;
                        $(this).find("input:checkbox").attr("checked", false);
                        return false;
                    }

                    if (data.ExamBegTime === '' || data.ExamEndTime === '' || data.ExamPeriod === ''
                        || data.PaperNumber === '') {
                        infoAlert("请输入考试场次相关信息");
                        flag = 0;
                        return false;
                    }

                    if (parseInt(data.PaperNumber) <= 0) {
                        infoAlert("试卷份数必须大于0");
                        flag = 0;
                        return false;
                    }

                    if (!ValidTime(GetNowDate(), data.ExamBegTime)) {
                        infoAlert("场次 " + data.ExamPeriod + " 的开始时间必须大于当前时间");
                        flag = 0;
                        return false;
                    }

                    if (!ValidTime(data.ExamBegTime, data.ExamEndTime)) {
                        infoAlert("场次 " + data.ExamPeriod + " 的结束时间必须大于开始时间");
                        flag = 0;
                        return false;
                    }

                    examArray.push(JSON.stringify(data));

                })


                if (flag != 0) {
                    $.ajax({
                        url: "SaveExamPeriod.ashx",
                        data: { examArray: String(examArray) },
                        type: 'Post',
                        beforeSend: function () {
                            var index = layer.msg('正在生成试卷',  {icon:16, shade: 0 });

                            this_btn.attr("disabled", true);
                        },
                        error: function () {
                            this_btn.attr("disabled", false);
                            errAlert("生成试卷失败");
                            layer.closeAll();

                        },
                        success: function (data) {
                            var res = parseInt(data);
                            if (res == 0) {
                                this_btn.attr("disabled", false);
                                infoAlert("考试添加生成失败")
                                return false;
                            }
                            else if (res == -1) {
                                infoAlert("该场次已存在， 请务重复添加");
                                layer.closeAll();
                                this_btn.attr("disabled", false);
                                return false;
                            }
                            else { //发布成功
                                layer.closeAll();
                                layer.alert("考试添加成功", { icon: 1 }, function () {
                                    window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                                })

                            }
                        }
                    })


            }

            })


        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp; 
                <a href="AllExam.aspx" style="color: red">考试管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">考试场次管理</a>
            </div>

            <span id="TheExamId" class="hidden"><%= theExam.TheExamId %></span>
            <div id="setDetail" style="width: 100%; margin: 15px auto; border-radius: 8px;">

                <table id="periodTab" class="table table-hover table-striped">
                    <caption>
                        <center><h3><b><%= theExam.TheExamName %>场次设置</b></h3></center>
                    </caption>
                    <thead>
                        <tr class="info">
                            <td style="width: 20px;"></td>
                            <td style="width: 120px;">考试场次</td>
                            <td>开始时间</td>
                            <td>结束时间</td>
                            <td>试卷份数</td>
                            <td style="width: 100px;">当前场次</td>

                        </tr>
                    </thead>
                    <tbody>
                        <%if (exams != null)
                          {%>
                        <%foreach (var item in exams)
                          {%>
                        <tr title="双击预览试卷">
                            <td>
                                <input type="checkbox" /></td>
                            <td class="hidden">
                                <input class="ExamId" name="ExamId" value="<%=item.ExamId %>" /></td>
                            <td>
                                <input disabled="disabled" style="width: 50px;" required value="<%=item.ExamPeriod %>" class="form-control period" /></td>
                            <td>
                                <input disabled="disabled" required readonly="true" class="form-control date form_datetime col-md-5 beginTime" value="<%= item.ExamBegTime %>" />
                            </td>
                            <td>
                                <input disabled="disabled" required readonly="true" class="form-control date form_datetime col-md-5 endTime" value="<%=item.ExamEndTime %>" />

                            </td>
                            <td>
                                <input disabled="disabled" style="width: 50px;" required value="<%= item.PaperNumber %>" class="form-control paperNumber" /></td>
                            <td>
                                <input type="radio" name="nowExam" class="nowExam" <%= item.NowPeriod == 1 ? "checked" : "" %> /></td>
                        </tr>
                        <%} %>
                        <%} %>
                    </tbody>

                    <tfoot>
                        <tr>
                            <td colspan="6">
                                <button type="button" id="generatePaper" class="publishExam btn btn-primary " style="display: none;">确认添加</button>
                                <button class="btn btn-danger" style="display: none;" type="button" id="cnacleAdd">取消添加</button>
                                <button type="button" class="addhExam btn btn-primary">添加一场考试</button>


                                <button class="btn btn-primary " type="button" id="modify">修改</button>
                                <button class="btn btn-danger hidden" type="button" id="cnacleModify">取消修改</button>
                                <button type="button" class="cancleExam btn btn-danger">删除</button>
                                <button type="button" class="btn btn-primary" id="viewPaper">预览试卷</button>
                                <button type="button" class="btn btn-primary" id="reGenerate">重新生成试卷</button>

                            </td>
                        </tr>
                    </tfoot>
                </table>


            </div>

        </div>
    </form>

    <script type="text/javascript">
        $(function () {
            //添加一场考试
            $("body").on("click", ".addhExam", function () {
                $("#generatePaper").show();
                $("#cnacleAdd").show();

                var trs = $("#periodTab tbody").find("tr");
                var maxPeriod;
                if (trs.length == 0) {
                    maxPeriod = 1;
                }
                else {
                    var period = trs.eq(trs.length - 1).find(".period").eq(0).val();
                    if (period === "") {
                        infoAlert("请输入上一场的场次");
                        return false;
                    }
                    maxPeriod = parseInt(period) + 1;
                }

                var str = '<tr><td><input type="checkbox" /></td>' +
                    ' <td class="hidden"><input class="ExamId" name="ExamId"  value="0"/></td>' +
                       ' <td><input style="width: 50px;"  required value="' + maxPeriod + '" class="form-control period" /></td>' +
                       ' <td><input  readonly="true" required class="form-control date form_datetime col-md-5 beginTime" /></td>' +
                        '<td><input  readonly="true" required class="form-control date form_datetime col-md-5 endTime" /></td>' +
                       ' <td><input style="width: 50px;" required value="100" class="form-control paperNumber" /></td>' +
                        '<td><input  type="radio" name="nowExam" /></td></tr>';



                $("#periodTab tbody").append(str);


                //为新添加的Input绑定时间事件
                $('.form_datetime').datetimepicker({
                    language: 'zh-CN',
                    weekStart: 1,
                    todayBtn: 1,
                    autoclose: 1,
                    todayHighlight: 1,
                    startView: 2,
                    forceParse: 0,
                    showMeridian: 1
                });
            })

            //取消一场考试
            $("body").on("click", ".cancleExam", function () {
                var trs = $("#periodTab tbody").find("tr")
                //if (trs.length <= 1) {
                //    infoAlert("至少有一场考试")
                //    return;
                //}

                var flag = 0
                trs.each(function () {
                    if ($(this).find("input:checkbox").is(":checked")) {
                        flag = 1
                    }
                })
                if (flag == 0) {
                    infoAlert("请选择一场考试");
                    return false;
                }

                if (confirm("确定删除该场考试？")) {
                    trs.each(function () {
                        if ($(this).find("input:checkbox").is(":checked")) {

                            var trs = $("#periodTab tbody").find("tr").find("input:checkbox:checked");
                            if (trs.length == 0) {
                                infoAlert("请选择要删除的考试场次");
                                return false;
                            }


                            var examArray = new Array();
                            var flag = 1;
                            trs.each(function () {

                                var data = new Object();
                                var row = $(this).parent().parent();
                                data.ExamId = row.find(".ExamId").val();
                                data.TheExamId = $("#TheExamId").html();
                                data.ExamBegTime = row.find(".beginTime").val();
                                data.ExamEndTime = row.find(".endTime").val();
                                data.ExamPeriod = row.find(".period").val();
                                data.NowPeriod = row.find(".nowExam").is(":checked") == true ? "1" : "0";
                                data.PaperNumber = row.find(".paperNumber").val();

                                if (data.ExamId === '0') {
                                    row.remove();
                                }

                                if (data.NowPeriod === '1') {
                                    infoAlert("当前场次无法删除");
                                    $(this).attr("checked", false);
                                    flag = 0;
                                    return false;
                                }

                                if (ValidTime(data.ExamEndTime, GetNowDate()) && ValidTime(data.ExamBegTime, GetNowDate())) {
                                    infoAlert("第 " + data.ExamPeriod + " 场考试已结束，无法删除");
                                    $(this).attr("checked", false);
                                    flag = 0;
                                    return;
                                }

                                if (flag == 0)
                                    return;
                                examArray.push(JSON.stringify(data));

                            })


                            if (flag != 0) {
                                $.post("DeleteExam.ashx", { examArray: String(examArray) }, function (data) {
                                    
                                    if (data == '1') {
                                        $(this).remove();
                                        layer.alert("删除考试成功", { icon: 1 }, function () {
                                            window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                                        })
                                    }
                                    else {
                                        infoAlert("已有学生答题，删除考试失败")
                                        return false;
                                    }
                                    var res = parseInt(data);
                                })
                            }

                        }
                    })
                }
            })


            //考试场次
            $("body").on("blur", ".period", function () {
                if (isNaN($(this).val())) {
                    infoAlert("请输入合法的数字");
                    $(this).val("");
                    return false;
                }

                var that = $(this);
                var trs = $(this).parent().parent().siblings();

                var flag = 0;

                trs.each(function () {
                    if (that.val() === $(this).find(".period").eq(0).val() && that.val() != '') {
                        flag = 1;
                    }
                })
                if (flag == 1) {
                    infoAlert("该场次已存在，请重新输入");
                    $(this).val("");
                    return false;
                }
            })

            //试卷份数
            $("body").on("blur", ".paperNumber", function () {
                if (isNaN($(this).val())) {
                    infoAlert("请输入合法的数字");
                    $(this).val("");
                }
            })



            //修改当前场次
            $("body").on("click", ".nowExam", function () {
                var examId = $(this).parent().parent().find(".ExamId").val();


                if (examId != '' && examId != '0') {
                    if (confirm("确定修改当前场次?")) {



                        $.post("ChangeNowPeriod.ashx", { examId: examId }, function (data) {
                            var res = parseInt(data);
                            if (res > 0) {
                                SuAlert("修改成功");
                            }
                            <%--else if (res == -1) {
                                infoAlert("当前正在进行考试，请勿更改");
                                window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                            }--%>
                            else {
                                infoAlert("修改失败");
                                window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                            }
                        })
                    }
                    else {
                        window.location.href = "ExamePeriodManage.aspx?theExamId=" + '<%= theExam.TheExamId%>'
                    }
                }
            })

            $('.form_datetime').datetimepicker({
                language: 'zh-CN',
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0,
                showMeridian: 1
            });
        })


        //验证日期格式
        function check(date) {
            var reg = /^(\d+)-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;

            var r = date.match(reg);

            if (r == null) return false;

            r[2] = r[2] - 1;

            var d = new Date(r[1], r[2], r[3], r[4], r[5], r[6]);

            if (d.getFullYear() != r[1]) return false;

            if (d.getMonth() != r[2]) return false;

            if (d.getDate() != r[3]) return false;

            if (d.getHours() != r[4]) return false;

            if (d.getMinutes() != r[5]) return false;

            if (d.getSeconds() != r[6]) return false;

            return true;
            //var result = date.match(/((^((1[8-9]\d{2})|([2-9]\d{3}))(-)(10|12|0?[13578])(-)(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(11|0?[469])(-)(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(0?2)(-)(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)(-)(0?2)(-)(29)$)|(^([3579][26]00)(-)(0?2)(-)(29)$)|(^([1][89][0][48])(-)(0?2)(-)(29)$)|(^([2-9][0-9][0][48])(-)(0?2)(-)(29)$)|(^([1][89][2468][048])(-)(0?2)(-)(29)$)|(^([2-9][0-9][2468][048])(-)(0?2)(-)(29)$)|(^([1][89][13579][26])(-)(0?2)(-)(29)$)|(^([2-9][0-9][13579][26])(-)(0?2)(-)(29)$))/);
            //if (result == null) {
            //    // infoAlert("请输入正确的日期格式");
            //    return false;
            //}

        }
    </script>
</body>
</html>
