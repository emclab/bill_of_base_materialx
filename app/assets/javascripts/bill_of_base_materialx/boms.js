// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
    return $('#bom_part_name_autocomplete').autocomplete({
        minLength: 1,
        source: $('#bom_part_name_autocomplete').data('autocomplete-source'),  //'#..' can NOT be replaced with this
        select: function(event, ui) {
            //alert('fired!');
            $('#bom_part_name_autocomplete').val(ui.item.value);
        },
    });
});

$(function() {
	$( "#bom_start_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#bom_end_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
});

$(function (){
	$('#bom_part_name_autocomplete').change(function(){
	  $('#bom_field_changed').val('part_name');
      $.get(window.location, $('form').serialize(), null, "script");
  	  return false;
	});
});