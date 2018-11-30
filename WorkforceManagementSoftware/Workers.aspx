<%@ Page Title="Workers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Workers.aspx.cs" Inherits="WorkforceManagementSoftware.Workers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/Workers.css" rel="stylesheet">
    <h2><%:Title%></h2>
    <div class="wrap-padding" id='wrap'>
        <div id="employee-wrapper">
            <asp:Button ID="addANewWorker" runat="server" Text="Add a New Worker" CssClass="btn btn-primary" PostBackUrl="~/AddWorker.aspx" />

        </div>
        <table border="1" style="margin: 2px;" id="TableWorkers">
            <tr class="tableHeader">
                <td>First Name</td>
                <td>Last Name</td>
                <td>VacationLeft</td>
                <td>Hours</td>
            </tr>


            <%foreach (var site in ListOfWorkers) { %>
                
                    <tr>
                        <td><%= site.FirstName %></td>
                        <td><%= site.LastName %></td>
                        <td><%= site.VacationDayLeft %></td>
                        <td><%= site.hours %></td>
                      
                    </tr>
              <%  } %>
                    




          <%--  <asp:Repeater ID="outer" runat="server" >
                <HeaderTemplate>
                </HeaderTemplate>
                
                <ItemTemplate>
                    <asp:Repeater runat="server" ID="inner" DataSourceID="GetSumOfHour">
                        <ItemTemplate>
                    <tr>
                        <td><%# Eval("FirstName") %></td>
                        <td><%# Eval("LastName") %></td>
                        <td><%# Eval("VacationDayLeft") %></td>
                        <td><%# Eval("hours") %></td>
                      
                    </tr>
                       </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
                    
            </asp:Repeater>--%>
      <%--      <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="getUsers" runat="server" SelectCommand="SELECT TOP (1000) [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild].[id], [title], [Parentid], [Email], [FirstName], [LastName], [VacationDayLeft], [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events].[ID],[ResourceId],[Start],[End],[id_smjene],[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene].[id],[naziv],[SmjenaSati], DATEDIFF(day,[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events].[Start], [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events].[End]) * SmjenaSati as Suma 
FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild] JOIN[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events] 
ON ResourcesChild.id = Events.ResourceId JOIN[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene] 
ON Events.id_smjene = Smjene.id ORDER BY ResourcesChild.id"></asp:SqlDataSource>--%>

        </table>


    </div>

</asp:Content>
