import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("25 nov - tambah token")
              ],
            ),
          ),
        ),
      ),
    );
  }
}