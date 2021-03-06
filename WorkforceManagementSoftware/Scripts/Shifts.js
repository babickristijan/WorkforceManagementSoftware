﻿$(function () { // document ready
    initColors();
    var modal = document.getElementById('editShiftModal');
    // Get the <span> element that closes the modal
    var closeModal = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    closeModal.onclick = function () {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    $('.openUpdateShift').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("update")[1];

        let data = JSON.stringify({ "id_shift": id });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/GetDataForEditShift",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                let shiftInfo = data.d.Data;
                let id = shiftInfo[0];
                let name = shiftInfo[1];
                let color = shiftInfo[2];
                let value = shiftInfo[3];
                let is_godisnji = shiftInfo[4];
                
                $('#shift_id').val(id);
                $('#shift_name').val(name);
                $('#shift_color').val(color);
                $('#shift_value').val(value);
                if (is_godisnji == 1) {
                    $("#shift_is_godisnji").prop("checked", true);
                } else {
                    $("#shift_is_godisnji").prop("checked", false);
                }
          
                $('#editShiftModal').show();
            }, error: function (error) {
                alert('failed');
            }
        });
    });

    $('#updateShift').on('click', function () {
        let id = $('#shift_id').val();
        let name = $('#shift_name').val();

        let color = $('#shift_color').val();
        let value = $('#shift_value').val();
        let is_godisnji = $('#shift_is_godisnji').prop('checked');
    

        let data = JSON.stringify({
            "id": id, "name": name, "color": color,"value":value, "is_godisnji": is_godisnji
        });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/UpdateShift",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                $('#shift_name' + id).html(name);
                $('#shift_color' + id).html(color + "<div class='box-with-color' style='background-color:" + color+"' id='shift_color_represent"+id+"'></div>"      );
                $('#shift_value' + id).html(value);
                if (is_godisnji == 1) {
                    $("#is_godisnji_odmor"+id).html("DA");
                } else {
                    $("#is_godisnji_odmor" + id).html("NE");
                }
 
                $('#editShiftModal').hide();
            }, error: function (error) {
                alert('failed');
            }
        });
    });
    $('.deleteShift').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("delete")[1];
        if (confirm("Are you sure you want to delete this shift?")) {

            let data = JSON.stringify({ "id": id });
            $.ajax({
                type: "POST",
                url: "Myservice.asmx/DeleteShift",
                contentType: 'application/json; charset=utf-8',
                data: data,
                dataType: "json",
                success: function (data) {
                    $('#row' + id).remove();
                }, error: function (error) {
                    alert('failed');
                }
            });
        }
    });
});

function initColors() {
    $(".box-with-color-td").each(function (index) {
        let color = $(this).text();
        let id = $(this).attr('id');
        id = id.split("shift_color")[1];
        $('#shift_color_represent' + id).css("background-color", color);
    });
    
}