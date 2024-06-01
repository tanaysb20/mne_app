import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Provider/auth_provider.dart';
import 'package:mne/Reusable%20components/custom_button.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<AuthProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/back.png")),
                  Spacer(),
                  Text(
                    "My Details",
                    style: textFieldStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        weight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(width: 20.w),
                ],
              ),
              SizedBox(height: 70.h),
              CustomDetais("Name", item.user?.name ?? ""),
              SizedBox(height: 26.h),
              CustomDetais(
                  "Mobile Number", "+91 ${item.user?.phoneNumber ?? ""}"),
              SizedBox(height: 26.h),
              CustomDetais("City", item.user?.name ?? ""),
              SizedBox(height: 26.h),
              CustomDetais("Email", item.user?.email ?? ""),
              SizedBox(height: 26.h),
              Spacer(),
              SizedBox(
                height: 57.h,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xffF2F3F2),
                    ), // Set your desired button color here
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set your desired border radius here
                      ),
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                    var partyBox = Hive.box<PartyModel>('partyBox');
                    await partyBox.deleteAll(partyBox.keys);
                    var entryBox = Hive.box<PartyModel>('entryBox');
                    await entryBox.deleteAll(entryBox.keys);
                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return MyApp();
                          },
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      Spacer(),
                      Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 70.h),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CustomDetais(String text1, String text2) {
  return Row(
    children: [
      Container(
          width: 150.w,
          child: Text(
            text1,
            style: textFieldStyle(color: Colors.grey.shade600, fontSize: 17.sp),
          )),
      Expanded(
          child: Text(
        text2,
        style: textFieldStyle(color: Colors.black, fontSize: 17.sp),
      )),
    ],
  );
}
