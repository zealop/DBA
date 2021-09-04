// const address = "http://c475f61b43e1.ap.ngrok.io"
const address = "http://127.0.0.1:3000"
document.getElementById("book").onclick = function()
{
    console.log('click');
    fetch(`${address}/book`)
        .then(response => response.json())
        .then(data => {
            fetch('book.html')
                .then(response => response.text())
                .then(text => {
                    if ( $.fn.DataTable.isDataTable( '#mytable' ) ) {
                        var table = $('#mytable').DataTable();
                        table.destroy();
                    }
                    document.getElementById("my-wrapper").innerHTML = text;

                    $("#mytable").DataTable( {
                        data: data,
                        columns: [  
                            { data: 'IDBook' },
                            { data: 'NameBook' },
                            { data: 'BookSummary' },
                            { data: 'CoverImage' },
                            { data: 'CurrentBookPrice' },
                            { data: 'Author'},
                            { data: 'BNamePublisher' },
                            { data: 'PublisherTime' },
                            {
                                data: null,
                                className: "dt-center editor-edit",
                                defaultContent: '<i class="fa fa-pencil edit-book"/>',
                                orderable: false
                            },
                            {   
                                data: null,
                                className: "dt-center editor-delete",
                                defaultContent: '<i class="fa fa-trash delete-book"/>',
                                orderable: false
                            }
                        ]
                    })
                    $("#add-book").click(function() {

                        fetch(`${address}/publisher`)
                        .then(response => response.json())
                        .then(data => {
                            const select =  document.getElementById('inputPublisher');
                            data.forEach(e => {
                                var opt = document.createElement('option');
                                opt.value = e.NamePublisher;
                                opt.innerHTML = e.NamePublisher;
                                select.appendChild(opt);
                            });
                        });
                        
                        document.getElementById("bookId").readOnly = false;
         
                        document.getElementById("myform").reset();
                        $('#myModal').modal('toggle');

                        $("#myform").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/add-book" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#myModal').modal('toggle');
                                    $('#book').click();
                                 }
                            });
                        });

                    });
                    $(document).on('click', '.edit-book', function() {
                        var row = $(this).closest("tr");    // Find the row
                        var tds = row.find("td"); // Find the text
                        
                
                        fetch(`${address}/publisher`)
                        .then(response => response.json())
                        .then(data => {
                            const select =  document.getElementById('inputPublisher');
                            data.forEach(e => {
                                var opt = document.createElement('option');
                                opt.value = e.NamePublisher;
                                opt.innerHTML = e.NamePublisher;
                                select.appendChild(opt);
                            });
                            $("#inputPublisher").val($(tds[6]).text()).change();
                        });
                        
                        $("#bookId").val($(tds[0]).text());
                        $("#inputName").val($(tds[1]).text());
                        $("#inputSum").val($(tds[2]).text());
                        $("#inputCover").val($(tds[3]).text());
                        $("#inputPrice").val($(tds[4]).text());
                        $("#inputDate").val($(tds[7]).text());

                        document.getElementById("bookId").readOnly = true;
                        // document.getElementById("myform").action = "/edit-book";
                        $('#myModal').modal('toggle');

                        $("#myform").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/edit-book" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#myModal').modal('toggle');
                                    $('#book').click();
                                 }
                            });
                        });
                    });
                    $(document).on('click', '.delete-book', function() {
                        var row = $(this).closest("tr");    // Find the row
                        var tds = row.find("td"); // Find the text
                        
                        $("#bookId2").val($(tds[0]).text());
  
                        $('#delModal').modal('toggle');

                        $("#myform_del").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/delete-book" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#delModal').modal('toggle');
                                    $('#book').click();
                                 }
                            });
                        });
                    });
                });
        });
}




