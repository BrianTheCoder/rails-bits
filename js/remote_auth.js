var Window;
(function($){
  $.fn.remoteAuth = function(callback, options, service){
    return this.each(function(){
      var $self = $(this);
      $self.bind('click', function(e){
        e.preventDefault();
        this.window = new RemoteWindow();
        this.window.open($self.attr('href'), options, name).bind('close', function(){
          if(Window.authorized[service + 'Service']) callback.call($self);
          else{
            var modal = $.modal();
            modal.show('<div class="bad-message"> \
            <p>We were not able to authorize your ' + service + ' account</p></div>');
          }
        });
      });
    });
  };
  
  
  RemoteWindow = function(){
    var self = this, watcher, defaultParams = {
      'location': 'no',
      'status': 'no',
      'menubar': 'no',
      'resizable': 'no',
      'scrollbars': 'no',
      'toolbar': 'no',
      'directories': 'no',
      'alwaysRaised': 'yes',
      'z-lock': 'no',
      'width': 800,
      'height': 400,
      'center': true
    };
    
    var buildParamsString = function(params){
      return _.map(params, function(value, key){
        if(value == true) value = 'yes';
        if(value == false) value = 'no';
        return key + '=' + value;
      }).join(',');
    };
    
    var closeCheck = function(){
      if(self.instance.closed){
        window.clearInterval(watcher);
        $(self).trigger('close');
      }
    };
    
    var centerWindow = function(width, height){
      return {'top': (screen.height - height - 100)/2, 'left': (screen.width - width)/2 };
    };
    
    this.open = function(url, params, name){
      var params = $.extend({}, defaultParams, params);
      if(this.instance) return this.instance;
      this.name = name || 'newWindow';
      if(params['center']){
        $.extend(params, centerWindow(params['width'], params['height']));
        delete params['center'];
      }
      this.instance = window.open(url, name, buildParamsString(params));
      this.instance.focus();
      watcher = window.setInterval(closeCheck, 500);
      return $(this);
    };
    
    this.close = function(){
      this.instance.close();
      this.instance = null;
      $(this).trigger('close');
      return $(this);
    };
  };
  
  RemoteWindow.authorized = {};
})(jQuery);