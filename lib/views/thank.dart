import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Thank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BackButton(),
              Text("apa kabar"),
            ],
          ),
        ),
      ),
    );
  }
}