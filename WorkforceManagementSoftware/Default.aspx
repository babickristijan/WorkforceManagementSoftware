<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WorkforceManagementSoftware._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">



    <script type="text/javascript">

        $(function () { // document ready
             $( "#lightboxClose" ).click(function() {
                 $("#modal-view").hide();

            });
            $("#saveBtn").click(function() {
                let startDate = $("#startDate").val();
                let endDate = $("#endDate").val();
                let shiftPicker = $("#shiftPicker").val();
                let resourceIdHidden = $("#resourceIdHidden").val();

                let data = JSON.stringify({ "startDate": startDate,"endDate":endDate,"shiftPicker":shiftPicker,"resourceIdHidden":resourceIdHidden });
                $.ajax({
                type: "POST",
                url: "Myservice.asmx/PushEvents",
                    contentType: 'application/json; charset=utf-8',
                    data: data,
                    dataType: "json",
                    success: function (data) {
                        let lastid = data.d;
                        console.log(data.d);
                    $("#modal-view").hide();
                    let newEvent = {
                        id: lastid,
                        resourceId: resourceIdHidden,
                        start: moment(startDate),
                        end: moment(endDate),
                        title: shiftPicker
                    };
                    $('#calendar').fullCalendar( 'renderEvent', newEvent , 'stick');
                    console.log(newEvent);
                }, error: function (error) {
                    alert('failed');
                },
            })
            


            }); 
            var events = [];
            var resources = [];
            var parents = [];
            var finalResource = [];
            $.ajax({
                type: "POST",
                url: "Myservice.asmx/GetEvents",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (data) {
                    parents = data.d.Data[2][0];
                    resources = data.d.Data[1][0];
                    for (var i = 0; i < parents.length; i++) {
                        var tempObject = { id: parents[i].id, title: parents[i].title };
                        console.log("tempObject", tempObject);
                        var tempChildren = [];
                        for (var j = 0; j < resources.length; j++) {
                            if (resources[j].parentid == parents[i].id) {
                                var tempObjectChildren = { id: resources[j].id, title: resources[j].title };
                                tempChildren.push(tempObjectChildren);
                            }
                        }
                        tempObject.children = tempChildren;
                        finalResource.push(tempObject);
                    }

                    $.each(data.d.Data[0][0], function (i, v) {
                        events.push({
                            id: v.ID,
                            resourceId: v.ResourceId,
                            start: moment(v.Start),
                            end: v.End != null ? moment(v.End) : null,
                            title: v.Title
                        });


                    })
                    console.log(events,"seba");
                    GenerateCalendar(events, finalResource);
                }, error: function (error) {
                    alert('failed');
                }
            })

            $('#external-events .fc-event').each(function () {

                // store data so the calendar knows to render an event upon drop
                $(this).data('event', {
                    id: $(this)[0].id,
                    title: $.trim($(this).text()), // use the element's text as the event title
                    stick: true // maintain when user navigates (see docs on the renderEvent method)
                });

                // make the event draggable using jQuery UI
                $(this).draggable({
                    zIndex: 999,
                    revert: true,      // will cause the event to go back to its
                    revertDuration: 0  //  original position after the drag
                });



            });



            function GenerateCalendar(events, resources) {
                $('#calendar').fullCalendar({
                    editable: true,
                    droppable: true,
                    aspectRatio: 1.8,
                    scrollTime: '00:00',
                    displayEventTime: false,
                    dayClick: function (date, jsEvent, view, resourceObj) {
                        alert(date.format());
                        $("#modal-view").show();
                        console.log(resourceObj.id);
                        let clickDate = new Date(date.format());
                        clickDate=(clickDate.getMonth() + 1) + '/' + clickDate.getDate() + '/' +  clickDate.getFullYear();
                        
                        $("#startDate").val(date.format());
                        $("#resourceIdHidden").val(resourceObj.id);

                        

                    },
                    header: {
                        left: 'promptResource prev,next',
                        center: 'title',
                        right: 'timelineMonth,timelineYear'
                    },
                    customButtons: {
                        promptResource: {
                            text: '+ room',
                            click: function () {
                                var title = prompt('Workers');
                                if (title) {
                                    $('#calendar').fullCalendar(
                                        'addResource',
                                        { title: title },
                                        true // scroll to the new resource?
                                    );
                                }
                            }
                        }
                    },
                    defaultView: 'timelineMonth',
                    views: {
                        timelineThreeDays: {
                            type: 'timeline',
                            duration: { days: 3 }
                        }
                    },
                    resourceLabelText: 'Workers',
                    resourceRender: function (resource, cellEls) {
                        cellEls.on('click', function () {
                            if (confirm('Are you sure you want to delete ' + resource.title + '?')) {
                                $('#calendar').fullCalendar('removeResource', resource);
                            }
                        });
                    },
                    resources: finalResource,
                    events: events,
                    eventReceive: function(event) {
                        console.log("sebosebo", event);
                        var startDate = event.start._d;
                        startDate = startDate.toISOString().slice(0, 10);
                        var resourceId = event.resourceId;
                        var idsmjene = event.id;

                        let data = JSON.stringify({ "startDate": startDate, "endDate": startDate, "shiftPicker": idsmjene, "resourceIdHidden": resourceId });
                        $.ajax({
                            type: "POST",
                            url: "Myservice.asmx/PushEvents",
                            contentType: 'application/json; charset=utf-8',
                            data: data,
                            dataType: "json",
                            success: function (data) {
                           /*     let lastid = data.d;
                                console.log(data.d);
                                $("#modal-view").hide();
                                let newEvent = {
                                    id: lastid,
                                    resourceId: resourceIdHidden,
                                    start: moment(startDate),
                                    end: moment(endDate),
                                    title: shiftPicker
                                };
                                $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
                                console.log(newEvent); */
                            }, error: function (error) {
                                alert('failed');
                            },
                        })
                       
                    }
                });
            }

        });
        
       

    </script> 

    <style>

  body {
    margin-top: 40px;
    text-align: center;
    font-size: 14px;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
  }
    
  #wrap {
    width: 1100px;
    margin: 0 auto;
  }
    
  #external-events {
    float: left;
    width: 150px;
    padding: 0 10px;
    border: 1px solid #ccc;
    background: #eee;
    text-align: left;
  }
    
  #external-events h4 {
    font-size: 16px;
    margin-top: 0;
    padding-top: 1em;
  }
    
  #external-events .fc-event {
    margin: 10px 0;
    cursor: pointer;
  }
    
  #external-events p {
    margin: 1.5em 0;
    font-size: 11px;
    color: #666;
  }
    
  #external-events p input {
    margin: 0;
    vertical-align: middle;
  }

  #calendar {
    float: right;
    width: 900px;
  }

</style>


        <div style="padding-top:80px;" id='wrap'>

    <div id='external-events'>
      <h4>Draggable Events</h4>
         <asp:Repeater ID="Repeater1" runat="server" DataSourceID="myConnectionString">
            <ItemTemplate>
            <div class='fc-event' id='<%# Eval("id") %>'><%# Eval("naziv") %></div>  
                </ItemTemplate>
            </asp:Repeater>
          <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:myConnectionString %>"
        ID="myConnectionString" runat="server" SelectCommand="SELECT TOP (1000) [id] ,[naziv] ,[color] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene]"></asp:SqlDataSource>
      <p>
        <input type='checkbox' id='drop-remove' />
        <label for='drop-remove'>remove after drop</label>
      </p>
    </div>

    <div id='calendar'></div>

    <div style='clear:both'></div>

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
