PlacesAndThings
.controller('CartCtrl', ['$scope', '$rootScope', '$http', 'CartService',
  function($scope, $rootScope, $http, CartService) {

    var cart = $scope;

    cart.current_cart = [];
    $rootScope.totalItems = "";
    

     cart.updateCart = function(){

      CartService.retrieveCart()
    .then(function(response) {
      cart.current_cart = response.data;
      $rootScope.totalItems = totalItems();

    })};

    var totalItems = function() {
      var totalItems = 0;
      for(var i=0; i<cart.current_cart.length; i++){
        totalItems = totalItems + cart.current_cart[i].quantity
      }
      return totalItems;
    }

          $scope.changeItemQuantity = function(product, value) {
      $http.post('api/store/change_cart_product_quantity', {product_id: product.id, change: value})
      .then(function(response) {
        cart.updateCart();
        
      });
    }
      cart.updateCart();
  }]);