
App = angular.module('watchlist', [])

App.controller "Watchlist", [
    "$scope", ($scope) ->

        $scope.timeout = {}
        $scope.stocks = [
            {name: "CERN"},
            {name: "CPB"},
            {name: "EXC"},
            {name: "VZ"},
            {name: "KR"},
            {name: "BIIB"},
            {name: "SVU"},
        ]

        if window.localStorage and window.localStorage != null
            # use localStorage for holding our watchlist
            local_storage_mode = on

            # if there are any stocks in local storage, load them
            if localStorage['stocks']
                $scope.stocks = angular.fromJson localStorage['stocks']

        # Preselect the first stock.
        $scope.selected_stock = $scope.stocks[0]

        $scope.next_stock = ->
            if $scope.selected_stock
                current_index = $scope.stocks.indexOf $scope.selected_stock
                next_index = (current_index + 1) % $scope.stocks.length
                $scope.showStock next_index

        $scope.save_watchlist = ->
            if local_storage_mode
                # if localStorage is available, save the watchlist.
                localStorage['stocks'] = angular.toJson $scope.stocks
            # if not, we can't save them

        $scope.formatStockAdd = ->
            # Normalize stock symbols as they're typed.
            $scope.stock_to_add = $scope.stock_to_add.replace(" ", "").toUpperCase()

        $scope.addStock = ->
            # Check if the stock is already in the list, if not, add it and select it.
            existing = _.findWhere($scope.stocks, name: $scope.stock_to_add)
            if not existing
                len = $scope.stocks.push name: $scope.stock_to_add
                $scope.selected_stock = $scope.stocks[len - 1]

            $scope.stock_to_add = ""
            $scope.save_watchlist()

        $scope.removeStock = ($index) ->
            stock = $scope.stocks[$index]
            if stock == $scope.selected_stock
                # if the stock to be removed is currently selected, select the first stock
                $scope.selected_stock = $scope.stocks[0]
            # Remove the stock
            $scope.stocks.splice($index, 1)
            $scope.save_watchlist()
            

        $scope.showStock = ($index, $event) ->
            $scope.selected_stock = $scope.stocks[$index]
            unless not $event
                $event.preventDefault()

    ]
