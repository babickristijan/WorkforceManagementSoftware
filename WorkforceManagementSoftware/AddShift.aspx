<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddShift.aspx.cs" Inherits="WorkforceManagementSoftware.AddShift" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!--#include file="~/loader.html" -->

    <link href="Scripts/spectrum.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="Scripts/addShift.css">
    <script src="Scripts/spectrum.js"></script>
    <div class="shiftForm">

        <h1>Dodavanje smjene</h1>

        <div class="row">
            <p>Ime smjene:</p>
            <div class="item">
                <asp:TextBox ID="shift_name" runat="server" CssClass="shiftName"></asp:TextBox><br>
            </div>
        </div>
        <div class="row">
            <p>Boja:</p>
            <div class="item">
                <asp:TextBox ID="shift_color" runat="server" CssClass="shiftColor"></asp:TextBox><br>
                <div class="colorPicker">
                    <input type='text' class="basic" /></div>
                <br>
            </div>
        </div>
        <div class="row">
            <p>Smjene(u satima): </p>
            <div class="item">
                <asp:TextBox ID="shift_value" runat="server" CssClass="shiftValue"></asp:TextBox><br>
            </div>
        </div>
        <div class="row">
            <p>Godišnji?:</p>
            <div class="item">
                <asp:CheckBox ID="shift_is_godisnji" runat="server" CssClass="isGodisnji" /><br>
            </div>

        </div>

        <div class="row">
            <div class="button">
                <asp:Button ID="submitButton" runat="server" Text="Spremi" OnClick="SubmitForm" CssClass="submitBtn" />
            </div>
        </div>
    </div>


    <script>
        $(".basic").spectrum({
            color: "#f00",
            change: function (color) {
                $("#MainContent_shift_color").val(color.toHexString());
            }
        });
    </script>
</asp:Content>
