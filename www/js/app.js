var app;

app = angular.module('active-accounting', ['ionic', 'ngResource', 'satellizer', 'Devise', 'ngStorage', 'angularMoment', 'ionic-datepicker']).run(function($ionicPlatform) {
  return $ionicPlatform.ready(function() {
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);
    }
    if (window.StatusBar) {
      return StatusBar.styleDefault();
    }
  });
});

app.config(function($stateProvider, $urlRouterProvider, $ionicConfigProvider) {
  var adminLoginRequired, vendorLoginRequired;
  vendorLoginRequired = function($q, $state, $auth) {
    var deferred;
    deferred = void 0;
    deferred = $q.defer();
    if ($auth.isAuthenticated()) {
      deferred.resolve();
    } else {
      $state.go('vendor-login');
    }
    return deferred.promise;
  };
  adminLoginRequired = function($q, $state, $localStorage) {
    var deferred;
    deferred = void 0;
    deferred = $q.defer();
    if (angular.isObject($localStorage.currentAdmin)) {
      deferred.resolve();
    } else {
      $state.go('admin-login');
    }
    return deferred.promise;
  };
  $ionicConfigProvider.tabs.position('bottom');
  $ionicConfigProvider.navBar.alignTitle('center');
  $urlRouterProvider.otherwise('/vendor_login');
  return $stateProvider.state('vendor-login', {
    url: '/vendor_login',
    templateUrl: 'templates/vendor_login.html',
    controller: 'VendorLoginCtrl'
  }).state('vendor-profile', {
    url: '/vendor_profile',
    abstract: true,
    templateUrl: 'templates/vendor_profile.html',
    controller: 'VendorProfileCtrl'
  }).state('vendor-profile.hours', {
    url: '/hours',
    views: {
      'hours-tab': {
        templateUrl: 'templates/hours.html',
        controller: 'HoursCtrl'
      }
    },
    resolve: {
      loginRequired: vendorLoginRequired
    },
    cache: false
  }).state('vendor-profile.calc', {
    url: '/calc',
    views: {
      'calc-tab': {
        templateUrl: 'templates/calc.html',
        controller: 'CalcCtrl'
      }
    },
    resolve: {
      loginRequired: vendorLoginRequired
    },
    cache: false
  }).state('vendor-profile.holidays', {
    url: '/our-holidays',
    views: {
      'holidays-tab': {
        templateUrl: 'templates/holidays.html',
        controller: 'HolidaysCtrl'
      }
    },
    resolve: {
      loginRequired: vendorLoginRequired
    },
    cache: false
  }).state('vendor-password-reset', {
    url: 'vendor_password_reset/new',
    templateUrl: 'templates/vendor_password_reset.html',
    controller: 'VendorPasswordResetCtrl'
  }).state('admin-login', {
    url: '/admin_login',
    templateUrl: 'templates/admin_login.html',
    controller: 'AdminLoginCtrl'
  }).state('admin', {
    url: '/admin',
    abstract: true,
    templateUrl: 'templates/admin.html',
    controller: 'AdminCtrl'
  }).state('admin.register', {
    url: '/register',
    views: {
      'register-tab': {
        templateUrl: 'templates/register.html',
        controller: 'RegisterCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.register-new', {
    url: '/register/new',
    views: {
      'register-tab': {
        templateUrl: 'templates/register-new.html',
        controller: 'RegisterNewCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.register-detail', {
    url: '/register/:registerId',
    views: {
      'register-tab': {
        templateUrl: 'templates/register-detail.html',
        controller: 'RegisterDetailCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.counterparty', {
    url: '/counterparty',
    views: {
      'counterparty-tab': {
        templateUrl: 'templates/counterparty.html',
        controller: 'CounterpartyCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.counterparty-new', {
    url: '/counterparty/new',
    views: {
      'counterparty-tab': {
        templateUrl: 'templates/counterparty-new.html',
        controller: 'CounterpartyNewCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.counterparty-detail', {
    url: '/counterparty/:counterpartyId',
    views: {
      'counterparty-tab': {
        templateUrl: 'templates/counterparty-detail.html',
        controller: 'CounterpartyDetailCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.article', {
    url: '/articles',
    views: {
      'article-tab': {
        templateUrl: 'templates/article.html',
        controller: 'ArticleCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.article-new', {
    url: '/article/new',
    views: {
      'article-tab': {
        templateUrl: 'templates/article-new.html',
        controller: 'ArticleNewCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  }).state('admin.article-detail', {
    url: '/article/:articleId',
    views: {
      'article-tab': {
        templateUrl: 'templates/article-detail.html',
        controller: 'ArticleDetailCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    },
    cache: false
  });
});

app.constant('articleTypes', ['Revenue', 'Cost', 'Translation', 'Loan']);

app.constant('apiEndpoint', 'http://accounting.active-bridge.com');

app.constant('counterpartyTypes', ['Customer', 'Vendor', 'Other', 'HR']);

app.config([
  '$authProvider', '$httpProvider', 'apiEndpoint', function($authProvider, $httpProvider, apiEndpoint) {
    $authProvider.withCredentials = true;
    $authProvider.httpInterceptor = true;
    $authProvider.baseUrl = apiEndpoint;
    $authProvider.loginUrl = '/vendor_login.json';
    $authProvider.tokenName = 'auth_token';
    $authProvider.tokenPrefix = 'satellizer';
    $authProvider.authHeader = 'Authorization';
    $authProvider.authToken = 'Bearer';
    return $authProvider.cordova = true;
  }
]);

app.config([
  'AuthProvider', 'apiEndpoint', function(AuthProvider, apiEndpoint) {
    AuthProvider.loginPath(apiEndpoint + '/admins/sign_in.json');
    AuthProvider.logoutPath(apiEndpoint + '/admins/sign_out.json');
    return AuthProvider.resourceName('admin');
  }
]);

app.controller('AdminCtrl', [
  '$scope', '$state', 'Auth', '$localStorage', function($scope, $state, Auth, $localStorage) {
    $scope.isCurrentAdmin = angular.isObject($localStorage.currentAdmin);
    return $scope.logout = function() {
      var config;
      config = {
        headers: {
          'X-HTTP-Method-Override': 'DELETE'
        }
      };
      return Auth.logout(config).then((function(oldUser) {
        $localStorage.currentAdmin = null;
        return $state.go('admin-login');
      }), function(error) {});
    };
  }
]);

app.controller('AdminLoginCtrl', [
  '$scope', '$state', 'Auth', '$ionicPopup', '$localStorage', function($scope, $state, Auth, $ionicPopup, $localStorage) {
    $scope.admin = {};
    return $scope.submit = function() {
      var config;
      config = {
        headers: {
          'X-HTTP-Method-Override': 'POST'
        }
      };
      return Auth.login($scope.admin, config).then((function(response) {
        $localStorage.currentAdmin = response;
        return $state.go('admin.register');
      }), function(error) {
        var alertPopup;
        return alertPopup = $ionicPopup.alert({
          title: 'Login failed!',
          template: 'Please check your credentials!'
        });
      });
    };
  }
]);

app.controller('ArticleCtrl', [
  '$scope', 'Article', function($scope, Article) {
    var init;
    $scope.loadArticles = function() {
      return Article.query(function(response) {
        return $scope.articles = response;
      });
    };
    $scope.toggleGroup = function(group) {
      if ($scope.isGroupShown(group)) {
        return $scope.shownGroup = null;
      } else {
        return $scope.shownGroup = group;
      }
    };
    $scope.isGroupShown = function(group) {
      return $scope.shownGroup === group;
    };
    init = function() {
      $scope.revenues = {};
      $scope.costs = {};
      $scope.translations = {};
      $scope.loans = {};
      return $scope.loadArticles();
    };
    return init();
  }
]);

app.controller('ArticleDetailCtrl', [
  '$scope', '$state', '$ionicPopup', '$stateParams', 'Article', 'articleTypes', function($scope, $state, $ionicPopup, $stateParams, Article, articleTypes) {
    var init;
    $scope.getArticle = function() {
      return Article.get({
        id: $stateParams.articleId
      }, function(response) {
        return $scope.article = response;
      });
    };
    $scope.deleteArticle = function(id) {
      var confirmPopup;
      confirmPopup = $ionicPopup.confirm({
        title: 'Видалення',
        template: 'Ви впевнені в своєму рішенні?'
      });
      return confirmPopup.then(function(response) {
        if (response) {
          return Article["delete"]({
            id: id
          }, function() {
            return $state.go('admin.article');
          });
        }
      });
    };
    $scope.updateArticle = function() {
      return Article.update($scope.article, function() {
        return $state.go('admin.article');
      });
    };
    init = function() {
      $scope.types = articleTypes;
      return $scope.getArticle();
    };
    return init();
  }
]);

app.controller('ArticleNewCtrl', [
  '$scope', '$state', 'Article', 'articleTypes', function($scope, $state, Article, articleTypes) {
    var init;
    $scope.saveArticle = function() {
      return Article.save($scope.article, function() {
        $scope.article.errors = {};
        return $state.go('admin.article');
      });
    };
    init = function() {
      $scope.article = {};
      return $scope.types = articleTypes;
    };
    return init();
  }
]);

app.controller('CalcCtrl', [
  '$scope', 'Tax', function($scope, Tax) {
    var init, percentToIndex;
    init = function() {
      $scope.data = {};
      $scope.data.salary = 0;
      $scope.data.exchange = 0;
      $scope.data.translation = 0;
      return Tax.edit(function(response) {
        return $scope.tax = response;
      });
    };
    percentToIndex = function(tax) {
      return 1 - tax / 100;
    };
    $scope.report = function() {
      var salaryAndTranslation, salaryWithCashTax, total;
      $scope.salaryHrn = $scope.data.salary * $scope.data.exchange;
      salaryAndTranslation = $scope.salaryHrn + $scope.data.translation;
      salaryWithCashTax = salaryAndTranslation / percentToIndex($scope.tax.cash);
      $scope.cashingTaxSum = salaryWithCashTax - salaryAndTranslation;
      $scope.singleTaxSum = salaryWithCashTax / percentToIndex($scope.tax.single) - salaryWithCashTax;
      total = salaryWithCashTax + $scope.tax.social + $scope.singleTaxSum;
      return $scope.total = total.toFixed(2).replace('.', ',');
    };
    return init();
  }
]);

app.controller('CounterpartyCtrl', [
  '$scope', 'Counterparty', function($scope, Counterparty) {
    var init;
    $scope.loadCounterparties = function() {
      return Counterparty.query(function(response) {
        return $scope.counterparties = response;
      });
    };
    $scope.toggleGroup = function(group) {
      if ($scope.isGroupShown(group)) {
        return $scope.shownGroup = null;
      } else {
        return $scope.shownGroup = group;
      }
    };
    $scope.isGroupShown = function(group) {
      return $scope.shownGroup === group;
    };
    init = function() {
      $scope.customers = {};
      $scope.vendors = {};
      $scope.others = {};
      $scope.HRs = {};
      return $scope.loadCounterparties();
    };
    return init();
  }
]);

app.controller('CounterpartyDetailCtrl', [
  '$scope', '$state', '$ionicPopup', '$stateParams', 'Counterparty', 'counterpartyTypes', function($scope, $state, $ionicPopup, $stateParams, Counterparty, counterpartyTypes) {
    var init;
    $scope.getCounterparty = function() {
      return Counterparty.get({
        id: $stateParams.counterpartyId
      }, function(response) {
        $scope.counterparty = response;
        $scope.counterparty.customer_id = $scope.counterparty.customer.id;
        $scope.counterparty.start_date = new Date($scope.counterparty.start_date);
        return $scope.activeCustomers = Counterparty.query({
          scope: 'active',
          group: 'Customer'
        });
      });
    };
    $scope.deleteCounterparty = function(id) {
      var confirmPopup;
      confirmPopup = $ionicPopup.confirm({
        title: 'Видалення',
        template: 'Ви впевнені в своєму рішенні?'
      });
      return confirmPopup.then(function(response) {
        if (response) {
          return Counterparty["delete"]({
            id: id
          }, function() {
            return $state.go('admin.counterparty');
          });
        }
      });
    };
    $scope.updateCounterparty = function() {
      return Counterparty.update($scope.counterparty, function() {
        return $state.go('admin.counterparty');
      });
    };
    $scope.isVendor = function() {
      var ref;
      return ((ref = $scope.counterparty) != null ? ref.type : void 0) === 'Vendor';
    };
    $scope.hasEmail = function() {
      var ref, ref1;
      return ((ref = $scope.counterparty) != null ? ref.type : void 0) === 'Vendor' || ((ref1 = $scope.counterparty) != null ? ref1.type : void 0) === 'HR';
    };
    init = function() {
      $scope.types = counterpartyTypes;
      return $scope.getCounterparty();
    };
    return init();
  }
]);

app.controller('CounterpartyNewCtrl', [
  '$scope', '$state', 'Counterparty', 'counterpartyTypes', function($scope, $state, Counterparty, counterpartyTypes) {
    var init;
    $scope.saveCounterparty = function() {
      return Counterparty.save($scope.counterparty, function() {
        $scope.counterparty.errors = {};
        return $state.go('admin.counterparty');
      });
    };
    $scope.isVendor = function() {
      var ref;
      return ((ref = $scope.counterparty) != null ? ref.type : void 0) === 'Vendor';
    };
    $scope.hasEmail = function() {
      var ref, ref1;
      return ((ref = $scope.counterparty) != null ? ref.type : void 0) === 'Vendor' || ((ref1 = $scope.counterparty) != null ? ref1.type : void 0) === 'HR';
    };
    init = function() {
      $scope.counterparty = {};
      $scope.types = counterpartyTypes;
      return $scope.activeCustomers = Counterparty.query({
        scope: 'active',
        group: 'Customer'
      });
    };
    return init();
  }
]);

app.controller('HolidaysCtrl', [
  '$scope', 'Holiday', function($scope, Holiday) {
    var init;
    init = function() {
      $scope.holiday = {};
      $scope.holiday.errors = {};
      $scope.currentYear = moment().format('YYYY');
      return $scope.holidays = Holiday.query({
        year: $scope.currentYear
      });
    };
    return init();
  }
]);

app.controller('HoursCtrl', [
  '$scope', 'Hours', 'Counterparty', '$localStorage', 'datepickerDecorator', 'hourDecorator', function($scope, Hours, Counterparty, $localStorage, datepickerDecorator, hourDecorator) {
    var init;
    datepickerDecorator($scope);
    hourDecorator($scope);
    init = function() {
      $scope.hour = {};
      $scope.hour.errors = {};
      $scope.hour.month = moment().format('MM-YYYY');
      $scope.getWorkingDays($scope.hour.month);
      $scope.$watch('workingDays', function(value) {
        return $scope.hour.hours = $scope.getWorkingHours();
      });
      $scope.vendor = $localStorage.currentVendor;
      $scope.hour.customer_id = $scope.vendor.customer_id;
      $scope.customers = Counterparty.customers({
        scope: 'active'
      });
      $scope.hours = Hours.query({
        vendor_id: $scope.vendor.id
      });
      return $scope.edit = false;
    };
    $scope.add = function() {
      return Hours.save($scope.hour, function(hour) {
        $scope.hours.push(hour);
        return $scope.hour.errors = {};
      }, function(response) {
        return $scope.hour.errors = response.data.error;
      });
    };
    $scope["delete"] = function(id, index) {
      return Hours["delete"]({
        id: id
      }, function() {
        return $scope.hours.splice(index, 1);
      });
    };
    $scope.update = function(hour_id, data) {
      return Hours.update({
        id: hour_id
      }, {
        hour: {
          hours: data
        }
      }, function() {}, function(response) {});
    };
    return init();
  }
]);

app.controller('RegisterCtrl', [
  '$scope', '$state', 'Register', function($scope, $state, Register) {
    var init;
    $scope.loadRegisters = function() {
      return Register.query(function(response) {
        return $scope.registers = response;
      });
    };
    init = function() {
      return $scope.loadRegisters();
    };
    return init();
  }
]);

app.controller('RegisterDetailCtrl', [
  '$scope', '$state', '$ionicPopup', '$stateParams', 'Register', function($scope, $state, $ionicPopup, $stateParams, Register) {
    var init;
    $scope.getRegister = function() {
      return Register.get({
        id: $stateParams.registerId
      }, function(response) {
        $scope.register = response;
        return $scope.register.date = new Date($scope.register.date);
      });
    };
    $scope.deleteRegister = function(id) {
      var confirmPopup;
      confirmPopup = $ionicPopup.confirm({
        title: 'Видалення',
        template: 'Ви впевнені в своєму рішенні?'
      });
      return confirmPopup.then(function(response) {
        if (response) {
          return Register["delete"]({
            id: id
          }, function() {
            return $state.go('admin.register');
          });
        }
      });
    };
    $scope.updateRegister = function() {
      return Register.update($scope.register, function() {
        return $state.go('admin.register');
      });
    };
    init = function() {
      return $scope.getRegister();
    };
    return init();
  }
]);

app.controller('RegisterNewCtrl', [
  '$scope', '$state', 'Register', function($scope, $state, Register) {
    $scope.register = {
      currency: 'UAH'
    };
    return $scope.saveRegister = function() {
      return Register.save($scope.register, function() {
        $scope.register.errors = {};
        return $state.go('admin.register');
      });
    };
  }
]);

app.controller('VendorLoginCtrl', [
  '$scope', '$state', '$auth', '$ionicPopup', '$localStorage', function($scope, $state, $auth, $ionicPopup, $localStorage) {
    $scope.vendor = {};
    return $scope.submit = function() {
      return $auth.login($scope.vendor).then(function(response) {
        $state.go('vendor-profile.hours');
        return $localStorage.currentVendor = response.data;
      })['catch'](function(error) {
        var alertPopup;
        return alertPopup = $ionicPopup.alert({
          title: 'Login failed!',
          template: 'Please check your credentials!'
        });
      });
    };
  }
]);

app.controller('VendorPasswordResetCtrl', [
  '$scope', function($scope) {
    return console.log("I'm in vendor password reset controller");
  }
]);

app.controller('VendorProfileCtrl', [
  '$scope', '$state', '$auth', '$ionicPopup', '$localStorage', function($scope, $state, $auth, $ionicPopup, $localStorage) {
    $scope.isAuthenticated = function() {
      return $auth.isAuthenticated();
    };
    return $scope.logout = function() {
      return $auth.logout().then(function() {
        $state.go('vendor-login');
        return $localStorage.currentVendor = null;
      });
    };
  }
]);

app.factory('datepickerDecorator', [
  function() {
    return function($scope) {
      var datePickerCallback;
      datePickerCallback = function(val) {
        if (val != null) {
          return $scope.hour.month = val.getMonth() + 1 + "/" + val.getFullYear();
        }
      };
      return $scope.datepicker = {
        titleLabel: 'Title',
        todayLabel: 'Today',
        closeLabel: 'Close',
        setLabel: 'Set',
        setButtonType: 'button-positive',
        todayButtonType: 'button-stable',
        closeButtonType: 'button-stable',
        inputDate: new Date(),
        mondayFirst: true,
        templateType: 'popup',
        showTodayButton: 'true',
        modalHeaderColor: 'bar-stable',
        modalFooterColor: 'bar-stable',
        dateFormat: 'MM-yyyy',
        closeOnSelect: true,
        callback: function(val) {
          return datePickerCallback(val);
        }
      };
    };
  }
]);

app.factory('hourDecorator', [
  'Hours', 'WorkDay', function(Hours, WorkDay) {
    return function($scope) {
      $scope.getWorkingDays = function(value) {
        return WorkDay.get({
          date: value
        }, function(response) {
          return $scope.workingDays = response.count;
        });
      };
      return $scope.getWorkingHours = function() {
        return $scope.workingHours = $scope.workingDays * 8;
      };
    };
  }
]);

app.factory('Register', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/registers/:id', {
      id: '@id'
    }, {
      update: {
        method: 'PUT'
      }
    });
  }
]);

app.factory('Article', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/articles/:id', {
      id: '@id'
    }, {
      update: {
        method: 'PUT'
      }
    });
  }
]);

app.factory('Vendor', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/vendor_login/:id.json', {
      id: '@id'
    }, {
      update: {
        method: 'PUT'
      }
    });
  }
]);

app.factory('Tax', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/tax/', {
      id: '@id'
    }, {
      edit: {
        url: apiEndpoint + '/tax/edit',
        method: 'GET',
        isArray: false
      }
    });
  }
]);

app.factory('Hours', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/hours/:id/:action', {
      id: '@id'
    }, {
      update: {
        method: 'PUT'
      }
    });
  }
]);

app.factory('Counterparty', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/counterparties/:id/:action', {
      id: '@id'
    }, {
      customers: {
        method: 'GET',
        params: {
          action: 'customers'
        },
        isArray: true
      },
      update: {
        method: 'PUT'
      }
    });
  }
]);

app.factory('WorkDay', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/work_days/');
  }
]);

app.factory('Holiday', [
  '$resource', 'apiEndpoint', function($resource, apiEndpoint) {
    return $resource(apiEndpoint + '/holidays/:id/:action', {
      id: '@id'
    }, {
      update: {
        method: 'PUT'
      }
    });
  }
]);
