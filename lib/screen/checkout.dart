import 'package:flutter/material.dart';
import 'package:first_task/bloc/cart_item.dart';
import 'package:first_task/widgets/snackBar.dart';

class Checkout extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: StreamBuilder(
        stream: bloc.getStream,
        initialData: bloc.allItems,
        builder: (context, snapshot) {
          print(snapshot.data.toString().length);
          return snapshot.data.toString().length > 15
              ? Column(
                  children: <Widget>[
                    /// The [checkoutListBuilder] has to be fixed
                    /// in an expanded widget to ensure it
                    /// doesn't occupy the whole screen and leaves
                    /// room for the the RaisedButton
                    Expanded(child: checkoutListBuilder(snapshot)),
                    SizedBox(height: 40)
                  ],
                )
              : Center(
                  child: Text("You haven't taken any item yet"),
                );
        },
      ),
    );
  }
}

Widget checkoutListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["cart item"].length,
    itemBuilder: (BuildContext context, i) {
      final cartList = snapshot.data["cart item"];
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //SizedBox(width: 10),
            Container(
              width: 100,
              height: 100,
              child: Image.network(cartList[i]['url']),
            ),
            //SizedBox(width: 10),
            Text(cartList[i]['name']),
            IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                bloc.removeFromCart(cartList[i]);
                SnackBarPage()
                    .showSnackBar(context, "deleted succesfully from cart");
              },
            ),
          ],
        ),
      );
    },
  );
}
