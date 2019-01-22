<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="WorkforceManagementSoftware.User" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

        <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>

    <webopt:bundlereference runat="server" path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

    <link href="~/Scripts/fullcalendar.min.css" rel="stylesheet">
    <link href="~/Scripts/fullcalendar.print.min.css" rel="stylesheet" media="print">
    <link href="~/Scripts/scheduler.min.css" rel="stylesheet">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link href="https://fonts.googleapis.com/css?family=Dosis" rel="stylesheet">
        <style>
        .loginButton {
            padding:6px 12px !important;
        }
    </style>
</head>
<body>
    <div class="loader">

    <div class="spinner">
        <div class="double-bounce1"></div>
        <div class="double-bounce2"></div>
    </div>
</div>
    <form runat="server">
                <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see https://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>


    <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header" style="width:20%">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <img src="/images/dhh-logo-top.png" alt="Logo" style="width:50px; height:50px;">
                    <%--<a class="navbar-brand" runat="server" href="~/">Workforce Management</a>--%>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav" style="width:80%;">
                        <li style="float:right;margin-top:7px;">

                    <asp:LoginStatus ID="LoginStatus1" runat="server" ForeColor="White" CssClass="btn btn-primary loginButton" />
                    </li>
                            <div class="row" style="float:right;display:none;">
                            
                        <asp:LoginName ID="LoginName1" runat="server" Font-Bold = "true" />
                        <br />
                        
                    </div>
                    </ul>
                </div>
            </div>
        </div>
         </form>
    <div class="wrap-padding" id='wrap'>
<div id='calendar'></div>
        </div>
        <script src="Scripts/moment.min.js"></script>
    <script src="Scripts/jquery.min.js"></script>
    <script src='Scripts/jquery-ui.min.js'></script>
    <script src="Scripts/fullcalendar.min.js"></script>
    <script src="Scripts/locale/hr.js"></script>
    <script src="Scripts/scheduler.min.js"></script>
    <script src="Scripts/User.js"></script>
    <link href="Scripts/User.css" rel="stylesheet">
</body>
</html>
