import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mne/Provider/auth_provider.dart';
import 'package:mne/Reusable%20components/custom_button.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/Home/landing_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<AuthProvider>(context, listen: true);
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: isloading
              ? Center(
                  child: CircularProgressIndicator(color: Color(0xffEE2631)))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.h),
                      Center(child: Image.asset("assets/mneicon.png")),
                      SizedBox(height: 90.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Log In",
                              style: textFieldStyle(
                                  color: Colors.black, fontSize: 23.sp),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "Enter your username and password",
                              style: textFieldStyle(
                                  color: Colors.grey, fontSize: 15.sp),
                            ),
                            SizedBox(height: 40.h),
                            CustomTextField(
                              controller: userNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username number can\'t be empty';
                                }
                                return null;
                              },
                              margin: false,
                              hintText: "Username",
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              controller: passwordController,
                              margin: false,
                              hintText: "Password",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password can\'t be empty';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            SizedBox(height: 70.h),
                            CustomButtonScreen(
                              bgcolor: Color(0xffEE2631),
                              fun: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  bool check = await item.sendOtp(
                                      userNameController.value.text,
                                      passwordController.value.text);
                                  setState(() {
                                    isloading = false;
                                  });
                                  if (check) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return LandingScreen();
                                      },
                                    ));
                                  }
                                }
                              },
                              color: Colors.white,
                              text1: "Login",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
