<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InputTopic.aspx.cs" Inherits="Admin_TopicManage_InputTopic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery-1.8.3.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="../assets/layer/layer.js"></script>
    <script type="text/javascript" src="../js/MyAlert.js"></script>

    <style type="text/css">
     

        body {
            margin: 0;
            font-size: 12px;
        }

        .table tr td {
            padding-top: 4px !important;
            padding-bottom: 4px !important;
        }
    </style>

    <script type="text/javascript">
        $(function () {

            //添加知识点
            $("#add").click(function () {
                var pointArray = new Array();

                $("#checkTable").find("tbody tr").find("input:checked").each(function () {
                    var data = new Object();
                    data.FirstPointName = $(this).parent().siblings(".first").html();
                    data.SecondPointName = $(this).parent().siblings(".second").html();
                    pointArray.push(JSON.stringify(data));
                })
                if (pointArray.length <= 0) {
                    alert("请选择要添加的知识点");
                }
                else {
                    alert(pointArray);
                    window.location.href = "InputTopic.aspx?pointArray=" + pointArray;
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
                <a href="#" style="color: red">题库管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">导入题目</a>
            </div>

            <asp:Panel ID="Panel1" runat="server">

                <table  class="table table-bordered table-striped table-hover">
                    <tr>
                        <td style="text-align:center;">
                             <div style="width:420px; margin:0 auto;">
                            <asp:FileUpload ID="fuStu" runat="server"  CssClass="form-control" Width="400px" /></div>
                            </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;" >
                           <asp:Button ID="btnImport"  runat="server" Text="导入" CssClass="btn btn-primary" OnClick="btnImport_Click" />
                            
                            <span style="margin-left:15px;"></span><asp:Button ID="btnDownModle"  runat="server" Text="下载题目模板"
                                CssClass="btn btn-primary" OnClick="btnDownModle_Click"  /></td>
                    </tr>
                    <tr>
                        <td style="text-align:center; font-size:14px;">注意：请先下载题目模版，根据模版的格式制作EXCEL文件，再通过此方式导入题目</td>
                    </tr>
                </table>

                
                <%--<table width="100%">

                    <tr align="center">
                        <td>
                          
                            <asp:Button ID="btnImport" runat="server" Text="导入" OnClick="btnImport_Click" CssClass="redButtonCss" />
                            <asp:Button ID="btnDownModle" runat="server" Text="下载题目模板" OnClick="btnDownModle_Click"
                                CssClass="redButtonCss" Width="112px" /></td>
                    </tr>

                    <tr align="center">
                        <td>注意：请先下载题目模版，根据模版的格式制作EXCEL文件，再通过此方式导入题目</td>
                    </tr>
                </table>--%>
            </asp:Panel>

            <asp:Panel ID="Panel2" Visible="false" runat="server">
                <table id="checkTable" class="table table-bordered table-hover table-striped">
                    <caption>
                        <h4 style="text-align: center"><b>
                            <asp:Label ID="TableHead" runat="server" Text=""></asp:Label>
                        </b></h4>
                    </caption>
                    <thead>
                        <tr class="info">
                            <td>序号</td>
                            <td>题目标题</td>
                            <td>一级知识点</td>
                            <td>二级知识点</td>
                            <td>题目类别</td>
                            <td>所属题库名称</td>
                            <td>题目错误信息</td>
                        </tr>
                    </thead>
                    <% int index = 0; %>
                    <%if (imputTopics != null)
                      {%>
                    <%foreach (var item in imputTopics)
                      {%>
                    <tr>


                        <td><%= ++index %></td>
                        <%if (item.TopicTitle.Length <= 40)
                          {%>
                        <td style="height: 10px; width: 445px;"><%=item.TopicTitle %>  </td>
                        <%} %>
                        <%else
                          { %>
                        <td style="height: 10px; width: 445px;"><%=item.TopicTitle.Substring(0, 40) %>  </td>
                        <%} %>

                        <td class="first"><%=item.FirstPointName %></td>
                        <td class="second"><%=item.SecondPointName %></td>
                        <td><%=item.SortName %></td>
                        <td><%= item.TopicSourceName %></td>
                        <td style="color: red;"><%= item.ErrorInfo %></td>

                    </tr>

                    <%} %>

                    <%} %>

                    <tfoot>
                        <tr>
                            <td colspan="7">
                                <asp:Button CssClass="btn btn-primary" OnClick="ConfirmInput_Click" ID="ConfirmInput" runat="server" Text="继续导入" />
                                <asp:Button CssClass="btn btn-danger" ID="Reset" OnClick="Reset_Click" runat="server" Text="重新导入" />
                            </td>
                        </tr>
                    </tfoot>
                </table>

            </asp:Panel>


        </div>
    </form>
</body>
</html>
