import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Provider/entry_provider.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/party/screens/party_add_update_screen.dart';
import 'package:provider/provider.dart';

class PartyCardWidget extends StatelessWidget {
  final PartyModel party;

  const PartyCardWidget({super.key, required this.party});

  @override
  Widget build(BuildContext context) {
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
              Icon(
                Icons.person_outline,
                size: 18,
                color: Color(0xffEE2631),
              ),
              SizedBox(width: 16),
              Container(
                child: Text(
                  "${party.partyName}",
                  style:
                      textFieldStyle(fontSize: 17.sp, weight: FontWeight.w700),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Provider.of<EntryProvider>(context, listen: false)
                      .initPartyEdit(party: party);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PartyAddUpdateScreen()));
                },
                child: Image.asset("assets/editentry.png"),
              )
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                size: 18,
                color: Color(0xffEE2631),
              ),
              SizedBox(width: 16),
              Container(
                child: Text(
                  "${party.email}",
                  style: textFieldStyle(fontSize: 15, weight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 18,
                color: Color(0xffEE2631),
              ),
              SizedBox(width: 16),
              Container(
                child: Text(
                  "${party.phoneNumber}",
                  style: textFieldStyle(fontSize: 15, weight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_city,
                size: 18,
                color: Color(0xffEE2631),
              ),
              SizedBox(width: 16),
              Container(
                child: Text(
                  "${party.city}",
                  style: textFieldStyle(fontSize: 15, weight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
