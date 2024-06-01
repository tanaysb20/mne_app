import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mne/Modals/entry.dart';
import 'package:mne/Provider/entry_provider.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/New%20Entry/new_entry_screen.dart';
import 'package:provider/provider.dart';

class MyEntryScreen extends StatefulWidget {
  const MyEntryScreen({super.key});

  @override
  State<MyEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<MyEntryScreen> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<EntryProvider>(builder: (context, state, child) {
      return RefreshIndicator(
        onRefresh: () async {
          state.getEntryList();
        },
        child: SafeArea(
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
                        onChanged: (str) {
                          setState(() {});
                        },
                        controller: search,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search"),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ...state.entryList
                        .where((element) =>
                            ((element.party?.partyName ?? "")
                                .toLowerCase()
                                .contains(search.text.toLowerCase())) ||
                            ((element.materialCenter ?? "")
                                .toLowerCase()
                                .contains(search.text.toLowerCase())) ||
                            ((element.materialCenterText ?? "")
                                .toLowerCase()
                                .contains(search.text.toLowerCase())) ||
                            ((element.mark ?? "")
                                .toLowerCase()
                                .contains(search.text.toLowerCase())))
                        .map((e) => MyEntriesItem(e, context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget MyEntriesItem(EntryModel entry, BuildContext context) {
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
                "Date: ${DateFormat("dd/MM/yyyy").format(DateTime.tryParse(entry.date!) ?? DateTime.now())}",
                style: textFieldStyle(fontSize: 14.sp, weight: FontWeight.w500),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Provider.of<EntryProvider>(context, listen: false)
                    .initEntryEdit(entry: entry);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return NewEntryScreen();
                  },
                ));
              },
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
                "Party Name: ${entry.party!.partyName!}",
                style: textFieldStyle(fontSize: 14.sp, weight: FontWeight.w500),
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
                "Material Centre: ${entry.materialCenter}${entry.materialCenterText == null ? "" : (" - " + entry.materialCenterText.toString())}",
                style: textFieldStyle(fontSize: 14.sp, weight: FontWeight.w500),
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
                  child: Image.asset("assets/bag.png"),
                ),
                SizedBox(width: 20.w),
                Container(
                  child: Text(
                    "No. Of Bags: ${entry.noOfBags!}",
                    style: textFieldStyle(
                        fontSize: 14.sp, weight: FontWeight.w500),
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
                    "SL. No. ${entry.sNo!}",
                    style: textFieldStyle(
                        fontSize: 14.sp, weight: FontWeight.w500),
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
              child: Image.asset("assets/tag.png"),
            ),
            SizedBox(width: 20.w),
            Container(
              child: Text(
                "Mark: ${entry.mark!}",
                style: textFieldStyle(fontSize: 14.sp, weight: FontWeight.w500),
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
                "Rate: Rs. ${entry.ratePerQuintal!}/Quintal",
                style: textFieldStyle(fontSize: 14.sp, weight: FontWeight.w500),
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
                "Net Weight: ${entry.netWeight!} KG",
                style: textFieldStyle(fontSize: 14.sp, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    ),
  );
}
