import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app_flutter/models/user.dart' as model;
import 'package:instagram_app_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user details (.......) [Used in providers/user_provider.dart]
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    // 'fromSnap' method from models/user.dart
    return model.User.fromSnap(documentSnapshot);
  }

  // Sign Up User ~ Function to add user sign up credentials to firebase storage
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // Registering User in auth with Email & Password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        // getting the url of the file (here, profile pic) from our user defined function created in 'storage_methods.dart'
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // In user.dart file
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // Adding User to our Database
        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());

        // -------- OR ---------

        // Adding User to our Database
        // await _firestore.collection("users").add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    }
    /*****  You can use this if you want to  *****/
    // on FirebaseAuthException catch(err){
    //   if(err.code == 'invalid-email'){
    //     res = "The email address is badly formatted";
    //   }
    //   else if(err.code == 'weak-password'){
    //     res = "Password should be at least 6 characters";
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logging In User Function, similar to Above Sign Up User function
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } 
    /*****  You can use this if you want to  *****/
    // on FirebaseAuthException catch(err){
    //   if(err.code == 'user-not-found'){
    //     res = "The user does not exist";
    //   }
    // }
    catch (err) {
      return err.toString();
    }
    return res;
  }
}
