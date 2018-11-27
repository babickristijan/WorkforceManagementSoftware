﻿<%@ Page Title="Workers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Workers.aspx.cs" Inherits="WorkforceManagementSoftware.Workers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        table, td, tr {
            border: 1px solid #ddd;
            text-align: left;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        tr, td {
            padding: 15px;
        }

        .btn-primary {
            float: right
        }

        .tableHeader {
            background-color: lightgray;
        }
    </style>
    <h2><%: Title %></h2>
    <div class="wrap-padding" id='wrap'>
        <div id="employee-wrapper">
            <asp:Button ID="addANewWorker" runat="server"  Text="Add a New Worker" CssClass="btn btn-primary" PostBackUrl="~/AddWorker.aspx" />
           
        </div>
        <table border="1" style="margin: 2px;">
            <tr class="tableHeader">
                <td>First Name</td>
                <td>Last Name</td>
                <td>VacationLeft</td>
                <td>Hours</td>
            </tr>

            <asp:Repeater ID="Repeater3" runat="server" DataSourceID="getUsers">
                <HeaderTemplate>
                </HeaderTemplate>

                <ItemTemplate>

                    <tr>
                        <td><%# Eval("FirstName") %></td>
                        <td><%# Eval("LastName") %></td>
                        <td><%# Eval("VacationDayLeft") %></td>
                        <td>NULL</td>
                    </tr>

                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="getUsers" runat="server" SelectCommand="SELECT TOP (1000) [id], [title], [Parentid], [Email], [FirstName], [LastName], [VacationDayLeft] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild]"></asp:SqlDataSource>

        </table>
        

    </div>

</asp:Content>