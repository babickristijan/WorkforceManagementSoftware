$(function () { // document ready


    var modal = document.getElementById('editCategorieModal');
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
    $('.openUpdateCategorie').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("update")[1];
        $("#categorie_id").val(id);
        $('#editCategorieModal').show();
    });
    $('#updateCategorie').on('click', function () {
        let id = $("#categorie_id").val();
        let naziv_kategorije = $("#categorie_name").val();
        let data = JSON.stringify({
            "id": id,
            "naziv_kategorije": naziv_kategorije
        });
        $.ajax({
            type: "POST",
            url: "Myservice.asmx/UpdateCategorie",
            contentType: 'application/json; charset=utf-8',
            data: data,
            dataType: "json",
            success: function (data) {
                $('#parentCategory' + id).html(naziv_kategorije);
                $('#editCategorieModal').hide();
            }, error: function (error) {
                alert('failed');
            }
        });
    });
    $('.deleteCategorie').on('click', function () {
        let id = $(this).attr('id');
        id = id.split("delete")[1];
        if (confirm("Are you sure you want to delete this category?")) {

            let data = JSON.stringify({ "id": id });
            $.ajax({
                type: "POST",
                url: "Myservice.asmx/DeleteCategorie",
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