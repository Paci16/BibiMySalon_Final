//database_service.dart
import 'dart:developer';
import 'package:bibimysalon_klmpk6/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final _fire = FirebaseFirestore.instance;
  create(User user){
    try{
      _fire.collection("users").add({
        "email": user.email, "telephone":user.telephone, "username":user.username, "password":user.password
      });
    }catch(e){
      log(e.toString());
    }
  }
}

