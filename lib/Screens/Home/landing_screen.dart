import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Provider/auth_provider.dart';
import 'package:mne/Provider/entry_provider.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/Details/my_detail_screen.dart';
import 'package:mne/Screens/Home/home_screen.dart';
import 'package:mne/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    Provider.of<AuthProvider>(context, listen: false)
        .getUserDetails()
        .then((value) async {
      await Provider.of<EntryProvider>(context, listen: false).getEntryList();
      await Provider.of<EntryProvider>(context, listen: false).getPartyList();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<AuthProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xffEE2631)))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    // Row(
                    //   children: [
                    //     InkWell(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: Image.asset("assets/back.png")),
                    //   ],
                    // ),
                    SizedBox(height: 30.h),
                    Text(
                      item.user?.name ?? "",
                      style: textFieldStyle(
                          color: Colors.black,
                          fontSize: 23.sp,
                          weight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "+91 ${item.user?.phoneNumber ?? ""}",
                      style: textFieldStyle(
                          color: Colors.grey.shade600, fontSize: 17.sp),
                    ),
                    SizedBox(height: 40.h),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      },
                      child: ListTile(
                        leading: Image.asset("assets/home.png"),
                        title: Text(
                          "Home",
                          style: textFieldStyle(
                              color: Colors.black, fontSize: 17.sp),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Colors.black, size: 19.sp),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return MyDetailsScreen();
                          },
                        ));
                      },
                      child: ListTile(
                        leading: Image.asset("assets/details.png"),
                        title: Text(
                          "My Details",
                          style: textFieldStyle(
                              color: Colors.black, fontSize: 17.sp),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Colors.black, size: 19.sp),
                      ),
                    ),
                    Divider(),
                    Spacer(),
                    SizedBox(
                      height: 57.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xffF2F3F2),
                          ), // Set your desired button color here
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
