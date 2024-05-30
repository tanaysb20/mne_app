import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mne/Reusable%20components/text_field.dart';

class MyEntryScreen extends StatefulWidget {
  const MyEntryScreen({super.key});

  @override
  State<MyEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<MyEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.0.w),
          child: SingleChildScrollView(
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
                      "My Entry",
                      style: textFieldStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          weight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(width: 20.w),
                  ],
                ),
                SizedBox(height: 20.h),
                MyEntriesItem(),
                MyEntriesItem(),
                MyEntriesItem(),
                MyEntriesItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget MyEntriesItem() {
  return Container(
    margin: EdgeInsets.only(bottom: 14.h),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xffEE2631)),
        borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: Image.asset("assets/calendar.png"),
            ),
            SizedBox(width: 20.w),
            Container(
              child: Text(
                "Date: 18/10/2021",
                style: textFieldStyle(fontSize: 17.sp, weight: FontWeight.w500),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Image.asset("assets/editentry.png"),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              child: Image.asset("assets/person.png"),
            ),
            SizedBox(width: 20.w),
            Container(
              child: Text(
                "Party Name: Sunil Yadav",
                style: textFieldStyle(fontSize: 17.sp, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              child: Image.asset("assets/homeicon.png"),
            ),
            SizedBox(width: 20.w),
            Container(
              child: Text(
                "Material Centre: YARD - APMC",
                style: textFieldStyle(fontSize: 17.sp, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset("assets/tag.png"),
                ),
                SizedBox(width: 20.w),
                Container(
                  child: Text(
                    "Mark: ABC",
                    style: textFieldStyle(
                        fontSize: 17.sp, weight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Container(
                  child: Image.asset("assets/ticket.png"),
                ),
                SizedBox(width: 20.w),
                Container(
                  child: Text(
                    "SL. No. 31",
                    style: textFieldStyle(
                        fontSize: 17.sp, weight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              child: Image.asset("assets/bag.png"),
            ),
            SizedBox(width: 20.w),
            Container(
              child: Text(
                "No. Of Bags: 10",
                style: textFieldStyle(fontSize: 17.sp, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              child: Image.asset("assets/rs.png"),
            ),
            SizedBox(width: 20.w),
            Container(
              child: Text(
                "Rate: Rs. 15",
                style: textFieldStyle(fontSize: 17.sp, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              child: Image.asset("assets/kg.png"),
            ),
            SizedBox(width: 20.w),
            Container(
              child: Text(
                "Net Weight: 123 KG",
                style: textFieldStyle(fontSize: 17.sp, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    ),
  );
}
