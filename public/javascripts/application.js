$(function() {
  $("#teams th a, #teams .pagination a, #players th a, #players .pagination a, #users th a, #users .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $('#teamstat_player_tokens').tokenInput("/players.json", {
    crossDomain: false,
    prePopulate: $('#teamstat_player_tokens').data("pre"), 
    theme: "facebook"
  });
});


