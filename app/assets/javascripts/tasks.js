document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
    $(".task-completion-checkboxes input").each(function(index, task) {
      let task_id = task.id.split("-")[2];
      let feature_id = task.id.split("-")[3];
      $(`#feature-task-${task_id}-${feature_id}`).bind('change', function(){
        $.ajax({
          url: '/tasks/'+this.value+'/update_task',
          beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
          type: 'POST',
          data: { "task_completion": this.checked },
          success: function(){
            var checked = document.getElementById(`feature-task-${task_id}-${feature_id}`).checked?1:-1;
            var current_value = parseInt($(`#tasking-${feature_id}`).text());
            $(`#tasking-${feature_id}`).text(current_value + checked+"");
            $(`#tasking2-${feature_id}`).text(current_value + checked+"");
            if (checked == 1) {
              alert('Task Done');
            }
            else {
              alert('Task Not Done')
            }
          }
        });
      });
    });
  });
});