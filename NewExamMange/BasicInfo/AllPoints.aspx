<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AllPoints.aspx.cs" Inherits="BasicInfo_AllPoints" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $("#turnTo").click(function () {
                var page = $("#page").val();
                window.location.href = "AllPoints.aspx?pageNumber=" + page;
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href="PointInfo.aspx" style="color: red">知识点管理</a>
                &nbsp;&gt;&gt;&nbsp;
                <a href="" style="color: red">所有知识点</a>
            </div>

            <div style="width: 740px; border-radius: 8px; margin: 15px auto;">

                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr class="info">
                            <td>序号</td>
                            <td>一级知识点</td>

                            <td>二级知识点</td>

                        </tr>
                    </thead>

                    <% int index = 0; %>
                    <%foreach (var item in allPoints) %>
                    <%{ %>
                    <tr>
                        <td><%= ++index + (pageNumber-1)*PointService.AllPointsSize %></td>
                        <td><%=item.FirstPointName %></td>

                        <td><%=item.SecondPointName %></td>

                    </tr>
                    <%} %>
                </table>
                <div style="float: right; margin-right: 50px;">
                    <%if (pageNumber == 1)
                      {%>
                    <button type="button" class="btn btn-primary btn-xs" disabled="disabled">上一页</button>
                    <%} %>
                    <%else
                      {%>
                    <a href="AllPoints.aspx?pageNumber=<%=pageNumber-1%>" class="btn btn-primary btn-xs">上一页</a>
                    <%} %>

                    <%if (pageNumber == totalPage)
                      { %>
                    <button type="button" class="btn btn-primary btn-xs" disabled="disabled">下一页</button>
                    <%} %>
                    <%else
                      {%>
                    <a href="AllPoints.aspx?pageNumber=<%=pageNumber+1%>" class="btn btn-primary btn-xs">下一页</a>
                    <%} %>
                 
                    &nbsp;第<input id="page" value="<%=pageNumber %>" style="width: 25px; height: 22px;" />页
                   <button type="button" class="btn btn-primary btn-xs" id="turnTo">转到</button>
                    共<%= totalPage %>页
                </div>
            </div>




        </div>
    </form>
</body>
</html>
