<%@ Page Title="AddWorker" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddWorker.aspx.cs" Inherits="WorkforceManagementSoftware.AddWorker" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--#include file="~/loader.html" -->
   

 <link rel="stylesheet" type="text/css" href="Scripts/addWorker.css">
<%-- First name: <input type="text" name="firstname"><br />--%>
    
    <table>
        <tr>
            <td align="center" colspan="2">
                <h1>Dodavanje radnika</h1>
            </td>
        </tr>
        <tr>
            <td align="left">
        Ime: 
             </td>
            <td>
                <asp:TextBox id="firstname" runat="server" CssClass="textBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left">
        Prezime:
            </td>
            <td>
                <asp:TextBox id="lastname" runat="server" CssClass="textBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left">
        E-pošta:
            </td>
            <td>
                <asp:TextBox id="email" runat="server" TextMode="Email" placeholder="user@example.com" CssClass="textBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left">
                Kategorija:
            </td>
            <td>
        <asp:DropDownList runat="server" ID="parentID" DataTextField="title" DataValueField="id" DataSourceID="getParent" CssClass="dropDown"></asp:DropDownList>
             </td>
        </tr>
        <tr>
            <td align="left">
        Pozicija:
             </td>
            <td>
                <asp:DropDownList runat="server" ID="positionID" DataTextField="naziv_pozicije" DataValueField="id" DataSourceID="getPositions" CssClass="dropDown"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="left">
        Preostalo godišnjeg:
             </td>
            <td>
                <asp:TextBox id="vacationdayleft" runat="server" type="number" placeholder="0" CssClass="textBox"></asp:TextBox>
            </td>
        </tr>
        <tr>

            <td align="center" colspan="2">
                <asp:Button id="submitButton" runat="server"  OnClick="SubmitForm" Text="Spremi" CssClass="submitBtn" />
             </td>
        </tr>
   </table>

 
 <%--Last name: <input type="text" name="lastname"><br />
 Email : <input type="email" name="email"><br />
            <select name="parentId">
<asp:Repeater ID="Repeater1" runat="server" DataSourceID="getParent">
                <ItemTemplate>
                    <option  value='<%# Eval("id") %>'><%# Eval("title") %></option>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="getParent" runat="server" SelectCommand="SELECT TOP (1000) [id],[title] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesParent]"></asp:SqlDataSource>
</select><br />
Pozicija agenta: <input type="text" name="title" placeholder="npr: L1 Agent, L2 Senior"><br />
          <input type="submit" value="Pošalji">--%>
    <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="getParent" runat="server" SelectCommand="SELECT TOP (1000) [id],[title] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesParent]"></asp:SqlDataSource>
     <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="getPositions" runat="server" SelectCommand="SELECT TOP (1000) [id],[naziv_pozicije] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Positions]"></asp:SqlDataSource>

    
                   
    </asp:Content>

    