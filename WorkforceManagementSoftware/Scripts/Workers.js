$(function () { // document ready
    var modal = document.getElementById('editWorkerModal');
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
    $('.openUpdateWorker').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("update")[1];
        console.log(id);
   
        let data = JSON.stringify({ "id_worker": id });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/GetDataForEditWorker",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                console.log(data.d.Data);
                let workerInfo = data.d.Data;
                let id = workerInfo[0];
                let title = workerInfo[1];
                let parent_id = workerInfo[2];
                let email = workerInfo[3];
                let first_name = workerInfo[4];
                let last_name = workerInfo[5];
                let vacation_left = workerInfo[6];
                $('#worker_id').val(id);
                $('#firstname').val(first_name);
                $('#lastname').val(last_name);
                $('#vacationDayLeft').val(vacation_left);
                $("#workerCategory").val(parent_id);
                $('#agentTitle').val(title);
                $('#email').val(email);

                $('#editWorkerModal').show();
            }, error: function (error) {
                alert('failed');
            }
        });
    });

    $('#updateWorker').on('click', function () {
        let id = $('#worker_id').val();
        console.log(id);
        let firstname = $('#firstname').val();
        
        let lastname =$('#lastname').val();
        let vacationDayLeft =$('#vacationDayLeft').val();
        let workerCategory =$("#workerCategory").val();
        let agentTitle =$('#agentTitle').val();
        let email = $('#email').val();
        let parent_text = $("#workerCategory option:selected").text();

        let data = JSON.stringify({
            "id": id, "firstname": firstname, "lastname": lastname, "vacationDayLeft": vacationDayLeft,
            "workerCategory": workerCategory, "agentTitle": agentTitle, "email": email
        });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/UpdateWorker",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) { 
                console.log(data);
                $('#FirstName' + id).html(firstname);
                $('#LastName' + id).html(lastname);
                $('#VacationDayLeft' + id).html(vacationDayLeft);
                $('#parentCategory' + id).html(parent_text);
                $('#title' + id).html(agentTitle);
                $('#email' + id).html(email);
                $('#editWorkerModal').hide();   
            }, error: function (error) {
                alert('failed');
            }
        });
    });
    $('.deleteWorker').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("delete")[1];
        console.log(id);
        if (confirm("Are you sure you want to delete this worker?")) {
           
            let data = JSON.stringify({ "id": id });
            $.ajax({
                type: "POST",
                url: "Myservice.asmx/DeleteWorker",
                contentType: 'application/json; charset=utf-8',
                data: data,
                dataType: "json",
                success: function (data) {
                    console.log("data", data);
                    $('#row' + id).remove();
                }, error: function (error) {
                    alert('failed');
                }
            });
        }
    });
});