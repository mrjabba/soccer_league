$(function() {
  $("#teams th a, #teams .pagination a, #players th a, #players .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

});