document.getElementById("publisher").onclick = function()
{
    fetch(`${address}/publisher`)
        .then(response => response.json())
        .then(data => {
            fetch('publisher.html')
                .then(response => response.text())
                .then(text => {
                    if ( $.fn.DataTable.isDataTable( '#mytable' ) ) {
                        var table = $('#mytable').DataTable();
                        table.destroy();
                    }
                    document.getElementById("my-wrapper").innerHTML = text;
                    $("#mytable").DataTable( {
                        data: data,
                        columns: [  
                            { data: 'NamePublisher' },
                            { data: 'AddressPublisher' },
                            { data: 'PhonePublisher' },
                            { data: 'EmailPublisher' },
                            { data: 'BusinessCode' },
                            {
                                data: null,
                                className: "dt-center editor-edit",
                                defaultContent: '<i class="fa fa-pencil edit-publisher"/>',
                                orderable: false
                            },
                            {   
                                data: null,
                                className: "dt-center editor-delete",
                                defaultContent: '<i class="fa fa-trash delete-publisher"/>',
                                orderable: false
                            }
                        ]
                    });

                    $("#add-publisher").click(function() {
                        document.getElementById("inputName").readOnly = false;
                        // document.getElementById("myform").action = "/add-publisher";
                        document.getElementById("myform").reset();
                        $('#myModal').modal('toggle');

                        $("#myform").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/add-publisher" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#myModal').modal('toggle');
                                    $('#publisher').click();
                                 }
                            });
                        });
                    });
                    $(".edit-publisher").click(function() {
                        var row = $(this).closest("tr");    // Find the row
                        var tds = row.find("td"); // Find the text
                       
                        $("#inputName").val($(tds[0]).text());
                        $("#inputAdd").val($(tds[1]).text());
                        $("#inputPhone").val($(tds[2]).text());
                        $("#inputEmail").val($(tds[3]).text());
                        $("#inputCode").val($(tds[4]).text());


                        document.getElementById("inputName").readOnly = true;
                        // document.getElementById("myform").action = "/edit-publisher";
                        $('#myModal').modal('toggle');

                        $("#myform").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/edit-publisher" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#myModal').modal('toggle');
                                    $('#publisher').click();
                                 }
                            });
                        });
                    });
                    $(".delete-publisher").click(function() {
                        var row = $(this).closest("tr");    // Find the row
                        var tds = row.find("td"); // Find the text
                        
                        $("#inputName2").val($(tds[0]).text());
  
                        $('#delModal').modal('toggle');

                        $("#myform_del").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/delete-publisher" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#delModal').modal('toggle');
                                    $('#publisher').click();
                                 }
                            });
                        });
                    });
                });
        });
}

document.getElementById("author").onclick = function()
{
    fetch(`${address}/author`)
        .then(response => response.json())
        .then(data => {
            fetch('author.html')
                .then(response => response.text())
                .then(text => {
                    if ( $.fn.DataTable.isDataTable( '#mytable' ) ) {
                        var table = $('#mytable').DataTable();
                        table.destroy();
                    }
                    document.getElementById("my-wrapper").innerHTML = text;
                    $("#mytable").DataTable( {
                        data: data,
                        columns: [  
                            { data: 'IDAuthor' },
                            { data: 'Fname' },
                            { data: 'Mname' },
                            { data: 'Lname' },
                            { data: 'AddressAuthor' },
                            { data: 'EmailAuthor' },
                            { data: 'PhoneAuthor' },
                            {
                                data: null,
                                className: "dt-center editor-edit",
                                defaultContent: '<i class="fa fa-pencil edit-author"/>',
                                orderable: false
                            },
                            {   
                                data: null,
                                className: "dt-center editor-delete",
                                defaultContent: '<i class="fa fa-trash delete-author"/>',
                                orderable: false
                            }
                        ]
                    });

                    $("#add-author").click(function() {
                        document.getElementById("inputId").readOnly = false;
                        // document.getElementById("myform").action = "/add-author";
                        document.getElementById("myform").reset();
                        $('#myModal').modal('toggle');

                        $("#myform").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/add-author" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#myModal').modal('toggle');
                                    $('#author').click();
                                 }
                            });
                        });
                    });
                    $(".edit-author").click(function() {
                        var row = $(this).closest("tr");    // Find the row
                        var tds = row.find("td"); // Find the text
                       
                        $("#inputId").val($(tds[0]).text());
                        $("#inputFName").val($(tds[1]).text());
                        $("#inputMName").val($(tds[2]).text());
                        $("#inputLName").val($(tds[3]).text());
                        $("#inputAdd").val($(tds[4]).text());
                        $("#inputPhone").val($(tds[5]).text());
                        $("#inputEmail").val($(tds[6]).text());


                        document.getElementById("inputId").readOnly = true;
                        // document.getElementById("myform").action = "/edit-author";
                        $('#myModal').modal('toggle');

                        $("#myform").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this);
                            var url = "/edit-author" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#myModal').modal('toggle');
                                    $('#author').click();
                                 }
                            });
                        });
                    });
                    $(".delete-author").click(function() {
                        var row = $(this).closest("tr");    // Find the row
                        var tds = row.find("td"); // Find the text
                        
                        $("#inputId2").val($(tds[0]).text());
  
                        $('#delModal').modal('toggle');

                        $("#myform_del").submit(function(e) {
                            e.preventDefault(); // prevent actual form submit
                            var form = $(this); 
                            var url = "/delete-author" //get submit url [replace url here if desired]
                            $.ajax({
                                 type: "POST",
                                 url: url,
                                 data: form.serialize(), // serializes form input
                                 success: function(data){
                                    alert(data);
                                    $('#delModal').modal('toggle');
                                    $('#author').click();
                                 }
                            });
                        });
                    });
                });
        });
}