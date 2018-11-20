<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WorkforceManagementSoftware._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<script src="Scripts/Default.js"></script>
<link href="Scripts/Default.css" rel="stylesheet">
 <link href="Scripts/lightbox.css" rel="stylesheet">




    <div class="wrap-padding" id='wrap'>
        <div id="shift-wrapper">
            <h4>Shifts</h4>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="myConnectionString">
                <ItemTemplate>
                    <div class='shifts' id='<%# Eval("id") %>'><%# Eval("naziv") %></div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="myConnectionString" runat="server" SelectCommand="SELECT TOP (1000) [id] ,[naziv] ,[color] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene]"></asp:SqlDataSource>
        </div>
        <div id='calendar'></div>
        <div style='clear: both'></div>
    </div>
   






     <div class="lightboxOuter" id="modal-view">
        <div class="lightboxInner">
            <span class="lightboxClose" id="lightboxClose">&times;</span>
            <div class="lightboxForm">
                <div class="shiftSelector">
                    <h1 class="h1">Choose Shift:</h1>
                    <select name="shiftPicker" id="shiftPicker" form="shiftPicker" class="shiftPicker">
                    <option value="8-15">8-15</option>
                    <option value="s2">8-16</option>
                    <option value="s3">12-20</option>
                    <option value="s4">15-22</option>
                    <option value="s5">16-22</option>
                    <option value="s6">8-13</option>
                    <option value="s7">13-18</option>
                    <option value="s8">16-22</option>
                    <option value="s9">GO</option>
                </select>
                </div>
                <div class="dateSelector">
                        <h3 class="h3">Start Date: <input type="text" id="startDate"></h3>
                        <input type="hidden" id="resourceIdHidden">
                        <h3 class="h3">End Date: <input type="text" id="endDate"></h3>
                </div>
            </div>
            
            <div class="bottomBtns">
                <button class="saveBtn" id="saveBtn" type="button">Save</button>
                <button class="deleteBtn" type="button">Delete</button>
            </div>
        </div>
    </div>
   
</asp:Content>
