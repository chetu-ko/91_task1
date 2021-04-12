import 'dart:async';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  /// The [allItems] Map would hold all the data this bloc provides
  final Map allItems = {
    'cart item': []
  };
  /// [addToCart] adds items from the shop to the cart
  void addToCart(item) {
    allItems['cart item'].add(item);
    cartStreamController.sink.add(allItems);
  }

  /// [removeFromCart] removes items from the cart, back to the shop
  void removeFromCart(item) {
    allItems['cart item'].remove(item);
    cartStreamController.sink.add(allItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();