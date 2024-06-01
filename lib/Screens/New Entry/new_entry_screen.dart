import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Provider/entry_provider.dart';
import 'package:mne/Reusable%20components/text_field.dart';
import 'package:mne/Screens/party/screens/party_list_screen.dart';
import 'package:provider/provider.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
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
                        "New Entry",
                        style: textFieldStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            weight: FontWeight.bold),
                      ),
                      Spacer(),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 55),

                  ///----------------------
                  // Text(
                  //   "TAKE A PHOTO",
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(14),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black.withOpacity(0.15),
                  //               blurRadius: 4,
                  //               offset: Offset(0, 4),
                  //             ),
                  //           ],
                  //           border: Border.all(
                  //             color: Color(0xffEE2631),
                  //           )),
                  //       child: Icon(
                  //         Icons.camera_alt_rounded,
                  //         color: Color(0xffEE2631),
                  //         size: 20,
                  //       ),
                  //     ),
                  //     SizedBox(width: 18),
                  //     Expanded(
                  //       child: Container(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 20, vertical: 16),
                  //           decoration: BoxDecoration(
                  //             color: Color(0xffE6E6E6),
                  //             borderRadius: BorderRadius.circular(14),
                  //           ),
                  //           child: Center(
                  //             child: Text(
                  //               "Take Photo",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w900,
                  //               ),
                  //             ),
                  //           )),
                  //     ),
                  //     SizedBox(width: 18),
                  //     Container(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  //       decoration: BoxDecoration(
                  //         color: Color(0xffE6E6E6),
                  //         borderRadius: BorderRadius.circular(14),
                  //       ),
                  //       child: Icon(
                  //         Icons.delete,
                  //         color: Color(0xff3D3D3D),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "DATE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      state.updateDate(context);
                    },
                    child: Container(
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
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                        controller: TextEditingController(
                            text: DateFormat().format(state.entryDate)),
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.watch_later_outlined,
                              color: Color(0xffEE2631),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
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

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
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
                          child: DropdownButton<PartyModel>(
                            value: state.entryParty,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black,
                            ),
                            // selectedItemBuilder: (context) => [
                            //   Text(
                            //     state.entryParty!.partyName.toString(),
                            //   ),
                            // ],
                            elevation: 16,
                            isDense: true,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            onChanged: (PartyModel? value) {
                              state.updateParty(value!);
                            },
                            items: state.partyList
                                .map<DropdownMenuItem<PartyModel>>(
                                    (PartyModel value) {
                              return DropdownMenuItem<PartyModel>(
                                value: value,
                                child: Text(value.partyName.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // SizedBox(width: 18),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => PartyListScreen()));
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 20, vertical: 16),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(14),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.black.withOpacity(0.15),
                      //             blurRadius: 4,
                      //             offset: Offset(0, 4),
                      //           ),
                      //         ],
                      //         border: Border.all(
                      //           color: Color(0xffEE2631),
                      //         )),
                      //     child: Icon(
                      //       Icons.menu,
                      //       color: Color(0xffEE2631),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "MATERIAL CENTRE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Row(
                          children: [
                            Radio(
                              groupValue: state.materialCenter,
                              value: "YARD",
                              activeColor: Color(0xffEE2631),
                              onChanged: (String? value) {
                                state.updateMaterialCenter(value!);
                              },
                            ),
                            Text(
                              "YARD",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.5),
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Row(
                          children: [
                            Radio(
                              groupValue: state.materialCenter,
                              value: "COLD",
                              activeColor: Color(0xffEE2631),
                              onChanged: (String? value) {
                                state.updateMaterialCenter(value!);
                              },
                            ),
                            Text(
                              "COLD",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state.materialCenter == "COLD")
                        Expanded(
                          child: Container(
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
                              controller: state.materialCenterText,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 12.5),
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Row(
                          children: [
                            Radio(
                              groupValue: state.materialCenter,
                              value: "GODOWN",
                              activeColor: Color(0xffEE2631),
                              onChanged: (String? value) {
                                state.updateMaterialCenter(value!);
                              },
                            ),
                            Text(
                              "GODOWN",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state.materialCenter == "GODOWN")
                        Expanded(
                          child: Container(
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
                              controller: state.materialCenterText,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ),
                    ],
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MARK",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 60,
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
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
                                controller: state.mark,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                              // child: Center(
                              //   child: DropdownButton<String>(
                              //     value: "1",
                              //     icon: const Icon(
                              //       Icons.keyboard_arrow_down_outlined,
                              //       color: Colors.black,
                              //     ),
                              //     elevation: 16,
                              //     isDense: true,
                              //     isExpanded: true,
                              //     style: const TextStyle(color: Colors.black),
                              //     underline: Container(
                              //       height: 0,
                              //       color: Colors.transparent,
                              //     ),
                              //     onChanged: (String? value) {},
                              //     items: ["1", "2"]
                              //         .map<DropdownMenuItem<String>>(
                              //             (String value) {
                              //       return DropdownMenuItem<String>(
                              //         value: value,
                              //         child: Text(value),
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NO. OF BAGS",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.maxFinite,
                              height: 60,
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
                              child: Center(
                                child: TextFormField(
                                  controller: state.numberOfBags,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (s) {
                                    state.updateBagListLength();
                                  },
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "S. NO.",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.maxFinite,
                              height: 60,
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
                              child: Center(
                                child: TextFormField(
                                  onTapOutside: (str) {
                                    state.updateStartSno();
                                  },
                                  onEditingComplete: () {
                                    state.updateStartSno();
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: state.startSno,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RATE PER QUINTAL",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.maxFinite,
                              height: 60,
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
                              child: Center(
                                child: TextFormField(
                                  controller: state.ratePerQuintal,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  ///----------------------
                  if (state.bags.length > 0) SizedBox(height: 23),
                  if (state.bags.length > 0)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "S. NO.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              ...state.bags.map(
                                (e) => Container(
                                  width: double.maxFinite,
                                  height: 60,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  margin: EdgeInsets.only(bottom: 16),
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
                                  child: Center(
                                    child: TextFormField(
                                      enabled: false,
                                      controller: TextEditingController(
                                          text: (e.sNo ?? "").toString()),
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "WEIGHT (IN KGS)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              ...state.bags.map(
                                (e) => Container(
                                  width: double.maxFinite,
                                  height: 60,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  margin: EdgeInsets.only(bottom: 16),
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
                                  child: Center(
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: (e.weight ?? "").toString()),
                                      onFieldSubmitted: (str) {
                                        state.updateBagWeight(
                                            index: state.bags.indexWhere(
                                                (element) =>
                                                    element.sNo == e.sNo),
                                            weight: double.parse(str));
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          children: [
                            ...state.bags.map(
                              (e) => InkWell(
                                onTap: () {
                                  state.removeBagAtSno(sno: e.sNo!);
                                },
                                child: Container(
                                  height: 60,
                                  margin: EdgeInsets.only(bottom: 16),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  decoration: BoxDecoration(
                                    color: Color(0xffE6E6E6),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Color(0xff3D3D3D),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "TOTAL WEIGHT (IN KGS)",
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
                      controller: state.totalWeight,
                      enabled: false,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "LESS TARE",
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
                      controller: state.lessTare,
                      keyboardType: TextInputType.number,
                      onChanged: (str) {
                        state.updateTotals();
                      },
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  ///----------------------
                  SizedBox(height: 23),
                  Text(
                    "NET WEIGHT (IN KGS)",
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
                      controller: state.netWeight,
                      enabled: false,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 30),

                  InkWell(
                    onTap: () {
                      state.saveEntryDetails(context: context);
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
