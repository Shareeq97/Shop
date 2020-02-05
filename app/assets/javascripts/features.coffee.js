# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#feature-show

$(document).ready(function(){
  $('#feature_<%= feature.id %>').select2({
    placeholder: "Choose a person",
    allowClear: true
  });

 	$("#feature_<%= feature.id %>").change(function(){
    jQuery.ajax({
      url: "/features/<%= feature.id %>",
      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
      type: "PATCH",
      data: { "member_id": this.value },
      success: function(data) {
        alert("Member successfully assigned.");
      }
    });
  });
});