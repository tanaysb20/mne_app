import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mne/Provider/entry_provider.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/party/widgets/party_card_widget.dart';
import 'package:provider/provider.dart';

class PartyAddUpdateScreen extends StatefulWidget {
  const PartyAddUpdateScreen({super.key});

  @override
  State<PartyAddUpdateScreen> createState() => _PartyAddUpdateScreenState();
}

class _PartyAddUpdateScreenState extends State<PartyAddUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EntryProvider>(builder: (context, state, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
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
                        "Party Details",
                        style: textFieldStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            weight: FontWeight.bold),
                      ),
                      Spacer(),
                      SizedBox(width: 20.w),
                    ],
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "PARTY NAME",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Color(0xffEE2631),
                        )),
                    child: TextFormField(
                      controller: state.partyName,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "PARTY EMAIL",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Color(0xffEE2631),
                        )),
                    child: TextFormField(
                      controller: state.partyEmail,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "PARTY PHONE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Color(0xffEE2631),
                        )),
                    child: TextFormField(
                      controller: state.partyPhone,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "PARTY CITY",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Color(0xffEE2631),
                        )),
                    child: TextFormField(
                      controller: state.partyCity,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      state.savePartyDetails(context: context);
                    },
                    child: Container(
                        width: double.maxFinite,
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Color(0xffEE2631),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xffEE2631),
                            )),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        )),
                  ),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
