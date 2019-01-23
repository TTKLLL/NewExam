<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PracticalExam.aspx.cs" Inherits="PracticalExam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../js/jquery.min.js"></script>

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-theme.css" rel="stylesheet" />

    <script src="assets/layer/layer.js"></script>
    <script src="js/MyAlert.js"></script>

    <script type="text/javascript">
        $(function () {



            $(" .right ul li").hover(function () {

                $(this).toggleClass("blueOption");
            })
        })
    </script>

    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }
        /*页面顶部*/
        .top {
            height: 50px;
            width: 100%;
            background-color: #F97511;
            text-align: center;
            line-height: 50px;
            margin-bottom: 2px;
        }

        .headLine {
            font-weight: 600;
            font-size: 24px;
            color: white;
        }

        .RemainingTime {
            font-weight: 400;
            font-size: 20px;
            color: #E9F5E9;
            width: 230px;
            float: right;
            position: relative;
            left: -30px;
        }

        /*页面左部*/
        .left {
            width: 320px;
            min-height: 600px;
            float: left;
            border: 1px solid #AAAAAA;
            margin: 0;
            padding: 0;
            background-color: white;
        }

        .stuInfo {
            padding-left: 20px;
            background-color: #F2F5F9;
            color: black;
        }

        .left > .stuInfo > li {
            font-size: 16px;
            padding-left: 0px;
            font-weight: 400;
            line-height: 30px;
            list-style: none;
            color: black;
        }

        /*题目列表*/
        .allTitleList {
        }

        .theTitleList > span {
            padding-left: 20px;
            background-color: #F2F5F9;
            display: block;
            font-weight: 600;
            height: 35px;
            line-height: 35px;
            font-size: 16px;
        }

        .theTitleList ul {
            padding-left: 10px;
            margin-bottom: 15px;
            margin-top: 10px;
        }

        .theTitleList li {
            list-style: none;
            width: 25px;
            height: 25px;
            float: left;
            border-radius: 1em;
            line-height: 20px;
            text-align: center;
            font-weight: 600;
            margin: 2px;
            font-size: 14px;
        }

            .theTitleList li a {
                color: white;
                font-weight: 600;
                display: block;
                width: 25px;
                height: 25px;
                border-radius: 1em;
                line-height: 25px;
                text-align: center;
                font-weight: 600;
                background-color: #CDD0D4;
            }

                .theTitleList li a:hover {
                    text-decoration: none;
                }

        .left_bottom {
            margin-top: 20px;
            width: 300px;
            margin: 20px auto;
        }

            .left_bottom ul {
                margin-left: 10px;
            }

            .left_bottom li {
                list-style: none;
                width: 70px;
                float: left;
                text-align: center;
            }

                .left_bottom li span {
                    height: 20px;
                    width: 20px;
                    background-color: red;
                    display: block;
                    margin: auto;
                    width: 25px;
                    height: 25px;
                    border-radius: 1em;
                    line-height: 25px;
                    text-align: center;
                }

            .left_bottom > div {
                margin-top: 5px;
                position: relative;
                left: 30px;
            }

        /*页面右部*/
        .right {
            width: 840px;
            min-height: 450px;
            float: left;
            margin-left: 55px;
            /*padding-left: 10px;*/
            color: #546061;
            margin-top: 0;
            padding-top: 0;
            /*background-color:#ccc;*/
            border: 1px solid #dcdcdc;
            box-shadow: 0 0 13px hsla(0,0%,51%,.2);
            background-color: white;
            margin-left: 90px;
        }

            .right .titltInfo {
                font-weight: 600;
                font-size: 16px;
                margin-bottom: 10px;
            }

            .right .theTitle {
                font-size: 16px;
            }

            .right .titleContent {
                margin-bottom: 10px;
                line-height: 20px;
            }

            .right li {
                list-style-type: none;
                line-height: 30px;
                margin-left: 30px;
                font-weight: 400;
            }

        .changeTitle {
            margin-left: auto;
            margin-right: auto;
            padding: 3px;
            width: 260px;
            height: 80px;
        }

        .materiaContnet {
            height: 240px;
            overflow: auto;
            font-size: 16px;
            line-height: 26px;
        }

        #titleDetail {
            width: 600px;
            margin: 15px auto;
            margin-top: 0;
            padding-top: 0;
        }


        /*一个题目*/
        .right .theTitle {
            background-color: white;
            font-size: 16px;
            padding: 30px 0;
            /*border: 1px #DEDEDE solid;*/
        }

        .right .titltInfo {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 10px;
        }


        .right .titleContent {
            margin-bottom: 10px;
            /*width: 1115px;*/
            font-size: 16px;
            margin-bottom: 10px;
            line-height: 22px;
            font-weight: 400;
            width: 700px;
            padding-left: 20px;
            padding-right: 20px;
            margin-top: 0px;
        }

        .right li {
            list-style-type: none;
            font-size: 14px;
            font-weight: 400;
            width: 760px;
            font-weight: 300;
            line-height: 20px;
            padding: 10px 15px 10px;
            margin-left: 0;
            border: 1px solid #EAEAEA;
            border-radius: 1em;
            margin-bottom: 15px;
        }

        .right ul {
            margin: 0px;
            border-bottom: 1px;
            margin-left: 10px;
        }

        .SortName { /*766 62*/
            height: 62px;
            background-color: #FAFAFA;
            line-height: 62px;
            border-bottom: 1px solid #F0F0F7;
            color: #3A3E51;
            padding-left: 22px;
            padding-bottom: 0;
            margin-bottom: 0;
        }

        .titleIndex {
            color: #1A8CFE;
        }

        .blueOption {
            background-color: #FAFAFA;
            color: #1A8CFE;
        }
    </style>

    <script type="text/javascript">
        function submintPaper() {
            var studentId = "<%= studentId%>"
            var examId = "<%= examId%>"
            $.post("SubmitExam.ashx", { studentId: studentId, examId: examId }, function (data) {
                if (String(data).toLowerCase() === 'true') {
                    layer.alert("交卷成功，请点击确认按钮后安静离开考场。", { icon: 1 }, function () {
                        window.location.href = "LogIn.aspx";
                    })

                }
                else {
                    errAlert("交卷失败，请重试。");
                }

            })
        }

        $(function () {
            //计算剩余考试时间
            var endTime = '<%= endTime%>'
            var endTimeStamp = Date.parse(endTime) / 1000;
            var studentId = "<%= studentId%>"
            var examId = "<%= examId%>"
            //   alert(studentId + " " + examId);

            var interval = $(setInterval(function () {
                var nowStamp = Date.parse(new Date()) / 1000;
                var reaminStamp = endTimeStamp - nowStamp;
                if (reaminStamp <= 0) {
                    $.post("SubmitExam.ashx", { studentId: studentId, examId: examId }, function (data) {
                        if (String(data).toLowerCase() === 'true') {
                            clearInterval(interval)
                            layer.alert("考试已结束，系统成功自动交卷", { icon: 1 }, function () {
                                window.location.href = "LogIn.aspx";
                            })

                        }


                    })



                }
                else {
                    var minutes = Math.floor(reaminStamp / 60);
                    var seconds = reaminStamp - minutes * 60

                    $('.RemainingTime').html("距离考试结束：" + minutes + "  分钟" + seconds + "秒")
                }
            }), 1000);


            //题目列表伸缩
            $(".theTitleList span").click(function () {
                //    $(this).parent().siblings(".theTitleList span").hide(1000);
                $(this).siblings("ul").toggle();
            });

            //交卷
            $("#submitPaper").click(function () {

                var sortDiv = $(".theTitleList");

                var flag = 0;
                sortDiv.each(function () {
                    var WaitNumber = parseInt($(this).find(".WaitNumber").eq(0).html());
                    var TotalNumber = parseInt($(this).find(".TotalNumber").eq(0).html());
                    var num = TotalNumber - WaitNumber
                    // if (WaitNumber < TotalNumber) //题目未做完
                    flag += num;
                })

                var isSubmit;  //判断是否确定交卷
                if (flag > 0) {
                    layer.confirm("还有" + flag + "未完成，是否确定交卷?", { btn: ['确定', '取消'] }, function () {
                        submintPaper();
                    }, function () {
                        layer.closeAll();
                    })
                }
                else {
                    layer.confirm("是否确定交卷?", { btn: ['确定', '取消'] }, function () {
                        submintPaper();
                    }, function () {
                        layer.closeAll();
                    })
                }

            })

            //下载题目
            $(".downloadTopic").click(function () {
                var tId = $(this).parent().parent().find(".tId")[0].textContent;
                window.location.href = "../TopicManage/DownPracticalTopic.ashx?tId=" + tId;
            });
        })
    </script>

