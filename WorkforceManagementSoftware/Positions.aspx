<%@ Page Title="Pozicije" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Positions.aspx.cs" Inherits="WorkforceManagementSoftware.Positions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet" />
    <link href="Scripts/position.css" rel="stylesheet">
    <script src="Scripts/position.js"></script>
    <h2><%:Title%></h2>
    <div class="wrap-padding" id='wrap'>
        <div id="employee-wrapper">
            <asp:Button ID="addNewPosition" type="button" runat="server" Text="Dodaj poziciju" CssClass="btn btn-primary" PostBackUrl="~/AddPosition.aspx" />

        </div>
        <table border="1" style="margin: 2px;" id="TablePositions">
            <tr class="tableHeader">
                <td>Naziv pozicije</td>
                <td>Izmjeni</td>
                <td>Obriši</td>
            </tr>


            <%foreach (var site in pozicije) { %>
                    
                    <tr id="row<%= site.id %>">
                        <td id="position<%= site.id %>"><%= site.name %></td>
                        <td id="updateCell<%= site.id %>">
                            <i  id="update<%= site.id %>" class="fa fa-pencil-square openUpdatePosition" aria-hidden="true"></i>
                        </td>
                        <td id="deleteCell<%= site.id %>">
                            <i id="delete<%= site.id%>" class="fa fa-trash deletePosition" aria-hidden="true"></i> 
                        </td>
                      
                    </tr>
              <%  } %>
                    




        </table>


    </div>
      <!-- The Modal -->
    <div id="editPositionModal" class="modal-event">

        <!-- Modal content -->
        <div class="modal-content"> 
            <div class="formBlock">
                <span class="close">&times;</span>
            <form>
                  
                <label>Naziv pozicije:</label>
                <input type="hidden" id="position_id" name="position_id"  />
                <input type="text" id="naziv_pozicije" name="naziv_pozicije"  />
                 <button type="button" id="updatePosition">Izmjeni</button>
            </form>
            </div>
            
      
        </div>

    </div>
</asp:Content>
