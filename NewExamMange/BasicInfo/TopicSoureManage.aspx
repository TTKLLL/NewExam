<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TopicSoureManage.aspx.cs" Inherits="BasicInfo_TopicSoureManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {

            //保存
            $("#saveChange").click(function () {
                var dataArray = new Array();
                var res = 0;

                var table = $("#sortTable");
                table.find("tbody").find("tr").each(function () {
                    var tds = $(this).find("td");
                    data = new Object();
                    data.TopicSourceId = $(this).find(".TopicSourceId").eq(0).html();
                    data.TopicSourceName = $(this).find(".SortName").eq(0).val();
                    // alert(data.TopicSourceId + ' ' + data.TopicSourceName)

                    dataArray.push(JSON.stringify(data))

                    if (data.SortName === '') {
                        alert("请输入题库名称");
                        res = -1
                        return false;
                    }
                })
                if (res < 0) {
                    return false;
                }
                else {
                    $("#JsonText").val(dataArray);
                    $("#form1").submit();
                }


            })

            //添加
            $("#addSort").click(function () {
                //获取最大序号
                var rows = $("#sortTable tbody").find("tr");
                var length = rows.length;
                var maxOrder = parseInt(rows.eq(length - 1).find(".order").eq(0).html()) + 1;


                var trStr = '<tr>' +
                    '<td style="width: 10px;">' +
                      '  <input type="checkbox" /></td>' +
                   ' <td class="order" style="width:10px;">'+maxOrder+'</td>' +
                   ' <td class="hidden TopicSourceId">0</td>' +
                   ' <td style="width: 325px;">' +
                     '   <input class="form-control SortName" value="" /></td>' +
               ' </tr>';

                $("#sortTable").append(trStr);

            })

            //删除
            $("#deleteSort").click(function () {

                if ($("#sortTable").find("input:checked").length == 0) {
                    alert("请选择题库");
                }
                else {
                    if (confirm("确认删除？")) {
                        var deleteArray = new Array();
                        $("#sortTable").find("tbody").find("tr").each(function (i) {

                            if ($(this).find("input:checkbox").eq(0).attr("checked") === "checked") {
                                if ($(this).children("td.hidden").html() != '0') {
                                    var data = new Object();
                                    data.TopicSourceId = $(this).children("td.hidden").html()
                                    data.TopicSourceName = $(this).find(".SortName").eq(0).val();
                                    deleteArray.push(JSON.stringify(data));
                                }

                            }

                        })
                        //  alert(String(deleteArray))
                        window.location.href = "TopicSoureManage.aspx?deleteArray=" + deleteArray;
                    }
                }



            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server" action="TopicSoureManage.aspx" method="post">
        <input type="hidden" name="allSorts" id="JsonText" />
    </form>

    <div>
        <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
            <li><a href="PointInfo.aspx">知识点设置</a></li>
           <%-- <li><a href="TopicTypeInfo.aspx">题目类别设置</a></li>--%>
            <li class="active"><a style="color: red" href="TopicSoureManage.aspx">题库设置</a></li>

        </ul>


        <div style="width: 540px; border-radius: 8px; margin: 15px auto;">
            <table id="sortTable" class="table table-bordered table-hover table-striped">
                <thead>
                    <tr class="info">
                        <td style="width: 10px;"></td>
                        <td style="width: 10px;">序号</td>
                        <td>题库名称</td>
                    </tr>
                </thead>
                <%int index = 0; %>
                <%foreach (var item in source)
                  {%>
                <tr>
                    <td style="width: 10px;">
                        <input type="checkbox" /></td>
                    <td class="order" style="width: 10px;"><%= ++index %></td>
                    <td class="hidden TopicSourceId"><%= item.TopicSourceId %></td>
                    <td style="width: 225px;">
                        <input class="form-control SortName" value="<%= item.TopicSourceName %>" /></td>
                </tr>
                <%} %>
            </table>
            <button type="button" id="saveChange" class="btn btn-primary">保存修改</button>
            <button type="button" id="addSort" class="btn btn-primary">添加题库</button>
            <button type="button" id="deleteSort" class="btn btn-danger">删除</button>

        </div>

    </div>
</body>
</html>
