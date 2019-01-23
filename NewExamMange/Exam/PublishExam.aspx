<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PublishExam.aspx.cs" Inherits="PublishExam" %>

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
        $(function () {
            $(".firstPoint").click(function () {
                $(this).parent().siblings(".secondPoint").slideToggle()
            })


            $("input[name=examName]").blur(function () {
                $("#next").attr("disabled", false);
            })

            //保存考试名称
            $("#next").click(function () {
                var theExamName = $("input[name=examName]").val()

                if (theExamName === '') {
                    $(".error").show();
                    $(".error").html("*请输入考试名称");
                    $("#next").attr("disabled", true);
                    return false;
                }
                else {
                    $(".error").hide();
                    $(".error").html("");
                }


                var naemInput = $("input[name=examName]")
                $.post("JudgeExamName.ashx", { examName: naemInput.val() }, function (data) {
                    //alert(data)
                    if (String(data).toLowerCase() === 'true') {
                        $(".error").show();
                        $(".error").html("*该考试名称已存在");
                        $("#next").attr("disabled", true);
                        return false;
                    }
                    else {
                        $(".error").hide();
                        $(".error").html("");

                        $.post("AddTheExam.ashx", { theExamName: theExamName }, function (data) {
                            var res = parseInt(data);
                            if (res > 0) {
                                layer.alert("添加成功, 请添加考试场次信息！", { icon: 1 }, function () {
                                    window.location.href = "/ExamManage/ExamePeriodManage.aspx?theExamId=" + data;
                                })
                                
                            }
                            else if (res == -1) {
                                window.parent.location = "../LogIn.aspx";
                            }
                            else {
                                errAlert("添加失败");
                            }
                        })
                    }
                })
                //alert("b")





            })

        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">发布考试</a>
            </div>


            <div id="setDetail" style="width: 740px; margin: 15px auto; border-radius: 8px;">

                <table class="table table-hover table-striped" style="width: 700px;" id="examName">
                    <caption>
                        <h3 style="text-align:center"><b>设置考试名称</b></h3>
                    </caption>

                    <tr>
                        <td style="width: 120px; height: 40px; line-height: 40px; text-align: center">请输入考试名称</td>
                        <td style="text-align: left; width: 300px;">
                            <input class="form-control .col-md-5 examName" name="examName" style="width: 300px; float: left" />
                            <span style="width: 190px; padding-left: 10px; float: left; display: none" class="error">该考试名称已存在</span>
                        </td>
                    </tr>
                    <tfoot>
                        <tr>
                            <td></td>
                            <td>
                                <input style="margin: 0 auto" id="next" class="btn btn-primary btn-sm" value="下一步" /></td>
                        </tr>
                    </tfoot>
                </table>

            </div>

        </div>
    </form>


</body>
</html>
