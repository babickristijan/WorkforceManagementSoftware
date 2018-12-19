<%@ Page Title="Smjene" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shifts.aspx.cs" Inherits="WorkforceManagementSoftware.Shifts" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet" />
    <link href="Scripts/Shifts.css" rel="stylesheet">
    <link href="Scripts/spectrum.css" rel="stylesheet">
    <script src="Scripts/Shifts.js"></script>
    <script src="Scripts/spectrum.js"></script>
            <h2><%:Title%></h2>
    <div class="wrap-padding" id='wrap'>
        <div id="shift-wrapper">
            <asp:Button ID="addANewShift" runat="server" Text="Dodaj smjenu" CssClass="btn btn-primary" PostBackUrl="~/AddShift.aspx" />
        </div>
        <table border="1" style="margin: 2px;" id="Shifts">
            <tr class="tableHeader">
                <td style="display:none"">id</td>
                <td>Ime smjene</td>
                <td>Boja</td>
                <td>Vrijednost smjene(u satima)</td>
                <td>Godišnji odmor</td>
                <td>Izmjeni</td>
                <td>Obriši</td>
            </tr>


            <%foreach (var site in ListOfShifts) { %>
                    
                    <tr id="row<%= site.id %>">
                      
                        <td id="shift_name<%= site.id %>"><%= site.name %></td>
                        <td class="box-with-color-td" id="shift_color<%= site.id %>"><%= site.color %> <div class="box-with-color" id="shift_color_represent<%= site.id %>"></div>
                        </td>
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
               
               Ime smjene:  <input type="text" id="shift_name" name="shift_name"  />
               Boja: <input type="text" id="shift_color" name="shift_color"  />
                <input type='text' class="basic"/>
               Vrijednost smjene(u satima): <input type="number"  id="shift_value" name="shift_value"  />
                 <input type="hidden" id="shift_id" name="shift_id"  />
             Godišnji? : <input type="checkbox"  id="shift_is_godisnji" name="shift_is_godisnji"  />
            </form>

            <button type="button" id="updateShift">Izmjeni</button>
      
        </div>

    </div>
    <script>
        $(".basic").spectrum({
            color: "#f00",
            change: function(color) {
                $("#shift_color").val(color.toHexString());
            }
        });
    </script>
</asp:Content>
