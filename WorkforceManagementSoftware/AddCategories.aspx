<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddCategories.aspx.cs" Inherits="WorkforceManagementSoftware.AddCategories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <link rel="stylesheet" type="text/css" href="Scripts/AddCategories.css">
    <h2>Dodavanje kategorije</h2>
        <div class="shiftForm">
            
      Naziv kategorije: <asp:TextBox id="category" runat="server" CssClass="shiftName"></asp:TextBox><br>
   <asp:Button id="submitButton" runat="server" Text="Spremi" OnClick="SubmitForm" CssClass="submitShift" />
    </div>
</asp:Content>
