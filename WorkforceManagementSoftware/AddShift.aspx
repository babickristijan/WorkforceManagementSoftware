<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddShift.aspx.cs" Inherits="WorkforceManagementSoftware.AddShift" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <link href="Scripts/spectrum.css" rel="stylesheet">
     <script src="Scripts/spectrum.js"></script>
      name: <asp:TextBox id="shift_name" runat="server" ></asp:TextBox>
        color: <asp:TextBox id="shift_color" runat="server"></asp:TextBox>
        <input type='text' class="basic"/>
        shift value: <asp:TextBox id="shift_value" runat="server" ></asp:TextBox>
    Is godisnji?:<asp:CheckBox ID="shift_is_godisnji" runat="server" />
   <asp:Button id="submitButton" runat="server" Text="Dodaj" OnClick="SubmitForm" />

    <script>
        $(".basic").spectrum({
            color: "#f00",
            change: function (color) {
                $("#MainContent_shift_color").val(color.toHexString());
            }
        });
    </script>
    </asp:Content>
