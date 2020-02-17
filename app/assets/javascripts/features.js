document.addEventListener("turbolinks:load", function() {
	$(document).ready(function() {
		$(".feature_status_selectors select").each(function(index, feature) {
		  let feature_id = feature.id.split("_")[2];
		  $(`#feature_status_${feature_id}`).bind('change',function(){
			  jQuery.ajax({
			    url: `/features/${feature_id}/update_status`,
			    beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
			    type: "PATCH",
			    data: { "feature_status": this.value },
			    success: function(data) {
			      alert("Status successfully set.");
			    }
			  });
			});
		  
		  $(`#feature_assign_${feature_id}`).change(function(){
		    jQuery.ajax({
		      url: `/features/${feature_id}`,
		      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
		      type: "PATCH",
		      data: { "member_id": this.value },
		      success: function(data) {
		        alert("Member successfully assigned.");
		      }
		  	});
			});
		});
	});
});
