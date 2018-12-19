var newEvents = [];
var resourcesGlobal = [];
var holidaysGlobal = [];
var holidaysGlobalPrev = [];
var holidaysGlobalNext = [];


$(function () { // document ready
    
    
    var dt = new Date();
    
        var currentYear = dt.getFullYear();
        var prevYear = currentYear - 1;
        var nextYear = currentYear + 1;
        var holidays,prevholidays,nextholidays;
        $.ajaxSetup({
            async: false
        });
        $.getJSON("https://www.calendarindex.com/api/v1/holidays?country=HR&year=" + prevYear + "&api_key=1d1410cac562f8bc93f6c1635eb81035a28c946c&fbclid=IwAR0IqOhrobhiGv1cW5eRAIkZaAwnMOy4M-tTMuWQdD0HVbwJxHWFb0YzrTE", function (result) {
            prevholidays = result.response.holidays;
        });
        $.getJSON("https://www.calendarindex.com/api/v1/holidays?country=HR&year="+currentYear+"&api_key=1d1410cac562f8bc93f6c1635eb81035a28c946c&fbclid=IwAR0IqOhrobhiGv1cW5eRAIkZaAwnMOy4M-tTMuWQdD0HVbwJxHWFb0YzrTE", function (result) {
            holidays = result.response.holidays;
         });
         $.getJSON("https://www.calendarindex.com/api/v1/holidays?country=HR&year=" + nextYear + "&api_key=1d1410cac562f8bc93f6c1635eb81035a28c946c&fbclid=IwAR0IqOhrobhiGv1cW5eRAIkZaAwnMOy4M-tTMuWQdD0HVbwJxHWFb0YzrTE", function (result) {
             nextholidays = result.response.holidays;
         });
        $.ajaxSetup({
            async: true
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
             var current_color;
            var current_godisnji;

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
                                var tempObjectChildren = { id: resources[j].id, title: resources[j].firstname + " " + resources[j].lastname + " (" + resources[j].title + ")", groupId: parents[i].title };
                                tempChildren.push(tempObjectChildren);
                                finalResource.push(tempObjectChildren);
                            }
                        }
                        //tempObject.children = tempChildren;
                        //finalResource.push(tempObject);
                    }
                    
                    $.each(data.d.Data[0][0], function (i, v) {

                        let resizeableOption = true;
                        if (v.godisnji == "1") {
                            resizeableOption = false;
                        }
                        events.push({
                            id: v.ID,
                            resourceId: v.ResourceId,
                            start: moment(v.Start),
                            end: v.End != null ? moment(v.End) : null,
                            title: v.Title,
                            color: v.color,
                            godisnji: v.godisnji,
                            durationEditable: resizeableOption,
                            allDay: true

                        });
                        
                       

                    });
                    resourcesGlobal = resources;
                    holidaysGlobalPrev = prevholidays;
                    holidaysGlobal = holidays;
                    holidaysGlobalNext = nextholidays;
                    
                   
                    GenerateCalendar(events, finalResource);
                    addfuckingevents();
                }, error: function (error) {
                    console.log('failed');
                }
            })

           function GenerateCalendar(events, resources) {
               initShift();
               $('#calendar').fullCalendar({
                   
                    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
                    eventDurationEditable: true,
                    resourceGroupField: "groupId",
                    allDay: true,
                    resourceAreaWidth:'250px',
                    aspectRatio: 1.8,
                   eventAfterAllRender: function (view) {
                       $(".loader").hide();
                   },
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
                        $("#godisnji_modal").val(calEvent.godisnji);
                        $("#resource_id_godisnji").val(calEvent.resourceId);
                        let godisnji = calEvent.godisnji;
               
                        if (godisnji == "1") {
                            $("#smjeneModal").hide();
                            $("#izmjeniModal").hide();
                        } else {
                            $("#smjeneModal").show();
                            $("#izmjeniModal").show();
                        }

                        // change the border color just for fun
                        $(this).css('border-color', 'red');
                        

                    },
                    eventOverlap: false,
                    dayClick: function (date, jsEvent, view, resourceObj) {
                      //  console.log(date.format());
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
                        right: 'timelineMonth'
                    },
                    defaultView: 'timelineMonth',
                    resourceLabelText: 'Radnici',
                    locale: 'hr',
                    slotLabelFormat: [
                        'MMMM YYYY', // top level of text
                        'ddd D '        // lower level of text
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
                                console.log('failed');
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
            console.log('failed');
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
                
                let test = $("#smjeneModal").val();
                var classList = $("#" + test).attr('class').split(/\s+/);
                let color;
                $.each(classList, function (index, item) {
                    if (item.indexOf("color-") >= 0) {
                       color = item.split("color-")[1];
                       

                    }


                });

                evento[0].color = color ;
                $('#calendar').fullCalendar('updateEvent', evento[0]);
                modal.style.display = "none";
                
            },
            error: function (error) {
                console.log('failed');
            },
        })
    }
}

function deleteEvent(idEventa, modal) {
    if (confirm("Are you sure?")) {
        let deletegodisnji = $("#godisnji_modal").val();
        let resource_id_godisnji = $("#resource_id_godisnji").val();
        let data = JSON.stringify({ "idEventa": idEventa, "godisnji": deletegodisnji, "resource_id_godisnji": resource_id_godisnji});
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
                console.log('failed');
            },
        })
    }
}



$(document).ready(function () {
    $(".shifts").click(function () {

        current_id_shift = $(this).attr("id");
        let godisnji = "is_godisnji" + current_id_shift;
        let godisnji_value = $("#" + godisnji).html();
        current_godisnji = godisnji_value;
        $(".selected-shift").css("background-color","unset");
        $(".shifts").removeClass("selected-shift");
       
        $(this).addClass("selected-shift");
        var classList = $(this).attr('class').split(/\s+/);
        $.each(classList, function (index, item) {
            if (item.indexOf("color-") >= 0) {
                let color = item.split("color-")[1];
                current_color = color;
               
            }
               
            
        });
        $(this).css("background-color", current_color);
        
        
    });



});


function insertAjaxEvent() {
    if (confirm("Are you sure you want to insert new shift?")) {
        
        let startDate = $("#startDate").val();
        let endDate = $("#endDate").val();
        let resourceIdHidden = $("#resourceIdHidden").val();
        let resizeableOption = true;
        if (current_godisnji == "1") {
            resizeableOption = false;
        }
        let data = JSON.stringify({ "startDate": startDate, "endDate": endDate, "shiftPicker": current_id_shift, "resourceIdHidden": resourceIdHidden, "godisnji": current_godisnji });
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
                    title: naziv,
                    color: current_color,
                    resourceEditable: false, 
                    godisnji: current_godisnji,
                    durationEditable: resizeableOption,
                    allDay: true

                };
                $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
            }, error: function (error) {
                console.log('failed');
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

        for (let j = 0; j < holidaysGlobalPrev.length; j++) {
            let currentHoliday = holidaysGlobalPrev[j];

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
                color: 'rgba(255,0,0,0.3)',
                allDay: true

            });

        }
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
                color: 'rgba(255,0,0,0.3)',
                allDay: true

            });
        }
        for (let j = 0; j < holidaysGlobalNext.length; j++) {
            let currentHoliday = holidaysGlobalNext[j];

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
                color: 'rgba(255,0,0,0.3)',
                allDay: true

            });
        }
    }
    $('#calendar').fullCalendar('renderEvents', newEvents, 'stick');
}



       