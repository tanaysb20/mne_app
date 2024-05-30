import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mne/Provider/auth_provider.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/My%20Entries/my_entries_screen.dart';
import 'package:mne/Screens/New%20Entry/new_entry_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              SizedBox(height: 40.h),
              Center(
                  child: Image.asset(
                "assets/mneicon.png",
                height: 70.h,
                width: 130.w,
                fit: BoxFit.fill,
              )),
              SizedBox(height: 30.h),
              Text(
                "Hello,",
                style: textFieldStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    weight: FontWeight.w400),
              ),
              Text(
                "${item.user?.name ?? ""}!",
                style: textFieldStyle(
                    color: Color(0xffEE2631),
                    fontSize: 32.sp,
                    weight: FontWeight.w700),
              ),
              SizedBox(height: 40.h),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NewEntryScreen();
                    },
                  ));
                },
                child: Container(
                    width: double.infinity,
                    child:
                        Image.asset("assets/newentry.png", fit: BoxFit.cover)),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return MyEntryScreen();
                    },
                  ));
                },
                child: Container(
                    width: double.infinity,
                    child:
                        Image.asset("assets/entries.png", fit: BoxFit.cover)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
