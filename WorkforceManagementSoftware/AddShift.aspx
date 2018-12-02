<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddShift.aspx.cs" Inherits="WorkforceManagementSoftware.AddShift" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      name: <asp:TextBox id="shift_name" runat="server" ></asp:TextBox>
        color: <asp:TextBox id="shift_color" runat="server"></asp:TextBox>
        shift value: <asp:TextBox id="shift_value" runat="server" ></asp:TextBox>
    Is godisnji?:<asp:CheckBox ID="shift_is_godisnji" runat="server" />
   <asp:Button id="submitButton" runat="server"  OnClick="SubmitForm" />


    </asp:Content>
