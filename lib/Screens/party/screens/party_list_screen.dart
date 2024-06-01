import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mne/Provider/entry_provider.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/party/screens/party_add_update_screen.dart';
import 'package:mne/Screens/party/widgets/party_card_widget.dart';
import 'package:provider/provider.dart';

class PartyListScreen extends StatefulWidget {
  const PartyListScreen({super.key});

  @override
  State<PartyListScreen> createState() => _PartyListScreenState();
}

class _PartyListScreenState extends State<PartyListScreen> {
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
                        "Party List",
                        style: textFieldStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            weight: FontWeight.bold),
                      ),
                      Spacer(),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 23),
                  ...state.partyList.map(
                    (e) => PartyCardWidget(
                      party: e,
                    ),
                  ),
                  if (state.partyList.isEmpty)
                    Text(
                      "Party List is Empty",
                      style: TextStyle(color: Colors.grey),
                    ),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: Color(0xffEE2631),
              )),
          onPressed: () {
            Provider.of<EntryProvider>(context, listen: false).initPartyEdit();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PartyAddUpdateScreen()));
          },
          child: Icon(
            Icons.add,
            color: Color(0xffEE2631),
          ),
        ),
      );
    });
  }
}
