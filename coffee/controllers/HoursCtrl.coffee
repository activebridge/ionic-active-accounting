app.controller 'HoursCtrl', ['$scope', 'Hours', 'Counterparty', '$localStorage', ($scope, Hours, Counterparty, $localStorage, $ionicPopup) ->
  datePickerCallback = (val) ->
    if typeof(val) != 'undefined'
      $scope.hour.month = val.getMonth() + 1 + "/" + val.getFullYear()

  $scope.datepicker = {
    titleLabel: 'Title',
    todayLabel: 'Today',
    closeLabel: 'Close',
    setLabel: 'Set',
    setButtonType : 'button-positive',
    todayButtonType : 'button-stable',
    closeButtonType : 'button-stable',
    inputDate: new Date(),
    mondayFirst: true,
    templateType: 'popup',
    showTodayButton: 'true',
    modalHeaderColor: 'bar-stable',
    modalFooterColor: 'bar-stable',
    callback: (val) ->
      datePickerCallback(val)
    ,
    dateFormat: 'MM-yyyy',
    closeOnSelect: true,
  }

  $scope.hour = {}
  $scope.hour.errors = {}
  $scope.hour.month = moment().format('MM-YYYY')
  $scope.customers = Counterparty.customers(scope: 'active')
  $scope.edit = false

  init = ->
    $scope.vendor = $localStorage.currentVendor
    $scope.hours = Hours.query(vendor_id: $scope.vendor.id)

  $scope.add = ->
    hour = Hours.save($scope.hour,
      () ->
        $scope.hours.push(hour)
        $scope.hour.errors = {}
      (response) ->
        $scope.hour.errors = response.data.error
    )

  $scope.delete = (hour_id, index) ->
    Hours.delete
      id: hour_id
    , (success) ->
      $scope.hours.splice(index,1)

  $scope.update = (hour_id, data) ->
    Hours.update( id: hour_id, { hour: { hours: data } }
      () ->
      (response) ->

    )

  init()
]
