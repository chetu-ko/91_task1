import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_task/service/firbase.dart';
import 'package:first_task/bloc/cart_item.dart';
import 'package:first_task/widgets/snackBar.dart';

class LoadData extends StatefulWidget {
  @override
  LoadDataState createState() => LoadDataState();
}

class LoadDataState extends State<LoadData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Images').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        return snapshot.data!.docs.length > 0
            ? ListView(
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //SizedBox(width: 10),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(document['url'], scale: 1),
                          ),
                          //SizedBox(width: 10),
                          Text(document['name']),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.shopping_cart,
                                      color: Colors.lightBlueAccent, size: 20),
                                  onPressed: () {
                                    bloc.addToCart(document);
                                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to cart"),));
                                    SnackBarPage()
                                        .showSnackBar(context, "added to cart");
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.highlight_remove,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    FirebaseHandel().DeleteData(document);
                                    SnackBarPage().showSnackBar(
                                        context, "deleted succesfully");
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              )
            : Center(
                child: Text("There is no Data to show"),
              );
      },
    );
  }
}
