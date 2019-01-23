<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherAddStu.aspx.cs" Inherits="InvigilateTeacher_TeacherAddStu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../js/uploadPreview.min.js"></script>

     <script src="../assets/layer/layer.js"></script>
    <script src="../js/MyAlert.js"></script>

    <style type="text/css">
        #main {
            margin: 15px auto;
            width: 600px;
            height: 470px;
            border-radius: 8px;
            background-color: #EEEEEE;
            text-align: center;
            padding-top: 8px;
        }

        #img {
            width: 160px;
            height: 220px;
            margin: 25px auto;
            padding: 5px;
            border-radius: 5px;
            background-color: #286778;
        }

        table {
            width: 80px;
            line-height: 60px;
            text-align: center;
        }
    </style>


    <script type="text/javascript">
        $(function () {
            //预览图片
            $("#face").uploadPreview({ Img: "ImgPr", Width: 220, Height: 220 });

            $("#cancle").click(function () {
                window.history.go(-1);
            })

            //选择班级
            $("#selectClass").change(function () {
                var className = $(this).val();

                if (className != '')
                    $("input[name=class]").val(className)
            })

            //验证学号是否已存在
            $("input[name=sId]").change(function () {
                var sId = $(this).val();
                var that = $(this);
                $.post("StuIsHave.ashx", { sId: sId }, function (data) {
                    if (String(data) === 'True') {
                        $(".errorInfo").html("该学号已存在");
                        $("#bt_Save").attr("disabled", "disabled");
                    }
                    else {
                        $("#bt_Save").removeAttr("disabled");
                        $(".errorInfo").html("");
                    }

                })
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server" action="TeacherAddStu.aspx" method="post" enctype="multipart/form-data">
        <div>

            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">考生注册</a>
            </div>

            <div style="width: 740px; border-radius: 8px; margin: 15px auto;">

                <table id="StuInfo" class="table table-bordered table-hover table-striped">
                    <caption>
                        <center><h3><b>添加考生</b></h3></center>
                    </caption>


                    <tbody>
                        <tr>
                            <td style="text-align: right;">学号：</td>
                            <td style="width: 580px;">
                                <input style="width: 480px; float: left" name="sId" value="" class="form-control" required="required" />
                                <span class="errorInfo" style="color: red; width: 100px; float: right"></span>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 110px; text-align: right;">姓名：</td>
                            <td>
                                <input value="" name="name" style="width: 480px;" class="form-control" required="required" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">班级：</td>
                            <td>
                                <div class="input-group">
                                    <input name="class" required class="form-inline form-control" style="width: 235px;" />
                                    <select id="selectClass" style="width: 240px; margin-left: 5px;" class="form-inline form-control">
                                        <option value="">请选择班级</option>
                                        <%foreach (var item in ClassInfo)
                                          {%>
                                        <option value="<%= item %>"><%= item %></option>
                                        <%} %>
                                    </select>
                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td style="width: 110px; text-align: right;">手机号：</td>
                            <td>
                                <input value="" name="phone" style="width: 480px;" class="form-control" required="required" /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="3">
                                <input type="submit" id="bt_Save" class="btn btn-primary" value="保&nbsp;&nbsp;存" />
                                <button id="cancle" class="btn btn-danger">取&nbsp;&nbsp;消</button>

                            </td>
                        </tr>
                    </tbody>
                </table>


            </div>

        </div>
    </form>


</body>
</html>
