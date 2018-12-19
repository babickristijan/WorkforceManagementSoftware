<%@ Page Title="Kategorije" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="WorkforceManagementSoftware.Categories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!--#include file="~/loader.html" -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet" />
    <link href="Scripts/Categories.css" rel="stylesheet">
    <script src="Scripts/Categories.js"></script>
        
    <div class="wrap-padding" id='wrap'>
        <h2><%:Title%></h2>
        <div id="employee-wrapper">
            <asp:Button ID="addANewWorker" runat="server" Text="Dodaj kategoriju" CssClass="btn btn-primary" PostBackUrl="~/AddCategories.aspx" />

        </div>
        <table border="1" style="margin: 2px;" id="TableWorkers">
            <tr class="tableHeader">
                <td>Naziv</td>
                <td>Izmjeni</td>
                <td>Obriši</td>
            </tr>


            <%foreach (var site in categorie) { %>
                    
                    <tr id="row<%= site.id %>">
                        <td id="parentCategory<%= site.id %>"><%= site.name %></td>
                        <td id="updateCell<%= site.id %>">
                            <i  id="update<%= site.id %>" class="fa fa-pencil-square openUpdateCategorie" aria-hidden="true"></i>
                        </td>
                        <td id="deleteCell<%= site.id %>">
                            <i id="delete<%= site.id%>" class="fa fa-trash deleteCategorie" aria-hidden="true"></i> 
                        </td>
                      
                    </tr>
              <%  } %>
                    




        </table>


    </div>
      <!-- The Modal -->
    <div id="editCategorieModal" class="modal-event">

        <!-- Modal content -->
        <div class="modal-content"> 
            <div class="formBlock">
                <span class="close">&times;</span>
            <form>
                <input type="hidden" id="categorie_id" name="categorie_id"  />
              <label>Naziv:</label><input type="text" id="categorie_name" name="categorie_name"  /><br />
            </form>
            </div>
            <button type="button" id="updateCategorie">Izmjeni</button>
      
        </div>

    </div>
</asp:Content>
