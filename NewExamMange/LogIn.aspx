<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogIn.aspx.cs" Inherits="Login2" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Creative - Bootstrap 3 Responsive Admin Template">
    <meta name="author" content="GeeksLabs">
    <meta name="keyword" content="Creative, Dashboard, Admin, Template, Theme, Bootstrap, Responsive, Retina, Minimal">
    <link rel="shortcut icon" href="img/favicon.png">

    <title>在线考试系统后台管理登陆</title>
    <script src="js/jquery.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="css/bootstrap-theme.css" rel="stylesheet">
    <!--external css-->
    <!-- font icon -->
    <link href="css/elegant-icons-style.css" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles -->
    <link href="css/style.css" rel="stylesheet">
    <link href="css/style-responsive.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

    <style type="text/css">
        #userChose {
            width: 600px;
            float: left;
            height: 500px;
        }

        #modalDiv {
            position: absolute;
            left: 0;
            top: 0;
        }

        #myModal {
            /*width:500px;*/
            margin: 200px auto;
            width: 500px;
            overflow: hidden;
        }

        .closeLink {
            margin-left: 220px;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $("#close").click(function () {
                window.opener = null;
                window.open('', '_self');
                window.close();
            })
        })
    </script>
</head>

<body class="login-img3-body">

    <div class="container">

        <form class="login-form" method="post" action="LogIn.aspx" runat="server">

            <asp:Panel ID="Panel2" runat="server">
                <div class="login-wrap">
                    <h3 style="text-align: center; margin-bottom: 10px;"><b>在线考试系统后台管理登陆</b> </h3>
                    <%--<p class="login-img"><i class="icon_lock_alt"></i></p>--%>
                    <div class="input-group" style="padding-top: 20px;">
                        <span class="input-group-addon"><i class="icon_profile"></i></span>
                        <input name="userName" type="text" class="form-control" required placeholder="用户名" autofocus>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="icon_key_alt"></i></span>
                        <input name="pwd" type="password" class="form-control" required placeholder="密码">
                    </div>
                    <%--         <label class="checkbox">
                <input type="checkbox" value="remember-me"> Remember me
                <span class="pull-right"> <a href="# "> Forgot Password?</a></span>
            </label>--%>


                    <button class="btn btn-primary btn-lg btn-block" type="submit">登陆</button>
                    <button id="close" class="btn btn-info btn-lg btn-block" type="button">取消</button>
                </div>
            </asp:Panel>



            <asp:Panel ID="Panel1" CssClass="container" Visible="false" runat="server">

                <div class="modal show" id="myModal">
                    <div class="">
                        <div class="modal-content">
                            <div class="modal-header">
                                <span class="colseSpan">
                                    <asp:LinkButton CssClass="closeLink" ID="LinkButton1" OnClick="Button1_Click" runat="server"> &times;</asp:LinkButton>
                                </span>
                                <h4 style="width: 230px; float: left;" class="modal-title" id="myModalLabel">请选择要进入的功能模块
                                </h4>
                            </div>
                            <div class="modal-body" style="margin-left: auto; margin-top: 15px; text-align: center">
                                <asp:Button ID="Admin" runat="server" Text="管理员" Width="83" CommandArgument="1" OnClick="Admin_Click" CssClass="btn btn-primary" />
                                <span style="margin-left: 60px;"></span>
                                <asp:Button ID="ExamTeacher" runat="server" Width="83" Text="监考教师" CommandArgument="2" OnClick="Admin_Click" CssClass="btn btn-primary" />

                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="Button1" CssClass="btn btn-danger" OnClick="Button1_Click" runat="server" Text="取消" />
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal -->
                    </div>
                </div>


            </asp:Panel>

        </form>

    </div>
</body>
</html>

