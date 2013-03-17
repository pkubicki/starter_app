(function(App, $, undefined){
  "use strict";

  App.Base = function() {
    App.ModalHelpers.call(this);

    this._increaseTopPadding = function() {
      $("*[data-body-padding-increase]").each(function(index, element){
        var currentPadding = parseInt($("body").css('padding-top'));
        $("body").css('padding-top', currentPadding + $(element).data('body-padding-increase') + 'px')
      });
    }

    this._initDateAndDateTimePickers = function() {
      $("input[data-datetime-picker]").datetimepicker({
        dateFormat: 'yy-mm-dd',
        timeFormat: 'H:mm:ss',
        showSecond: true
      });
      $("input[data-date-picker]").datepicker({
        dateFormat: 'yy-mm-dd'
      });
    }

    this._initListCheckboxes = function() {
      var $table = $("table[data-with-checkboxes]");
      var checkAll = function() {
          $table.find('tbody tr:not(.search-row) input[type="checkbox"]').each(function(index, checkbox) {
            checkbox.checked = true;
          });
        }
      var unCheckAll = function() {
          $table.find('tbody tr:not(.search-row) input[type="checkbox"]').each(function(index, checkbox) {
            checkbox.checked = false;
          });
        }
      if ($table.length) {
        $table.find('thead tr').each(function(index, element){
          $(element).prepend('<th/>');
        });
        $table.find('tbody tr').each(function(index, element){
          $(element).prepend('<td/>');
        });
        $table.find('tbody tr').each(function(index, element) {
          if(!$(element).hasClass('search-row')) {
            var $existingCheckBox = $table.find("tbody tr:not(.search-row) input[type='checkbox'][value='" + $(element).data('object-id') + "']");
            if($existingCheckBox.length === 0){
              $(element).find('td:first').prepend($('<input>', {name: "ids[]", type: "checkbox", value: $(element).data('object-id')}));
            }
          } else {
            $(element).find('td:first').prepend($('<input>', {id: "checkboxesToggle", type: "checkbox", value: ""}));
          }
        });
        $table.find('tbody tr.search-row input[type="checkbox"]').change(function(){
          if(this.checked) {
            checkAll();
          } else {
            unCheckAll();
          }
        });
      }
    }

    this._initConfirm = function() {
      $.rails.confirm = function(){};
      this._modalConfirmation(
        'confirm',
        'a[data-confirm]',
        function() {
          $.rails.handleMethod($(this))
        }
      )
    }

    this._initConfirmAndSubmit = function() {
      this._modalConfirmation(
        'confirm-and-submit',
        '*[data-confirm-and-submit]',
        function(){
          var $f = $('form#list-form');
          $f.attr('method', 'post');
          $f.attr('action', $(this).attr('href'));
	  if($(this).data('form-method') != undefined) {
   	    $f.append($('<input name="_method" value="' + $(this).data('form-method').toUpperCase() + '" type="hidden" />'));
	  }
          $f.submit();
        }
      )
    }

    this._removeEmptyMenuDropdowns = function() {
      $("ul.dropdown-menu").each(
        function() {
          var elem = $(this);
          if (elem.children().length == 0) {
            elem.parent().remove();
          }
        }
      );
    }

    this.init = function() {
      this._increaseTopPadding();
      this._initDateAndDateTimePickers();
      this._initConfirm();
      this._removeEmptyMenuDropdowns();
    }

    this.index = function() {
      this._initListCheckboxes();
      this._initConfirmAndSubmit();
    }
  }

  var executeControllerAction = function() {
    var $body = $("body");
    var controllerClass = App[$body.data("controller")]
    var action = $body.data("action");
    if(action === 'new') {
      action = 'create';
    }
    if(action === 'edit') {
      action = 'update';
    }
    var base = new App.Base;
    base.init();
    if ($.isFunction(base[action])) {
      base[action]();
    }
    if(controllerClass !== undefined) {
      var controller = new controllerClass;
      if (controller !== undefined) {
        if ($.isFunction(controller[action])) {
          controller[action]();
        }
      }
    }
  }

  App.init = function() {
    $(executeControllerAction());
  }

})(window.App = window.App || {}, jQuery);

