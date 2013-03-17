(function(App, $, undefined){
  "use strict";

  App.ModalHelpers = function() {
    this._modalConfirmation = function(textSelector, selector, callback) {
      var modalWindow = function($self){
        return $('<div class="modal hide fade">' +
          '<div class="modal-body">' +
            '<p>' + $self.data(textSelector) + '</p>' +
          '</div>' +
          '<div class="modal-footer">' +
            '<a href="#" class="btn" data-dismiss="modal">Nie</a>' +
            '<a href="#" class="btn btn-primary">Tak</a>' +
          '</div>' +
        '</div>')
      }
      $(selector).click(function(event) {
        var $self = $(this)
        event.preventDefault();
        var $modal = modalWindow($self);
        $modal.modal({backdrop: 'static', keyboard: false})
        $modal.find('.btn-primary').on('click', function(){
          callback.call($self);
        });
      })
    }
  }

})(window.App = window.App || {}, jQuery);

