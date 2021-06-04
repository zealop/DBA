//Turn form into JSON
(function ($) {
    $.fn.serializeFormJSON = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };
})(jQuery);
//Turn row in to JSON except last column
(function ($) {
    $.fn.serializeRowJSON = function () {
		var o ={};
		var headers = $(this).parents("table").find("th");
		$(this).parents("tr").find("td").not(':last').each(function(cellIndex) {
			o[$(headers[cellIndex]).html()] = $(this).html();
		});    
		return o;
	};
}) (jQuery);



$(document).ready(function() {	

    //Grab data from table
    $.get("./init.php", function(data, status) {
        var data_list = data;
        for (var i = 0; i < data_list.length; i++) {
			var data = '<tr>';
			for (var j=0; j < col.length;j++){
				if(String(data_list[i][col[j]]) == 'null')
					temp = '';
				else
					temp = data_list[i][col[j]];
				data += '<td>' + temp + "</td>";
			}
			data += '<td><button class="btn btn-info btn-xs btn-edit">Edit</button><button class="btn btn-danger btn-xs btn-delete">Delete</button></td></tr>';
            $("#mytbody").append(data);
        }
        $('#mytable').DataTable();
        $('.dataTables_length').addClass('bs-select');
    });

    //add
    $("form").submit(function(e) {
        e.preventDefault();
		var data = $(this).serializeFormJSON();
		console.log(data);
		
        $.ajax({
            type: "POST",
            url: './add.php',
            processData: false,
            contentType: 'application/json',
			dataType: 'text',
            data: JSON.stringify(data),
            beforeSend: function() {
                console.log('Sending AJAX Request...');
            },
            success: function(response) {
                console.log(response);
                if (response.trim() == 'New record added') {
					temp = "<tr>";
					for (var i=0; i < col.length;i++)
						temp += '<td>' + $("input[name="+abr[i]+"]").val(); + "</td>"; 
					temp+="</td><td><button class='btn btn-info btn-xs btn-edit'>Edit</button><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td></tr>";
                    $("#mytbody").prepend(temp);
                    $("input").val('');
                }
				alert(response);
				if($("#mytbody").find('tr:first').find('td:first').html() == 'undefined'){	
					location.reload(true);
				}
                
            },
            error: function(response) {
                console.log(response);
            }
        });
    });


    //delete
    $("body").on("click", ".btn-delete", function() {
		var ref = $(this);		
		var data = $(this).serializeRowJSON();
		
        $.ajax({
            type: "POST",
            url: './remove.php',
            processData: false,
			dataType: 'text',
            contentType: 'application/json',
            data: JSON.stringify(data),
            beforeSend: function() {
                console.log('Sending AJAX Request...');
            },
            success: function(response) {
                console.log(response);
				if(response.trim() == "Record deleted"){
					ref.parents("tr").remove();
				}
				else
					alert(response);
            },
            error: function(response) {
                console.log(response);
            }
        });
        
    });

    //edit
	var tmp =[];
    $("body").on("click", ".btn-edit", function() {
		
		$(this).parents("tr").find("td").not(':last').each(function(cellIndex) {		
			tmp[cellIndex] = $(this).html();
			var headers = $(this).parents("table").find("th");
			if($(headers[cellIndex]).html()!= 'ID')
				$(this).attr('contenteditable', 'true');	
		});    
		
        $(this).parents("tr").find('td:last').prepend("<button class='btn btn-info btn-xs btn-update'>Update</button><button class='btn btn-warning btn-xs btn-cancel'>Cancel</button>")
        $(this).hide();
    });

    //cancel
    $("body").on("click", ".btn-cancel", function() {
		$(this).parents("tr").find("td").each(function(cellIndex) {
			$(this).text(tmp[cellIndex]);
			$(this).attr('contenteditable', 'false');	
		}); 

        $(this).parents("tr").find(".btn-edit").show();
        $(this).parents("tr").find(".btn-update").remove();
        $(this).parents("tr").find(".btn-cancel").remove();
    });

    //update
    $("body").on("click", ".btn-update", function() {
		var ref = $(this);
        var data = $(this).serializeRowJSON();
		
        $.ajax({
            type: "POST",
            url: './update.php',
            processData: false,
			dataType: 'text',
            contentType: 'application/json',
            data: JSON.stringify(data),
            beforeSend: function() {
                console.log('Sending AJAX Request...');
            },
            success: function(response) {
                console.log(response);
                if (response.trim() == "Record updated") {
					ref.parents("tr").find("td").each(function(cellIndex) {
						$(this).attr('contenteditable', 'false');	
					}); 

                    ref.parents("tr").find(".btn-edit").show();
                    ref.parents("tr").find(".btn-cancel").remove();
                    ref.parents("tr").find(".btn-update").remove();
                }
                alert(response);
                
            },
            error: function(response) {
                console.log(response);
            }
        });
    });
});
//sidebar
jQuery(function($) {

    $(".sidebar-dropdown > a").click(function() {
        $(".sidebar-submenu").slideUp(200);
        if (
            $(this)
            .parent()
            .hasClass("active")
        ) {
            $(".sidebar-dropdown").removeClass("active");
            $(this)
                .parent()
                .removeClass("active");
        } else {
            $(".sidebar-dropdown").removeClass("active");
            $(this)
                .next(".sidebar-submenu")
                .slideDown(200);
            $(this)
                .parent()
                .addClass("active");
        }
    });

    $("#close-sidebar").click(function() {
        $(".page-wrapper").removeClass("toggled");
    });
    $("#show-sidebar").click(function() {
        $(".page-wrapper").addClass("toggled");
    });
});