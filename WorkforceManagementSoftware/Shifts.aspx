<%@ Page Title="Shifts" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shifts.aspx.cs" Inherits="WorkforceManagementSoftware.Shifts" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet" />
    <link href="Scripts/Shifts.css" rel="stylesheet">
    <script src="Scripts/Shifts.js"></script>
  
    <div class="wrap-padding" id='wrap'>
     <%--   <div id="employee-wrapper">
            <asp:Button ID="addANewWorker" runat="server" Text="Add a New Worker" CssClass="btn btn-primary" PostBackUrl="~/AddWorker.aspx" />
        </div>--%>
        <table border="1" style="margin: 2px;" id="Shifts">
            <tr class="tableHeader">
                <td style="display:none"">id</td>
                <td>name</td>
                <td>color</td>
                <td>shift value</td>
                <td>godisnji odmor</td>
                <td>Edit</td>
                <td>Delete</td>
            </tr>


            <%foreach (var site in ListOfShifts) { %>
                    
                    <tr id="row<%= site.id %>">
                      
                        <td id="shift_name<%= site.id %>"><%= site.name %></td>
                        <td id="shift_color<%= site.id %>"><%= site.color %></td>
                        <td id="shift_value<%= site.id %>"><%= site.shift_value %></td>
                        <td id="is_godisnji_odmor<%= site.id %>"><%= site.is_godisnji_odmor %></td>
                        <td id="updateCell<%= site.id %>">
                            <i  id="update<%= site.id %>" class="fa fa-pencil-square openUpdateShift" aria-hidden="true"></i>
                        </td>
                        <td id="deleteCell<%= site.id %>">
                            <i id="delete<%= site.id%>" class="fa fa-trash deleteShift" aria-hidden="true"></i> 
                        </td>
                      
                    </tr>
              <%  } %>
                    
        </table>


    </div>
      <!-- The Modal -->
    <div id="editShiftModal" class="modal-event">

        <!-- Modal content -->
        <div class="modal-content">
            <span class="close">&times;</span>
            <form>
               
               name:  <input type="text" id="shift_name" name="shift_name"  />
               color: <input type="text" id="shift_color" name="shift_color"  />
               Shift value(in hours): <input type="number"  id="shift_value" name="shift_value"  />
                 <input type="hidden" id="shift_id" name="shift_id"  />
            </form>

            <button type="button" id="updateShift">Izmjeni</button>
      
        </div>

    </div>
</asp:Content>
