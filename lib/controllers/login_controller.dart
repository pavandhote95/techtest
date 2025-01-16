// login_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackerkernal/services/services.dart';
import 'package:hackerkernal/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import the ApiService

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  final ApiService _apiService = ApiService(); // Instantiate ApiService

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showToast("Email and Password cannot be empty!");
      return;
    }

    if (!_emailValid(email)) {
      _showToast("Please enter a valid email!");
      return;
    }

    if (!_passwordValid(password)) {
      _showToast("Password should be at least 6 characters!");
      return;
    }

    isLoading.value = true;

    final response = await _apiService.login(email, password); // Use ApiService to handle login

    if (response['error'] == null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      _showToast("Login successful!", backgroundColor: Colors.green);

      // Dismiss the keyboard before navigation
      FocusScope.of(context).unfocus();

      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      _showToast(response['error']); // Show the error message from the API
    }

    isLoading.value = false;
  }

  bool _emailValid(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(email);
  }

  bool _passwordValid(String password) {
    return password.length >= 6;
  }

  void _showToast(String message, {Color backgroundColor = Colors.red}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
