        

$(function () { // document ready
   

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
            $("#saveBtn").click(function () {
                let startDate = $("#startDate").val();
                let endDate = $("#endDate").val();
                let shiftPicker = $("#shiftPicker").val();
                let resourceIdHidden = $("#resourceIdHidden").val();

                let data = JSON.stringify({ "startDate": startDate, "endDate": endDate, "shiftPicker": shiftPicker, "resourceIdHidden": resourceIdHidden });
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
                        $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
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
                    console.log(events, "seba");
                    GenerateCalendar(events, finalResource);
                }, error: function (error) {
                    alert('failed');
                }
            })

           function GenerateCalendar(events, resources) {
               initShift();
                $('#calendar').fullCalendar({
                    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
                    eventDurationEditable: true,
                //    droppable: false,

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
                     //   console.log(resourceObj.id);
                        let clickDate = new Date(date.format());
                        clickDate = (clickDate.getMonth() + 1) + '/' + clickDate.getDate() + '/' + clickDate.getFullYear();

                        $("#startDate").val(date.format());
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



$(document).ready(function () {
    console.log($(".shifts:first"));
    $(".shifts").click(function () {
        console.log($(this));
        current_id_shift = $(this).attr("id");
        console.log(current_id_shift);
        $(".shifts").removeClass("selected-shift");
        $(this).addClass("selected-shift");
        
    });
    console.log($("",".shifts:first"));

});


function insertAjaxEvent() {
    if (confirm("Are you sure you want to insert new shift?")) {
        let startDate = $("#startDate").val();
        let endDate = $("#endDate").val();
        let resourceIdHidden = $("#resourceIdHidden").val();
        let data = JSON.stringify({ "startDate": startDate, "endDate": endDate, "shiftPicker": current_id_shift, "resourceIdHidden": resourceIdHidden });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/PushEvents",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                console.log("mozda smo uspjeli", data);
                let naziv = data.d.Data[1];
                let lastid = data.d.Data[0];
                console.log(data.d);
                $("#modal-view").hide();
                let newEvent = {
                    id: lastid,
                    resourceId: resourceIdHidden,
                    start: moment(startDate),
                    end: moment(endDate),
                    title: naziv
                };
                $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
                console.log(newEvent);
            }, error: function (error) {
                alert('failed');
            },
        })
    }
}

function initShift() {

    $(".shifts:first").click();
   

    } 




       