<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TopicTypeInfo.aspx.cs" Inherits="BasicInfo_TopicTypeInfo" %>

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
                    data.SortId = tds.eq(1).html();
                    data.SortName = tds.eq(2).find("input").eq(0).val();
                    data.SortOrder = tds.eq(3).find("input").eq(0).val();
                    dataArray.push(JSON.stringify(data))

                    if (data.SortName === '' || data.SortOrder === '') {
                        alert("请输入题目类别信息");
                        res = -1
                        return false;

                    }

                    if (data.SortId == 0 && isNaN(data.SortOrder)) {
                        alert("请输入合法的排序号");
                        res = -1;
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
                var trStr = '<tr>' +
                    ' <td style="width:10px;"><input type="checkbox" /></td>' +
                   ' <td class="hidden">0</td>' +
                   ' <td style="width: 325px;">' +
                       ' <input class="form-control SortName" value="" /></td>' +
                   ' <td style="width: 100px;">' +
                      '  <input class="form-control" value="" /></td>' +
                '</tr>';
                $("#sortTable").append(trStr);

            })

            //删除
            $("#deleteSort").click(function () {

                if ($("#sortTable").find("input:checked").length == 0) {
                    alert("请选择题目类别");
                }
                else {
                    if (confirm("确认删除？")) {
                        var deleteArray = new Array();
                        $("#sortTable").find("tbody").find("tr").each(function (i) {

                            if ($(this).find("input:checkbox").eq(0).attr("checked") === "checked") {
                                if ($(this).children("td.hidden").html() != '0') {
                                    var data = new Object();
                                    data.SortId = $(this).children("td.hidden").html()
                                    data.SortName = $(this).find(".SortName").eq(0).val();
                                    deleteArray.push(JSON.stringify(data));
                                }

                            }
                        })
                        window.location.href = "TopicTypeInfo.aspx?deleteArray=" + deleteArray;
                    }
                }



            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server" action="TopicTypeInfo.aspx" method="post">
        <input type="hidden" name="allSorts" id="JsonText" />
    </form>

    <div>
        <ul class="nav nav-tabs" style="padding-left: 10px; margin-bottom: 5px; margin-top: 5px; font-weight: bolder;">
            <li><a href="PointInfo.aspx">知识点设置</a></li>
            <%--<li class="active"><a style="color: red" href="TopicTypeInfo.aspx">题目类别设置</a></li>--%>
            <li><a href="TopicSoureManage.aspx">题库设置</a></li>

        </ul>

        <div style="width: 640px; border-radius: 8px; margin: 15px auto;">
            <table id="sortTable" class="table table-bordered table-hover table-striped">
                <thead>
                    <tr class="info">
                        <td style="width: 10px;"></td>
                        <td>题目类别名称</td>
                        <td>排序号</td>
                    </tr>
                </thead>
                <%foreach (var sort in sorts)
                  {%>
                <tr>
                    <td style="width: 10px;">
                        <input type="checkbox" /></td>
                    <td class="hidden"><%= sort.SortId %></td>
                    <td style="width: 325px;">
                        <input class="form-control SortName" value="<%= sort.SortName %>" /></td>
                    <td style="width: 100px;">
                        <input class="form-control" value="<%= sort.SortOrder %>" /></td>
                </tr>
                <%} %>
            </table>
            <button type="button" id="saveChange" class="btn btn-primary">保存修改</button>
            <button type="button" id="addSort" class="btn btn-primary">添加题目类别</button>
            <button type="button" id="deleteSort" class="btn btn-danger">删除</button>

        </div>

    </div>
</body>
</html>
