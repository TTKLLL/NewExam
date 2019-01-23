<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentDetail.aspx.cs" Inherits="ManageStu_StudentDetail" %>

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

    <script type="text/javascript">
        $(function () {

            $("#back").click(function () {
                history.back(-1);
            })

            //预览图片
            $("#face").uploadPreview({ Img: "ImgPr", Width: 220, Height: 220 });

            $("#cancle").click(function () {
                history.back();
            })

            //保存
            $("#bt_Save").click(function () {
                $("#operateType").val("0")
                $("#form1").submit();
            })

            //删除
            $("#delete").click(function () {

                layer.confirm("是否确定删除该考生？", function () {
                    layer.closeAll();
                    $("#operateType").val("1")
                    $("#form1").submit();
                })
                
            })

            //选择班级
            $("#selectClass").change(function () {
                var className = $(this).val();
            
                if (className != '')
                    $("input[name=class]").val(className)
            })
        })
    </script>
</head>
<body>
    <form id="form1" method="post" runat="server" action="StudentDetail.aspx">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">考生信息管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">考生详细信息</a>
            </div>


            <div style="width: 740px; border-radius: 8px; margin: 15px auto;">

                <table id="StuInfo" class="table table-bordered table-hover table-striped">
                    <caption>
                        <center><h3><b>考生详细信息</b></h3></center>
                    </caption>


                    <tbody>
                        <tr>
                            <td style="text-align: right;">学号：</td>
                            <td style="width: 580px;">
                                <input readonly="readonly" style="width: 480px; float: left" name="StudentId" value="<%=stu.StudentId %>" class="form-control" required="required" />
                                <span class="errorInfo" style="color: red; width: 100px; float: right"></span>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 110px; text-align: right;">姓名：</td>
                            <td>
                                <input value="<%=stu.StudentName %>" name="StudentName" style="width: 480px;" class="form-control" required="required" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">班级：</td>
                            <td>
                                <div class="input-group">
                                    <input value="<%=stu.Class %>" name="class" style="width: 235px;" required class="form-control" />
                                <select id="selectClass" style="width: 240px; margin-left: 5px;" class="form-control">
                                    <option value="">请选择班级</option>
                                    <%foreach (var item in allClass)
                                      {%>
                                    <option <%= item == stu.Class ? "selected" : "" %> value="<%= item %>"><%= item %></option>
                                    <%} %>
                                </select>
                                    </div>
                                

                            </td>
                        </tr>

                        <tr>
                            <td style="width: 110px; text-align: right;">手机号：</td>
                            <td>
                                <input value="<%= stu.StudentPhone %>" name="StudentPhone" style="width: 480px;" class="form-control" required="required" /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="3">
                                <button type="button" id="bt_Save" class="btn btn-primary">保存修改</button>
                                <button type="button" id="delete" class="btn btn-danger">删&nbsp;&nbsp;除</button>
                               <%-- <a class="btn btn-primary" href="UploadStuImage.aspx?sId=<%=stu.StudentId %>">修改考生照片</a>--%>
                                <a id="cancle" href="#" id="back" class="btn btn-primary">返&nbsp;&nbsp;回</a>
                                <input type="hidden" id="operateType" name="operateType" value="0" />
                            </td>
                        </tr>
                    </tbody>
                </table>


            </div>



        </div>
    </form>
</body>
</html>
