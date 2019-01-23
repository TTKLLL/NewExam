<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="css_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">.ButtonCss3 {font-family: "Tahoma", "宋体";FONT-SIZE: 9pt;color: #003399; border: 1px solid #93bee2;color: #006699;background-image: url('../image/bluebuttonbg.gif');background-color: #e8f4ff;CURSOR: hand;font-style: normal;width: 82px;height: 22px;}
        #left {
            height:500px;
            width:270px;
            float:left;
            background-color:white;
            border:1px solid #ccc;
        }
            #left #left-top {
                height:150px;
                background-color:#0751B0;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="left">
        <div id="left-top">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
    </form>
</body>
</html>
