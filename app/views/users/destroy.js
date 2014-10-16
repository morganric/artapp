$(".alert-notice").html("<%= escape_javascript(flash[:notice]) %>");
$(".alert").show(300);
console.log("Fav deleted");
location.reload();