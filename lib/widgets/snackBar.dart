import 'package:flutter/material.dart';

class SnackBarPage extends StatelessWidget {
  String? name;

  SnackBarPage({@required this.name});

  showSnackBar(context, name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: showSnackBar(context, name),
    );
  }
}
