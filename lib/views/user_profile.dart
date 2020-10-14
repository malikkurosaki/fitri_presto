import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatelessWidget {
  final Map user;

  const UserProfile({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Text(user['name']),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: ()async{
                  final prf = await SharedPreferences.getInstance();
                  prf.clear();
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: Text('LOGOUT'),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(user['email']),
          )
        ],
      ),
    );
  }
}