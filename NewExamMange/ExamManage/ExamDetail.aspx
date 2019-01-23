<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamDetail.aspx.cs" Inherits="ExamManage_ExamDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />

    <style type="text/css">
        #nowExamStu tr td {
            height: 45px;
        }
  
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 10px; padding: 8px 0 8px 15px; background-color: #F5F5F5">
                <a href="../../Desktop.aspx">桌面</a>&nbsp;&gt;&gt;&nbsp;
                <a href=""  style="color:red">已发布的考试</a>&nbsp;&gt;&gt;&nbsp;
                <a href=""  style="color:red">考试详情</a>
            </div>

            <div id="content">

                
                <table id="paraTable"  style="line-height: 45px;" class="table table-bordered table-condensed">
                    <tr>
                        <td style="line-height:45px; width:83px">请选择场次</td>
                        <td>
                            <select class="form-control">
                                <option>全部</option>
                                <option>第一场 2019-06-10 9:00:00 ~ 2019-06-10 9:00:00</option>
                            </select>
                        </td>
                        <td style="width: 120px; line-height: 45px;">请选择考试状态</td>
                        <td style="width: 100px; height:35px;">
                            <select class="form-control">
                                <option>全选</option>
                                <option>未开始</option>
                                <option>正在考试</option>
                                <option>已交卷</option>
                            </select>
                        </td>
                        <td style="line-height: 45px; width: 85px;">请选择考场:
                        </td>
                        <td style="width: 100px;">
                            <select class="form-control">
                                <option>全部</option>
                                <option>k4-201</option>
                                <option>k4-202</option>
                            </select>
                        </td>
                         <td style="line-height: 45px; width: 85px;">请选择班级:
                        </td>
                        <td style="width: 220px;">
                            <select class="form-control" style="width: 210px;">
                                <option>全部</option>
                                <option>2015级软件工程(1)班</option>
                                <option>2015级计算机科学与技术(1)班</option>
                            </select>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary">查询</button>
                        </td>
                    </tr>
                </table>
                <table class="table table-hover table-striped table-bordered" id="nowExamStu">
                    <caption>
                        <h3 style="text-align: center"><b>数据库第100次考试</b></h3>
                    </caption>
                    <thead>
                        <tr class="info">
                            <td>序号</td>
                            <td>学号</td>
                            <td>姓名</td>
                            <td>班级</td>
                            <td>考试状态</td>
                            <td>考场</td>
                            <td>IP地址</td>
                            <td>操作</td>
                        </tr>
                    </thead>
                    
                    <tr style="height: 20px;">
                        <td>1</td>
                        <td>201540450119</td>
                        <td>李昶</td>
                        <td>2015级软件工程(1)班</td>
                        <td>未开始考试</td>
                        <td>k4-201</td>
                        <td>172.16.25.2</td>
                        <td>
                            <button  type="button"class="btn btn-danger btn-sm">重置考试状态</button></td>
                    </tr>
                    <tr style="height: 20px;">
                        <td>1</td>
                        <td>201540450119</td>
                        <td>李昶</td>
                        <td>2015级软件工程(1)班</td>
                        <td>未开始考试</td>
                        <td>k4-201</td>
                        <td>172.16.25.2</td>
                        <td>
                            <button  type="button"class="btn btn-danger btn-sm">重置考试状态</button></td>
                    </tr>
                    <tr style="height: 20px;">
                        <td>1</td>
                        <td>201540450119</td>
                        <td>李昶</td>
                        <td>2015级软件工程(1)班</td>
                        <td>未开始考试</td>
                        <td>k4-201</td>
                        <td>172.16.25.2</td>
                        <td>
                            <button  type="button"class="btn btn-danger btn-sm">重置考试状态</button></td>
                    </tr>
                    
                </table>
  
                 <div style="float:right; margin-right:50px;">
                   <button type="button" class="btn btn-primary btn-xs">上一页</button>
                   <button type="button" class="btn btn-primary btn-xs">下一页</button>
                   &nbsp;第<input value="1"  style="width:25px; height:22px;"/>页
                   <button type="button" class="btn btn-primary btn-xs">转到</button>
                   共10页
               </div>

                 <table style="line-height: 50px; margin-top:10px;" class="table table-bordered table-condensed">
                    <tr>
                        <td style="width: 155px; line-height: 45px;">请输入考生相关信息
                        </td>
                        <td style="width: 200px;">
                            <asp:TextBox runat="server" Width="200px" class="form-control" ID="tb_Query"></asp:TextBox>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary" id="querty_btn">查询</button>  
                        </td>
                        
                    </tr>
                </table>
            </div>

        </div>
    </form>
</body>
</html>
