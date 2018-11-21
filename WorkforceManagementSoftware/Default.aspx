<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WorkforceManagementSoftware._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<script src="Scripts/Default.js"></script>
<link href="Scripts/Default.css" rel="stylesheet">




    <div class="wrap-padding" id='wrap'>
        <div id="shift-wrapper">
            <h4>Shifts</h4>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="getShifts">
                <ItemTemplate>
                    <div class='shifts' id='<%# Eval("id") %>'><%# Eval("naziv") %></div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="getShifts" runat="server" SelectCommand="SELECT TOP (1000) [id] ,[naziv] ,[color] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene]"></asp:SqlDataSource>
        </div>
        <div id='calendar'></div>
        <div style='clear: both'></div>
    </div>


   

    <!-- The Modal -->
    <div id="eventModal" class="modal-event">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <form>
        <select>
           <asp:Repeater ID="Repeater2" runat="server" DataSourceID="getShifts">
                <ItemTemplate>
                    <option class='shifts' id='<%# Eval("id") %>'><%# Eval("naziv") %></option>
                </ItemTemplate>
            </asp:Repeater>
        </select>
    </form>
  </div>

</div>
   
</asp:Content>
