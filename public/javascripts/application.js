$(function() {
  $("#teams th a, #teams .pagination a, #people th a, #people .pagination a, #users th a, #users .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $('#teamstat_person_tokens').tokenInput("/people.json", {
    crossDomain: false,
    prePopulate: $('#teamstat_person_tokens').data("pre"),
    theme: "facebook"
  });
  
  $( "#person_birth_date" ).datepicker({
    showOn: "button",
    buttonImage: "/images/calendar.png",
    buttonImageOnly: true
  });

  $(".collapse").collapse();

  $(document).ready(function() {
    $("#league_supports_games").click(function() {
      if(this.checked) {
          alert_game_on();
      } else {
          alert_game_off();
      }

      function alert_game_on() {
          $('#gameWarning .modal-body p').remove();
          $('#gameWarning .modal-body').append("<p>Game management will be turned ON. This will disable ability to edit teamstats directly.</p>");
          $('#teamstats_table').hide();
          $('#gameWarning').modal();
      }

      function alert_game_off() {
          $('#gameWarning .modal-body p').remove();
          $('#gameWarning .modal-body').append("<p>Game management will be turned OFF. This will enable ability to edit teamstats directly. You will need to save and re-edit.</p>");
          $('#teamstats_table').show();
          $('#gameWarning').modal();
      }
    });
  });

});
