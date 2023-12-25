import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods{
  // Similar to what we did in 'auth_methods.dart'
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to add images to firebase storage (For storing both, profile pic & posts)
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {

    // ref is reference to where file is or has to be created(currently null) in firebase (childName/uid/<image>)
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if(isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // uploading the file
    UploadTask uploadTask =  ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    // getting downloadUrl of the file that has been uploaded
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

