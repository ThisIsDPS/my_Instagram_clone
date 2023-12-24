import 'package:flutter/widgets.dart';
import 'package:instagram_app_flutter/models/user.dart';
import 'package:instagram_app_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    // Getting the 'User' type object
    User user = await _authMethods.getUserDetails();
    // Assigning this to our global variable
    _user = user;
    // Notifies all the listners to this 'UserProvider' class that the data of our global variable '_user' has changed, so you need to update your value
    notifyListeners(); 
  }
}