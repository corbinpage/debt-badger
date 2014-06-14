// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

(function($) {
    /**
   * attaches a character counter to each textarea element in the jQuery object
   * usage: $("#myTextArea").charCounter(max, settings);
   */
  
  $.fn.charCounter = function (max, settings) {
    max = max || 100;
    settings = $.extend({
      container: "<span></span>",
      classname: "charcounter",
      format: "(%1 characters remaining)",
      pulse: true,
      delay: 0
    }, settings);
    var p, timeout;
    
    function count(el, container) {
      el = $(el);
      if (el.val().length > max) {
          el.val(el.val().substring(0, max));
          if (settings.pulse && !p) {
            pulse(container, true);
          };
      };
      if (settings.delay > 0) {
        if (timeout) {
          window.clearTimeout(timeout);
        }
        timeout = window.setTimeout(function () {
          container.html(settings.format.replace(/%1/, (max - el.val().length)));
        }, settings.delay);
      } else {
        container.html(settings.format.replace(/%1/, (max - el.val().length)));
      }
    };
    
    function pulse(el, again) {
      if (p) {
        window.clearTimeout(p);
        p = null;
      };
      el.animate({ opacity: 0.1 }, 100, function () {
        $(this).animate({ opacity: 1.0 }, 100);
      });
      if (again) {
        p = window.setTimeout(function () { pulse(el) }, 200);
      };
    };
    
    return this.each(function () {
      var container;
      if (!settings.container.match(/^<.+>$/)) {
        // use existing element to hold counter message
        container = $(settings.container);
      } else {
        // append element to hold counter message (clean up old element first)
        $(this).next("." + settings.classname).remove();
        container = $(settings.container)
                .insertAfter(this)
                .addClass(settings.classname);
      }
      $(this)
        .unbind(".charCounter")
        .bind("keydown.charCounter", function () { count(this, container); })
        .bind("keypress.charCounter", function () { count(this, container); })
        .bind("keyup.charCounter", function () { count(this, container); })
        .bind("focus.charCounter", function () { count(this, container); })
        .bind("mouseover.charCounter", function () { count(this, container); })
        .bind("mouseout.charCounter", function () { count(this, container); })
        .bind("paste.charCounter", function () { 
          var me = this;
          setTimeout(function () { count(me, container); }, 10);
        });
      if (this.addEventListener) {
        this.addEventListener('input', function () { count(this, container); }, false);
      };
      count(this, container);
    });
  };

})(jQuery);



$(document).ready(function () {

    $('#debt-form').validate({
      rules: {
        'debt[amount]': {
          number: true,
          min: 1,
          required: true
        },
        'debt[debtor_name]': {
          maxlength: 20,
          required: true
        },
        'debt[debtor_phone]': {
          required: true,
          maxlength: 17,
          minlength: 17
        },
        'debt[creditor_name]': {
          maxlength: 20,
          required: true
        },
        'debt[creditor_phone]': {
          required: true,
          maxlength: 17,
          minlength: 17
        },
        'debt[message]': {
          minlength: 4,
          maxlength: 160,
          required: true
        }
      },
      messages: {
        'debt[debtor_phone]': {
          minlength: "Please enter a valid phone number."
        },
        'debt[creditor_phone]': {
          minlength: "Please enter a valid phone number."
        }
      },
      highlight: function(element) {
        $(element).closest('.control-group').removeClass('success').addClass('error');
      },
      success: function(element) {
        $(element).closest('.control-group').removeClass('error');
        $(element).remove();
      }
    });

    $(function() {
      $("#message-box").charCounter(160,{container: "#counter"});
    });

    function update_message() {
      var amount = (!$("#amount").val()) ? "<amount>" : '$' + $.number( $("#amount").val(), 2 );
      var debtor_name = (!$("#debtor_name").val()) ? "<debtor>" : $("#debtor_name").val();
      var creditor_name = (!$("#creditor_name").val()) ? "<your_name>" : $("#creditor_name").val();

      var message_val = "Hey " + debtor_name + ", you still owe " + creditor_name + " " + amount + ". Just pay him back already! Otherwise, I’ll be badging you each day until you pay! Love, MoneyBadger"

      $("#message-box").val(message_val)
    };

  // $('#amount').number( true, 2 );

    $('#amount,#debtor_name,#creditor_name').on('input', function() { 
      update_message();  
    });

});






