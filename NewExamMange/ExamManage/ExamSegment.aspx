<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamSegment.aspx.cs" Inherits="ExamManage_ExamSegment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <script src="../js/jquery-1.8.3.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.js"></script>
    <script src="../js/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href=""  style="color:red">已发布的考试</a>
                &nbsp;&gt;&gt;&nbsp;<a href=""  style="color:red">修改场次信息</a>
            </div>
        </div>

        <div id="content">
            <table id="examSegment" class="table table-hover table-scriped table-bordered">
                <caption>
                    <h4 style="text-align: center"><b>数据库系统概论第100次考试场次安排</b></h4>
                </caption>
                <thead>
                    <tr class="info">
                        <td>序号</td>
                        <td>考试开始时间</td>
                        <td>考试结束时间</td>
                        <td>试卷份数</td>
                        <td colspan="2">操作</td>
                    </tr>
                </thead>
                <tr class="addExamTd">
                    <td>1</td>
                    <td>
                        <input required value="2018-06-10 10:00" class="form-control date form_datetime col-md-5 " /></td>
                    <td>
                        <input required  value="2018-06-10 12:00" class="form-control date form_datetime col-md-5 " /></td>
                    <td>
                        <input style="width: 50px;" value="100" class="form-control" />
                    </td>
                    <td>
                        <button class="btn btn-primary btn-sm" type="button">确认修改 </button>
                        <button type="button" class="cancleExam btn btn-danger btn-sm">取消</button></td>
                </tr>
                <tr class="addExamTd">
                    <td>2</td>
                    <td>
                        <input required value="2018-06-10 10:00" class="form-control date form_datetime col-md-5 " /></td>
                    <td>
                        <input required  value="2018-06-10 12:00" class="form-control date form_datetime col-md-5 " /></td>
                    <td>
                        <input style="width: 50px;" value="100" class="form-control" />
                    </td>
                    <td>
                        <button class="btn btn-primary btn-sm" type="button">确认修改 </button>
                        <button type="button" class="cancleExam btn btn-danger btn-sm">取消</button></td>
                </tr>
            </table>
            <button style="margin-left: 10px;" type="button" class="addhExam btn btn-primary">添加一场考试</button>
        </div>
    </form>


    <script type="text/javascript">
        $(function () {

            //添加一场考试
            $("body").on("click", ".addhExam", function () {
                var order = $("#examSegment").children("tbody").children("tr").length + 1
               

                var str =
                                '<tr>' +
                                        '<td>'+order+'</td>'+
                                    '<td><input class="form-control date form_datetime col-md-5 " /></td>' +
                                    '<td><input class="form-control date form_datetime col-md-5 " /></td>' +
                                    '<td><input style="width:50px;" class="form-control" /></td>' +
                                    '<td><button   type="button" class="publishExam btn btn-primary btn-sm" >生成试卷</button>&nbsp;' +
                                    '<button type="button" class="cancleExam btn btn-danger btn-sm" >取消</button></td> ' +
                                '</tr>';



                $("#examSegment").append(str);

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
                if ($("#examSegment").children("tbody").children("tr").length == 1) {
                    alert("至少有一场考试")
                    return;
                }

                if (confirm("确定取消？")) {
                    $(this).parent().parent().remove()
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


    </script>

</body>
</html>
