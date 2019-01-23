<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTopic.aspx.cs" Inherits="Admin_TopicManage_AddTopic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../js/ueditor/ueditor.all.min.js"></script>
    <script src="../../js/ueditor/ueditor.config.js"></script>

    <link href="../../css/teacher.css" rel="stylesheet" />
    <link href="../../css/TabStyle.css" rel="stylesheet" />
    <link href="../../css/L.layout.css" rel="stylesheet" />
    <link href="../../css/common.css" rel="stylesheet" />

    <style type="text/css">
        body {
            font-size: 14px;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $(".topicType").click(function () {
                if ($(this).attr("id") === 'singeleRadio') {

                    $(".singleTopic").show();
                    $(".multipleTopic").hide();
                }
                else if ($(this).attr("id") === 'multipleRadio') {
                    $(".singleTopic").hide();
                    $(".multipleTopic").show();
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
           <a href="TopicInfo.aspx" style="color: red">题库管理</a>&nbsp;&gt;&gt;&nbsp;
                <a href="#" style="color: red">添加题目</a>
            </div>

            <div class="addTopic">
                <table class="addTitle">
                    <tr>
                        <td>知识点：</td>
                        <td>一级知识点：<asp:DropDownList AutoPostBack="true" ID="DropDownList1" runat="server">
                            <asp:ListItem>----请选择----</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                        二级知识点：
                        <asp:DropDownList ID="DropDownList2" runat="server">
                            <asp:ListItem>----请选择----</asp:ListItem>
                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>题目类别:</td>
                        <td>
                            <select>
                                <option>基础题</option>
                                <option>SQL</option>
                                <option>数据库分析与设计</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>题目标题：</td>
                        <td>
                            <asp:TextBox ID="SingleTitle" TextMode="MultiLine" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SingleTitle" ErrorMessage="不能为空"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>答案A：</td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" Width="850px">
                            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="不能为空"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>答案B：</td>
                        <td>
                            <asp:TextBox ID="TextBox3" runat="server" Width="850px">
                            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="InputCss" ControlToValidate="TextBox3" ErrorMessage="不能为空"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>答案C：</td>
                        <td>
                            <asp:TextBox ID="TextBox4" runat="server" Width="850px">
                            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="不能为空"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>答案D：</td>
                        <td>
                            <asp:TextBox ID="TextBox5" runat="server" Width="850px">
                            </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox5" ErrorMessage="不能为空"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>题目类型</td>
                        <td>
                            <input type="radio" class="topicType" id="singeleRadio" checked="checked" name="topicType" />单选题
                            <input type="radio" class="topicType" id="multipleRadio" name="topicType" />多选题
                        </td>
                    </tr>
                    <tr>
                        <td>正确答案：</td>
                        <td>
                            <div class="singleTopic">
                                <asp:DropDownList CssClass="drop" Width="100" ID="DropDownList3" runat="server">
                                    <asp:ListItem Value="A">A</asp:ListItem>
                                    <asp:ListItem Value="B">B</asp:ListItem>
                                    <asp:ListItem Value="C">C</asp:ListItem>
                                    <asp:ListItem Value="D">D</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="multipleTopic" style="display: none;">
                                <input type="checkbox" />
                                A
                                <input type="checkbox" />
                                B
                                <input type="checkbox" />
                                C
                                <input type="checkbox" />
                                D
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <asp:Button ID="Button1" runat="server" Text="添加" CssClass="ButtonCss" />&nbsp;&nbsp;
                        
                    <asp:Button ID="Button3" CausesValidation="false" CssClass="ButtonCss" OnClientClick="return confirm('确定取消？')" runat="server" Text="取消" />
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <script type="text/javascript">
            var ue = UE.getEditor('SingleTitle', {
                toolbars: [[
                    'fullscreen', 'source', '|',
                    'undo', 'redo', '|', 'insertimage',
                    'bold', 'italic', 'underline', 'strikethrough', 'removeformat', '|',
                    'forecolor', 'backcolor', '|',
                    'insertorderedlist', 'insertunorderedlist', 'cleardoc', '|',
                    'paragraph', 'fontfamily', 'fontsize', '|',
                    'indent', '|',
                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
                    'link', '|',
                    'simpleupload', 'emotion', 'insertvideo', '|',
                    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts'
                ]]
            });
            ue.ready(function () {
                ue.setHeight(160);
            });
        </script>
    </form>
</body>
</html>
