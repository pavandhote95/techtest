import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackerkernal/controllers/login_controller.dart';

  // Update this import

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      duration: Duration(milliseconds: 1000),
                      child: Image.asset(
                        'assets/images/login.png',
                        height: 290,
                        width: double.infinity,
                      ),
                    ),
                    FadeInDown(
                      duration: Duration(milliseconds: 1000),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInDown(
                      duration: Duration(milliseconds: 1000),
                      child: TextFormField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Icon(
                              Icons.alternate_email,
                              color: Colors.grey,
                              size: 22,
                            ),
                          ),
                          labelText: "Email ID",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (_) {
                          controller.passwordFocusNode.requestFocus();
                        },
                      ),
                    ),
                    FadeInDown(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        margin: const EdgeInsets.only(left: 40),
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInDown(
                      duration: Duration(milliseconds: 1000),
                      child: TextFormField(
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocusNode,
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Image.asset(
                              'assets/images/lock.png',
                              width: 21,
                              height: 21,
                              color: Colors.grey,
                            ),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          suffixIcon: Obx(() => IconButton(
                            icon: Icon(
                              color: Colors.grey,
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                          )),
                          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    FadeInDown(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        margin: const EdgeInsets.only(left: 40),
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInDown(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                       // Navigate to Forgot Password Page
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: Obx(() => ElevatedButton(
                      onPressed: controller.isLoading.value ? null : () async {
        // Pass context if needed inside login function
        await controller.login(context); // Make sure to pass context if required
      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 27, 101, 250),
                            disabledBackgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3.0,
                                  ),
                                )
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('OR'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F6F7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: double.infinity,
                        height: 44,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Image.asset(
                                  'assets/images/Google.png',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              const Text(
                                "Login with Google",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "New to Logistics? ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 125, 124, 124)),
                          ),
                          GestureDetector(
                            onTap: () {
                      // Navigate to Registration Page
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
