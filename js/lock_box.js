var LockBox = function(){  
  var LocalStoreAdapter = {
    get: function(key){ return localStorage[key]; },
    set: function(key, value){ localStorage[key] = value; },
    removeItem: function(key){ localStorage.removeItem(key); }
  };
  
  var CookieAdapter = {
    get: function(key){ return $.cookie(key); },
    set: function(key, value){ $.cookie(key, value); },
    removeItem: function(key){ $.cookie(key, null); }
  };
  
  var adapter = /* (!!window.localStorage) ? LocalStoreAdapter :*/ CookieAdapter;
  
  console.log(adapter);
  
  this.set = function(key, value){ adapter.set(key, value); };
  this.get = function(key){ return adapter.get(key); };
  this.exists = function(key){ !!this.get(key); };
  this.removeItem = function(key){ adapter.removeItem(key); };
};