import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  // Instantiating the Image_Picker package
  final ImagePicker _imagePicker = ImagePicker();

  // The selected image is stored in _file
  XFile? _file = await _imagePicker.pickImage(source: source); 

  if(_file != null){
    // 'readAsBytes()' returns Future & Its return type is <Uint8List>
    return await _file.readAsBytes(); 
  }
  // If File is NULL
  print('No Image Selected');
}


// For displaying snackbars (One of it using in 'signup_screen.dart' during invalid credentials)
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}