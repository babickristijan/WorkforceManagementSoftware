$(function () { // document ready

   
    var modal = document.getElementById('editPositionModal');
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
    $('.openUpdatePosition').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("update")[1];
        $("#position_id").val(id);
        $('#editPositionModal').show();
    });

    $('#updatePosition').on('click', function () {
        let id = $("#position_id").val();
        let naziv_pozicije = $("#naziv_pozicije").val();
        let data = JSON.stringify({
            "id": id,
            "naziv_pozicije": naziv_pozicije
        });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/UpdatePosition",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                $('#position' + id).html(naziv_pozicije);
                $('#editPositionModal').hide();
            }, error: function (error) {
                alert('failed');
            }
        });
    });
    $('.deletePosition').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("delete")[1];
        

            let data = JSON.stringify({ "id": id });
            $.ajax({
                type: "POST",
                url: "Myservice.asmx/DeletePosition",
                contentType: 'application/json; charset=utf-8',
                data: data,
                dataType: "json",
                success: function (data) {
                    $('#row' + id).remove();
                }, error: function (error) {
                    alert('failed');
                }
            });
        
    });
});