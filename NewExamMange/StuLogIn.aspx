<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StuLogIn.aspx.cs" Inherits="LogIn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Creative - Bootstrap 3 Responsive Admin Template">
    <meta name="author" content="GeeksLabs">
    <meta name="keyword" content="Creative, Dashboard, Admin, Template, Theme, Bootstrap, Responsive, Retina, Minimal">
    <link rel="shortcut icon" href="img/favicon.png">

    <title>在线考试系统考试登陆</title>
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

    <script src="assets/layer/layer.js"></script>
    <script src="js/MyAlert.js"></script>
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

        .beforLogIn {
            width: 1000px;
            font-size: 26px;
            text-align: center;
            margin-top: 100px;
        }

        .loginBtn {
            color: white;
            background-color: red;
            font-weight: 600;
            font-size: 20px;
            border: 0;
        }

        #examInfo {
            color: black;
            height: 350px;
            width: 800px;
            background-color: #ccc;
            padding: 50px;
            opacity: 0.8;
            margin: 15px auto;
            margin-top: 80px;
        }

            #examInfo ul {
                width: 500px;
                list-style: none;
                font-size: 24px;
                margin: 15px auto;
                /*margin-left:90px;*/
            }

                #examInfo ul li {
                    width: 500px;
                    line-height: 35px;
                    text-align: left;
                    display: block;
                    margin: 0 auto;
                }

        #title {
            font-weight: 600;
            font-size: 24px;
        }

        #confirmExam {
            width: 430px;
            margin: 15px auto;
            font-size: 24px;
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $("#close").click(function () {
                window.opener = null;
                window.open('', '_self');
                window.close();
            })

            //计算考试开始时间
            var beginTime = '<%= beginTime%>';

            if (beginTime === '') {
                $('.RemainingTime').html('考试已开始，请点击确认按钮开始考试')
                return false;
            }
            var beginTimeStamp = Date.parse(beginTime) / 1000;

            $(setInterval(function () {
                var nowStamp = Date.parse(new Date()) / 1000;
                var reaminStamp = beginTimeStamp - nowStamp;
                if (reaminStamp <= 0) {
                    $('.RemainingTime').html('考试已开始，请点击确认按钮开始考试')
                }
                else {
                    var minutes = Math.floor(reaminStamp / 60);
                    var seconds = reaminStamp - minutes * 60

                    $('.RemainingTime').html("距离考试开始&nbsp;" + minutes + "  分钟" + seconds + "秒")
                }
            }), 1000);
        })
    </script>
</head>

<body class="login-img3-body">
    <form  method="post" action="StuLogIn.aspx" runat="server">

        <asp:Panel ID="Panel1" CssClass="container" Visible="true" runat="server">
            <div class="login-form""><div class="login-wrap">
                <h3 style="text-align: center; margin-bottom: 10px;"><b>在线考试系统考试登陆</b> </h3>
                <%--<p class="login-img"><i class="icon_lock_alt"></i></p>--%>
                <div class="input-group" style="padding-top: 20px;">
                  
                   <div class="input-group">
                       <span class="input-group-addon" >学号：</span>
                       <asp:TextBox ID="TextBox1" Width="240" CssClass="form-control" Text="" runat="server"></asp:TextBox>
                      </div>

                    <div class="input-group">
                         <span class="input-group-addon">姓名：</span>
                        <asp:TextBox ID="TextBox2" CssClass="form-control" Width="240" Text="" runat="server"></asp:TextBox>
                      </div>
                    
                    
                    <%-- <input name="userName" type="text" class="" required placeholder="请输入学号" autofocus>--%>
                </div>
                <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block" OnClick="Button1_Click" runat="server" Text="登录" />
                <%--    <button class="btn btn-primary btn-lg btn-block" type="submit">登陆</button>--%>
                <button id="close" class="btn btn-info btn-lg btn-block" type="button">取消</button>
            </div></div>
            

        </asp:Panel>

        <asp:Panel ID="Panel2" Visible="false" runat="server">
            <div id="examInfo">
                <h2 id="" style="font-size: 24px !important;">

                    
                    <asp:Label Visible="false" ID="Label2" runat="server" Text=""></asp:Label>
                    <%--<asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <asp:Label Font-Size="24" Font-Bold="true" ID="Label1" runat="server" Text='<%# Eval("ExameTitle") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:Repeater>--%>

                </h2>
                <div style="text-align: center">
            
                   <div style="font-size:30px;font-weight:800; color:black;"><%= examName %></div>
                        
                    <ul>
                        <li>该考试开始时间为： <b><%= nowExam.ExamBegTime %></b></li>
                        <li>该考试结束时间为： <b><%= nowExam.ExamEndTime %></b></li>
                    </ul>
                   </div> 
                  
                <div style="width: 430px; text-align:center; margin:20px auto; font-size:24px;" class="RemainingTime">剩余时间</div>
              
                <div id="confirmExam" >
                    是否确认开始考试：
                    <asp:Button ID="Button2" CssClass="btn btn-primary" OnClick="Button2_Click" runat="server" Text="确认" />
                </div>
                
            </div>

        </asp:Panel>

        <asp:Panel ID="Panel3"  CssClass="container" Visible="false" runat="server">
            <div class="login-form""><div class="login-wrap">
                <h3 style="text-align: center; margin-bottom: 10px;"><b>请输入手机号</b> </h3>
                <%--<p class="login-img"><i class="icon_lock_alt"></i></p>--%>
                <div class="input-group" style="padding-top: 20px;">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>

                    <asp:TextBox ID="TextBox3" CssClass="form-control" Text="" runat="server"></asp:TextBox>
                </div>
                <asp:Button ID="Button3" CssClass="btn btn-primary btn-lg btn-block" OnClick="Button3_Click" runat="server" Text="确认" />

            </div></div>
            

        </asp:Panel>

    </form>


</body>
</html>

