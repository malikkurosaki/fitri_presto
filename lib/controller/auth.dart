import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth{
  Map<String,dynamic> _auth;
  Map get auth => _auth;
  set auth(Map value) => _auth = value;

  setAuth(value)async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    prf.setString('auth', jsonDecode(value).toString());
  }

  Future<Map<String,dynamic>> getAuth()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    return jsonDecode(prf.getString('auth'));
  }

  update()async{
    SharedPreferences prf = await SharedPreferences.getInstance();
    _auth = jsonDecode(prf.getString('auth'));
  }

}