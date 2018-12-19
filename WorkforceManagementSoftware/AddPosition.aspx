<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddPosition.aspx.cs" Inherits="WorkforceManagementSoftware.AddPosition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!--#include file="~/loader.html" -->
    <link rel="stylesheet" type="text/css" href="Scripts/addPosition.css">
   
    <div class="positionForm">
         <h1>Dodavanje pozicije</h1>
        <div class="row">
            <p>Naziv pozicije:</p>
            <div class="item">
                <asp:TextBox ID="position" runat="server" CssClass="textBox"></asp:TextBox><br>
            </div>
        </div>
        <div class="row">
            <div class="button">
                <asp:Button ID="submitButton" runat="server" Text="Spremi" OnClick="SubmitForm" CssClass="submitBtn" /></div>
        </div>
    </div>
</asp:Content>
