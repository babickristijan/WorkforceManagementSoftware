<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddCategories.aspx.cs" Inherits="WorkforceManagementSoftware.AddCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" type="text/css" href="Scripts/AddCategories.css">

    <div class="categoriesForm">
        <h1>Dodavanje kategorije</h1>
        <div class="row">
            <p>Naziv kategorije: </p>
           <div class="item"> <asp:TextBox ID="category" runat="server" CssClass="textBox"></asp:TextBox></div><br>
        </div>
        <div class="row">
            <div class="button"><asp:Button ID="submitButton" runat="server" Text="Spremi" OnClick="SubmitForm" CssClass="submitBtn" /></div>
        </div>
    </div>
</asp:Content>
