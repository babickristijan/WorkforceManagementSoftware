var newEvents = [];
var resourcesGlobal = [];
var holidaysGlobal = [];


$(function () { // document ready
    
    
        var dt = new Date();
        var currentYear = dt.getFullYear();
        var holidays;
        $.getJSON("https://www.calendarindex.com/api/v1/holidays?country=HR&year="+currentYear+"&api_key=1d1410cac562f8bc93f6c1635eb81035a28c946c&fbclid=IwAR0IqOhrobhiGv1cW5eRAIkZaAwnMOy4M-tTMuWQdD0HVbwJxHWFb0YzrTE", function (result) {
                holidays = result.response.holidays;
         });
        var globalEventId;
        var modal = document.getElementById('eventModal');
        // Get the <span> element that closes the modal
        var closeModal= document.getElementsByClassName("close")[0];
        
        // When the user clicks on <span> (x), close the modal
        closeModal.onclick = function() {
                    modal.style.display = "none";
                }
                
                // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
        if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
   
            var current_id_shift;
            $("#lightboxClose").click(function () {
                $("#modal-view").hide();

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

                       

                    });
                    resourcesGlobal = resources;
                    holidaysGlobal = holidays;
                    
                   
                    GenerateCalendar(events, finalResource);
                    addfuckingevents();
                }, error: function (error) {
                    alert('failed');
                }
            })

           function GenerateCalendar(events, resources) {
               initShift();
               $('#calendar').fullCalendar({
                   
                    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
                    eventDurationEditable: true,
                    
                    allDay: true,
                    aspectRatio: 1.8,
                    scrollTime: '00:00',
                    displayEventTime: false,
                    //eventDrop: function (event, delta, revertFunc) {

                    //    updateAjaxEvent(event, revertFunc);

                    //},
                    
                    eventResize: function (event, delta, revertFunc) {

                        updateAjaxEvent(event, revertFunc);

                    },
                    eventClick: function (calEvent, jsEvent, view) {

                        //ovdje treba napraviti modal za update eventa i dellete

                        modal.style.display = "block";
                        globalEventId = calEvent.id;
                        
                        //alert('Event: ' + calEvent.title);
                        //alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
                        //alert('View: ' + view.name);

                        // change the border color just for fun
                        $(this).css('border-color', 'red');
                        

                    },
                    eventOverlap: false,
                    dayClick: function (date, jsEvent, view, resourceObj) {
                      //  alert(date.format());
                     //   $("#modal-view").show();
                        let clickDate = new Date(date.format());
                        clickDate = (clickDate.getMonth() + 1) + '/' + clickDate.getDate() + '/' + clickDate.getFullYear();

                        $("#startDate").val(date.format());
                        $("#endDate").val(date.format());
                        $("#resourceIdHidden").val(resourceObj.id);
                        insertAjaxEvent();
                        

                    },
                    header: {
                        left: 'prev,next',
                        center: 'title',
                        right: 'timelineMonth,timelineYear'
                    },
                    defaultView: 'timelineMonth',
                    resourceLabelText: 'Workers',
                    locale: 'hr',
                    slotLabelFormat: [
                        'MMMM YYYY', // top level of text
                        'dddd'        // lower level of text
                    ],
                    resources: finalResource,
                   events: events,
                   eventRender: function (event, element) {
                       if (event.rendering == 'background') {
                           element.append(event.title);
                       }
                   },
                    eventReceive: function (event) {
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
                            }, error: function (error) {
                                alert('failed');
                            },
                        })

                    }
                });
    }
    //button za update smjena
    $("#izmjeniModal").on("click", function () {
        var smjenaUpdate = $("#smjeneModal").val();
        var title = $("#smjeneModal option[value=" + smjenaUpdate + "]").text();
        updateShift(smjenaUpdate, globalEventId, title,modal);
    }); 

    $("#deleteModal").on("click", function () {
        var smjenaUpdate = $("#smjeneModal").val();
        deleteEvent(globalEventId,modal);

    }); 

    

});




function updateAjaxEvent(event, revertFunc) {
    var startDate = event.start._d;
    startDate = startDate.toISOString().slice(0, 10);
    
    var resourceId = event.resourceId;
    var idsmjene = event.id;
    var endDate = event.end._d;
    endDate = endDate.toISOString().slice(0, 10);
    let data = JSON.stringify({ "startDate": startDate, "endDate": endDate, "shiftPicker": idsmjene, "resourceIdHidden": resourceId });
    if (!confirm("Are you sure about this change?")) {
        revertFunc();
    }
    $.ajax({
        type: "POST",
        url: "Myservice.asmx/UpdateEvents",
        contentType: 'application/json; charset=utf-8',
        data: data,
        dataType: "json",
        success: function (data) {

        }, error: function (error) {
            alert('failed');
        },
    })
    
}

function updateShift(idSmjene, idEventa, title, modal) {
    
    if (confirm("Are you sure?")) {
        let data = JSON.stringify({
            "idSmjene": idSmjene,
            "idEventa": idEventa
        });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/UpdateShifts",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                var evento = $("#calendar").fullCalendar('clientEvents', idEventa);
                evento[0].title = title;
                $('#calendar').fullCalendar('updateEvent', evento[0]);
                modal.style.display = "none";
            },
            error: function (error) {
                alert('failed');
            },
        })
    }
}

function deleteEvent(idEventa, modal) {
    if (confirm("Are you sure?")) {
        let data = JSON.stringify({
            "idEventa": idEventa
        });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/DeleteEvent",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                var evento = $("#calendar").fullCalendar('removeEvents', [idEventa]);
                modal.style.display = "none";
            },
            error: function (error) {
                alert('failed');
            },
        })
    }
}



$(document).ready(function () {
    $(".shifts").click(function () {
        current_id_shift = $(this).attr("id");
        $(".shifts").removeClass("selected-shift");
        $(this).addClass("selected-shift");
        
    });



});


function insertAjaxEvent() {
    if (confirm("Are you sure you want to insert new shift?")) {
        let startDate = $("#startDate").val();
        let endDate = $("#endDate").val();
        console.log("seba", endDate);
        let resourceIdHidden = $("#resourceIdHidden").val();
        let data = JSON.stringify({ "startDate": startDate, "endDate": endDate, "shiftPicker": current_id_shift, "resourceIdHidden": resourceIdHidden });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/PushEvents",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                let naziv = data.d.Data[1];
                let lastid = data.d.Data[0];
                $("#modal-view").hide();
                let newEvent = {
                    id: lastid,
                    resourceId: resourceIdHidden,
                    start: moment(startDate),
                    end: moment(endDate),
                    title: naziv
                };
                $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
            }, error: function (error) {
                alert('failed');
            },
        })
    }
    }

function initShift() {

    $(".shifts:first").click();
   

} 




function addfuckingevents() {
    for (let i = 0; i < resourcesGlobal.length; i++) {

        let currentResourceId = resourcesGlobal[i].id;
        for (let j = 0; j < holidaysGlobal.length; j++) {
            let currentHoliday = holidaysGlobal[j];

            let split1 = currentHoliday.date.split(" ")[0];
            let split2 = split1.split("-");
            
            let date = split2[1] + " " + split2[2] + " " + split2[0];
            
            newEvents.push({
                id: "holiday2" + i + j,
                resourceId: currentResourceId,
                start: date,
                end: date,
                title: currentHoliday.name,
                rendering: 'background',
                color: 'rgba(255,0,0,0.3)'
            });
           


        }

    }
    $('#calendar').fullCalendar('renderEvents', newEvents, 'stick');
}



       