//buat wadah autentifikasi
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Login failed: $e");
      throw e; // Rethrow the exception to be handled in the UI
    }
  }

  Future<void> signout() async{
    try{
      await _auth.signOut();
    }catch(e){
      log("Something went wrong");
    }
  }
}