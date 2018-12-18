<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddShift.aspx.cs" Inherits="WorkforceManagementSoftware.AddShift" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Dodavanje smjene</h2>
     <link href="Scripts/spectrum.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="Scripts/addShift.css">
     <script src="Scripts/spectrum.js"></script>
    <div class="shiftForm">
      Ime smjene: <asp:TextBox id="shift_name" runat="server" CssClass="shiftName"></asp:TextBox><br>
        Boja: <asp:TextBox id="shift_color" runat="server" CssClass="shiftColor"></asp:TextBox>
        <input type='text' class="basic"/><br>
        Vrijednost smjene(u satima): <asp:TextBox id="shift_value" runat="server" CssClass="shiftValue" ></asp:TextBox><br>
    Godišnji?:<asp:CheckBox ID="shift_is_godisnji" runat="server"  CssClass="isGodisnji"/><br>
   <asp:Button id="submitButton" runat="server" Text="Spremi" OnClick="SubmitForm" CssClass="submitShift" />
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
