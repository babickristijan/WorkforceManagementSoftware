<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddPosition.aspx.cs" Inherits="WorkforceManagementSoftware.AddPosition" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" type="text/css" href="Scripts/addPosition.css">
    <div class="shiftForm">
      Name: <asp:TextBox id="position" runat="server" CssClass="shiftName"></asp:TextBox><br>
   <asp:Button id="submitButton" runat="server" Text="Dodaj" OnClick="SubmitForm" CssClass="submitShift" />
    </div>
</asp:Content>
