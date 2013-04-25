
App = angular.module('watchlist', [])

App.controller "Watchlist", [
    "$scope", ($scope) ->
        $scope.stocks = [
            {name: "AAPL"},
            {name: "CERN"}
        ]

        $scope.formatStockAdd = ->
            $scope.stock_to_add = $scope.stock_to_add.replace(" ", "").toUpperCase()

        $scope.addStock = ->
            $scope.stocks.push name: $scope.stock_to_add
            $scope.stock_to_add = ""

        $scope.removeStock = ($index) ->
            $scope.stocks.splice($index, 1)
            no

        $scope.showStock = ($index) ->
            $scope.selected_stock = $scope.stocks[$index]

    ]
