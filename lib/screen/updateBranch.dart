import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/data/otherData.dart';
import 'package:gmm_app/data/region.dart';
import 'package:gmm_app/model/userModel.dart';
import 'package:gmm_app/utils/progressBar.dart';

import '../controller/constant.dart';

class updateBranch extends StatefulWidget {
  const updateBranch({Key? key}) : super(key: key);

  @override
  _updateBranchState createState() => _updateBranchState();
}

class _updateBranchState extends State<updateBranch> {
  TextEditingController firstName = TextEditingController();
  TextEditingController otherName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController homeTown = TextEditingController();
  TextEditingController residentialAddress = TextEditingController();
  TextEditingController branches = TextEditingController();
  String region = "";
  bool isChosen = true;
  String district = "";
  String group = "";

  //personal key
  final personalFormKey = GlobalKey<FormState>();

  //declaring user and appending usermodel
  UserModel logInUser = UserModel();

  final helpUser = userController();

  //void initState
  void initState() {
    // TODO: implement initState
    super.initState();
    Regions;
    fellowship;
    region = Regions["region"]![0];
    district = Regions[region]![0];
    //fellowship data
    group = fellowship["groups"]![0];

    //getting user data to display
     helpUser.FirebaseFireStore.doc(helpUser.user!.uid)
        .get()
        .then((value) {
      setState(() {
        this.logInUser = UserModel.fromMap(value.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      helpUser.FirebaseFireStore.doc(helpUser.user!.uid)
          .get()
          .then((value) {
        setState(() {
          this.logInUser = UserModel.fromMap(value.data());
        });
      });
    });
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("UPDATE PERSONAL"),
        elevation: 0.3,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: personalFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "Regions: ${logInUser.region}",
                        style: textFontSize,
                      ),
                      SizedBox(height: 5),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(124, 252, 0, 0.57),
                                blurRadius: 0.1)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton<String>(
                            hint: Text("select region", style: textFontSize),
                            borderRadius: BorderRadius.circular(20),
                            isExpanded: true,
                            elevation: 20,
                            value: region,
                            onChanged: (value) {
                              setState(() {
                                region = value!;
                                isChosen = true;
                                district = Regions[region]!.first;
                              });
                            },
                            items: Regions["region"]
                                ?.map(
                                  (e) => DropdownMenuItem<String>(
                                      child: Text(e), value: e),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isChosen)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: Column(
                      children: [
                        Text("District: ${logInUser.district}",
                            style: textFontSize),
                        SizedBox(height: 5),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(124, 252, 0, 0.57),
                                  blurRadius: 0.1)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: district,
                              onChanged: (value) {
                                setState(() {
                                  district = value!;
                                  isChosen = true;
                                });
                              },
                              items: Regions[region]
                                  ?.map((e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: Column(
                      children: [
                        Text("Branch: ${logInUser.branches}",
                            style: textFontSize),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                          child: TextFormField(
                              validator: (value) {
                                if (branches.text.isEmpty) {
                                  return ("Required");
                                }
                              },
                              textInputAction: TextInputAction.next,
                              controller: branches,
                              decoration: InputDecoration(
                                label: Text("Branch", style:textFontSize),
                                prefixIcon: Icon(Icons.tour_outlined),
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text("Home Town: ${logInUser.homeTown}",
                          style: textFontSize),
                      TextFormField(
                          validator: (value) {
                            if (homeTown.text.isEmpty) {
                              return ("Required");
                            }
                          },
                          textInputAction: TextInputAction.next,
                          controller: homeTown,
                          decoration: InputDecoration(
                            label: Text("Home Town", style: textFontSize,),
                            prefixIcon: Icon(Icons.home_outlined),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text("Digital Address: ${logInUser.residentialAddress}",
                          style: textFontSize),
                      TextFormField(
                          validator: (value) {
                            if (residentialAddress.text.isEmpty) {
                              return ("Required");
                            }
                          },
                          textInputAction: TextInputAction.done,
                          controller: residentialAddress,
                          decoration: InputDecoration(
                            label: Text("Digital Address", style: textFontSize,),
                            prefixIcon: Icon(Icons.gps_fixed_outlined),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: Column(
                      children: [
                        Text("Fellowship: ${logInUser.group}",
                            style: textFontSize),
                        SizedBox(height: 5),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(124, 252, 0, 0.57),
                                  blurRadius: 0.1)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButton<String>(
                              value: group,
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  group = value!;
                                });
                              },
                              items: fellowship["groups"]
                                  ?.map((e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    )),
                Divider(
                  endIndent: 20.0,
                  indent: 20.0,
                  color: Colors.green,
                  thickness: 1.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (personalFormKey.currentState!.validate()) {
                        updateBran();
                        Navigator.pop(context);
                        successModal(context,"Update Branch", "Updated Successfully");
                      } else {
                        showException(context, "An Error Occurred");
                      }
                    },
                    child: Text("UPDATE", style: textFontSize,))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void updateBran() async {
    try {
      await helpUser.FirebaseFireStore.doc(logInUser.uid).update({
        "region": region.trim(),
        "district": district.trim(),
        "branches": branches.text.trim(),
        "homeTown": homeTown.text.trim(),
        "residentialAddress": residentialAddress.text.trim(),
        "group": group.trim(),
      }).catchError((e) {
        showException(context, e!.message);
      });
    }
    on SocketException catch (e) {
      showException(context, e.message);
    }
  }
}
