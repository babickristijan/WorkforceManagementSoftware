<%@ Page Title="AddWorker" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddWorker.aspx.cs" Inherits="WorkforceManagementSoftware.AddWorker" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    

            
<%-- First name: <input type="text" name="firstname"><br />--%>
      FirstName: <asp:TextBox id="firstname" runat="server" ></asp:TextBox>
        Lastname: <asp:TextBox id="lastname" runat="server"></asp:TextBox>
        Email: <asp:TextBox id="email" runat="server" TextMode="Email"></asp:TextBox>
        <asp:DropDownList runat="server" ID="parentID" DataTextField="title" DataValueField="id" DataSourceID="getParent">
    </asp:DropDownList>
        Pozicija agenta: <asp:TextBox id="agenttitle" runat="server" placeholder="npr: L1 agent,L2 Senior"></asp:TextBox>
        Broj godišnjeg odmora: <asp:TextBox id="vacationdayleft" runat="server" type="number" placeholder="unesite broj godišnjih dana"></asp:TextBox>
   <asp:Button id="submitButton" runat="server"  OnClick="SubmitForm" />
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
    
    

    </asp:Content>

    