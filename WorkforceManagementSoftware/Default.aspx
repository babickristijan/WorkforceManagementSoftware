<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WorkforceManagementSoftware._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">



    <script type="text/javascript">

      $(function () { // document ready

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
                for (var i=0; i<parents.length;i++){
                    var tempObject = {id: parents[i].id, title:parents[i].title};
                    console.log("tempObject",tempObject);
                    var tempChildren = [];
                    for (var j=0; j<resources.length;j++){
                        if(resources[j].parentid == parents[i].id) {
                            var tempObjectChildren = {id: resources[j].id, title: resources[j].title};
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
                 GenerateCalendar(events,finalResource);
             }, error: function (error) {
                 alert('failed');
             }
         })

         $('#external-events .fc-event').each(function () {

             // store data so the calendar knows to render an event upon drop
             $(this).data('event', {
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



         function GenerateCalendar(events,resources) {
             $('#calendar').fullCalendar({
                 editable: true,
                 droppable: true,
                 aspectRatio: 1.8,
                 scrollTime: '00:00',
                 displayEventTime: false,
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
                 defaultView: 'timelineDay',
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
                 events: events
             });
         }

     });

 </script> 

    <div id='calendar'></div>
   
</asp:Content>
