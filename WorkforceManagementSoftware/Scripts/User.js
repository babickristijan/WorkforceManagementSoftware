var newEvents = [];
var resourcesGlobal = [];
var holidaysGlobal = [];


$(function () { // document ready


    var dt = new Date();
    var currentYear = dt.getFullYear();
    var prevYear = currentYear - 1;
    var nextYear = currentYear + 1;
    var holidays, prevholidays, nextholidays;
    $.ajaxSetup({
        async: false
    });
    $.getJSON("https://www.calendarindex.com/api/v1/holidays?country=HR&year=" + prevYear + "&api_key=1d1410cac562f8bc93f6c1635eb81035a28c946c&fbclid=IwAR0IqOhrobhiGv1cW5eRAIkZaAwnMOy4M-tTMuWQdD0HVbwJxHWFb0YzrTE", function (result) {
        prevholidays = result.response.holidays;
    });
    $.getJSON("https://www.calendarindex.com/api/v1/holidays?country=HR&year=" + currentYear + "&api_key=1d1410cac562f8bc93f6c1635eb81035a28c946c&fbclid=IwAR0IqOhrobhiGv1cW5eRAIkZaAwnMOy4M-tTMuWQdD0HVbwJxHWFb0YzrTE", function (result) {
        holidays = result.response.holidays;
    });
    $.getJSON("https://www.calendarindex.com/api/v1/holidays?country=HR&year=" + nextYear + "&api_key=1d1410cac562f8bc93f6c1635eb81035a28c946c&fbclid=IwAR0IqOhrobhiGv1cW5eRAIkZaAwnMOy4M-tTMuWQdD0HVbwJxHWFb0YzrTE", function (result) {
        nextholidays = result.response.holidays;
    });
    $.ajaxSetup({
        async: true
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
        $('#calendar').fullCalendar({

            schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
            eventDurationEditable: false,
            resourceGroupField: "groupId",
            allDay: true,
            resourceAreaWidth: '250px',
            editable: false,
            eventAfterAllRender: function (view) {
                $(".loader").hide();
            },
            aspectRatio: 1.8,
            scrollTime: '00:00',
            displayEventTime: false,
            eventOverlap: false,
            header: {
                left: 'prev,next',
                center: 'title',
                right: 'timelineMonth'
            },
            defaultView: 'timelineMonth',
            resourceLabelText: 'Workers',
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

        });
    }

});



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



