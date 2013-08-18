$(function() {
  $("#teams th a, #teams .pagination a, #people th a, #people .pagination a, #users th a, #users .pagination a, #venues th a, #venues .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $( "#person_birth_date" ).datepicker({
    showOn: "button",
    buttonImage: "/images/calendar.png",
    buttonImageOnly: true
  });

  $(".collapse").collapse();

  function close_modal_focus() {
      $('#modal-close').focus();
  }

  $(document).ready(function() {
      $('#technicalstaff_person_id,#playerstat_person_id,#roster_person_id').tokenInput("/en/people.json", {
          crossDomain: false,
          prePopulate: $('#technicalstaff_person_id').data("pre"),
          theme: "facebook",
          tokenLimit: 1
      });
      $('#playinglocation_venue_id').tokenInput("/en/venues.json", {
          crossDomain: false,
          prePopulate: $('#playinglocation_venue_id').data("pre"),
          theme: "facebook",
          tokenLimit: 1
      });

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
          close_modal_focus();
      }

      function alert_game_off() {
          $('#gameWarning .modal-body p').remove();
          $('#gameWarning .modal-body').append("<p>Game management will be turned OFF. This will enable ability to edit teamstats directly. You will need to save and re-edit.</p>");
          $('#teamstats_table').show();
          $('#gameWarning').modal();
          close_modal_focus();
      }

    });
    $("#person_thumb").click(function() {
        $('#personDetail').modal();
          close_modal_focus();
    });

    $('#league-tab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });

  });

});
