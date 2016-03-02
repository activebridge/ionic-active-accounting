app.factory 'datepickerDecorator', [() ->
  ($scope) ->
    datePickerCallback = (val) ->
      if val?
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
      dateFormat: 'MM-yyyy',
      closeOnSelect: true,
      callback: (val) ->
        datePickerCallback(val)
    }
]
