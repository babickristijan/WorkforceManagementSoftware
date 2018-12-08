<%@ Page Title="Workers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Workers.aspx.cs" Inherits="WorkforceManagementSoftware.Workers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet" />
    <link href="Scripts/Workers.css" rel="stylesheet">
    <script src="Scripts/Workers.js"></script>
    <h2><%:Title%></h2>
    <div class="wrap-padding" id='wrap'>
        <div id="employee-wrapper">
            <asp:Button ID="addANewWorker" runat="server" Text="Add a New Worker" CssClass="btn btn-primary" PostBackUrl="~/AddWorker.aspx" />

        </div>
        <table border="1" style="margin: 2px;" id="TableWorkers">
            <tr class="tableHeader">
                <td>First Name</td>
                <td>Last Name</td>
                <td>Vacation Left</td>
                <td>Hours</td>
                <td>Parent Category</td>
                <td>Agent Title</td>
                <td>Email</td>
                <td>Edit</td>
                <td>Delete</td>
            </tr>


            <%foreach (var site in ListOfWorkers) { %>
                    
                    <tr id="row<%= site.id %>">
                        <td id="FirstName<%= site.id %>"><%= site.FirstName %></td>
                        <td id="LastName<%= site.id %>"><%= site.LastName %></td>
                        <td id="VacationDayLeft<%= site.id %>"><%= site.VacationDayLeft %></td>
                        <td id="hours<%= site.id %>"><%= site.hours %></td>
                        <td id="parentCategory<%= site.id %>"><%= site.ParentId %></td>
                        <td id="position<%= site.id %>"><%= site.position %></td>
                        <td id="email<%= site.id %>"><%= site.Email %></td>
                        <td id="updateCell<%= site.id %>">
                            <i  id="update<%= site.id %>" class="fa fa-pencil-square openUpdateWorker" aria-hidden="true"></i>
                        </td>
                        <td id="deleteCell<%= site.id %>">
                            <i id="delete<%= site.id%>" class="fa fa-trash deleteWorker" aria-hidden="true"></i> 
                        </td>
                      
                    </tr>
              <%  } %>
                    




        </table>


    </div>
      <!-- The Modal -->
    <div id="editWorkerModal" class="modal-event">

        <!-- Modal content -->
        <div class="modal-content"> 
            <div class="formBlock">
                <span class="close">&times;</span>
            <form>
              <label>First Name:</label><input type="text" id="firstname" name="firstname"  /><br />
              <label>Last Name:</label><input type="text" id="lastname" name="lastname"  /><br />
              <label>Vacation days left:</label><input type="number"  id="vacationDayLeft" name="vacationDayLeft"  /><br />
              <label>Parent Category:</label><select id="workerCategory" name="workerCategory">
                    <asp:Repeater ID="editWorker" runat="server" DataSourceID="getWorkerCategory">
                        <ItemTemplate>
                            <option  value='<%# Eval("id") %>'><%# Eval("title") %></option>
                        </ItemTemplate>
                    </asp:Repeater>
                  <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                    ID="getWorkerCategory" runat="server" SelectCommand="SELECT TOP (1000) [id],[title] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesParent]"></asp:SqlDataSource>
                </select><br />
                <label>Worker Position:</label>
                <select id="workerPosition" name="workerPosition">
                    <asp:Repeater ID="editPosition" runat="server" DataSourceID="getPositions">
                        <ItemTemplate>
                            <option  value='<%# Eval("id") %>'><%# Eval("naziv_pozicije") %></option>
                        </ItemTemplate>
                    </asp:Repeater>
                  <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
                ID="getPositions" runat="server" SelectCommand="SELECT TOP (1000) [id],[naziv_pozicije] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Positions]"></asp:SqlDataSource>
                </select> <br />
              <label>Email:</label><input type="email" id="email" name="email"  /><br />
                 <input type="hidden" id="worker_id" name="worker_id"  />
            </form>
            </div>
            <button type="button" id="updateWorker">Izmjeni</button>
      
        </div>

    </div>
</asp:Content>