</head>
<body>
    <form id="form1" runat="server" action="PracticalExam.aspx">
        <div class="top">
            <asp:Label ID="headLine" CssClass="headLine" runat="server" Text=""></asp:Label>

        </div>

        <div class="left">

            <ul class="stuInfo">
                <li>姓名：<asp:Label ID="Sname" runat="server"></asp:Label></li>
                <li>学号：<asp:Label ID="Sno" runat="server"></asp:Label></li>
            </ul>

            <div class="allTitleList">

                <button id="submitPaper" type="button" style="width: 100%; font-weight: 600; margin-top: 10px; text-align: center" class="btn btn-primary form-control ">交&nbsp;&nbsp;&nbsp;&nbsp;卷</span></button>

                <div style="width: 275px; margin: 20px auto; text-align: center; color: red;" class="RemainingTime"></div>
            </div>
        </div>

        <div style="height: 500px; background-color: #FAFAFA;">
            <div class="right container" style="width:900px;">
                <table id="topicTab" class="table table-bordered table-hover table-striped">
                    <thead>
            
                        <tr class="info">
                  
                            <td style="width: 15%">题目名称</td>
                            <td style="width: 40%">题目描述</td>
                        
                            <td style="width: 9%">操作
                            </td>
                        </tr>
                    </thead>
                    <tr>           
                        <td><a href="#" class="downloadTopic"><%= topic.TopicName %></a><span class="hidden"><%= topic.Tid %></span></td>
                        <td><%= topic.TopicDesc %></td>       
                        <td><a href="#" class="downloadTopic">下载</a></td>
                        <td class="hidden"><span class="tId"><%= topic.Tid %></span></td>
                    </tr>
                   <tr>
                       <td>
                           <div style="width:240px; margin: 0 auto;">

                                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" Width="240px" />

                            </div>
                       </td>
                       <td style="line-height:37px;" >
                           <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                       </td>
                       <td>
                           <asp:Button ID="btnImport" runat="server" Text="提交" CssClass="btn btn-primary" OnClick="btnImport_Click" />
                       </td>
                   </tr>
                      <tr>
                        <td  colspan="3">请下载试卷文档， 在该文档上答题后上传该文档， 确认成功上传后即可交卷！</td>
                    </tr>
                
                </table>
            </div>
        </div>
    </form>
</body>
</html>
