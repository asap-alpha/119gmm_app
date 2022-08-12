import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/data/otherData.dart';
import 'package:gmm_app/data/region.dart';
import 'package:gmm_app/model/userModel.dart';
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
  String region = "";
  bool isChosen = true;
  String district = "";
  String branches = "";
  String group = "";

  //personal key
  final personalFormKey = GlobalKey<FormState>();

  //declaring user and appending usermodel
  User? user = FirebaseAuth.instance.currentUser;
  UserModel logInUser = UserModel();
  FirebaseAuth _auth = FirebaseAuth.instance;

  //void initState
  void initState() {
    // TODO: implement initState
    super.initState();
    Regions;
    fellowship;
    region = Regions["region"]![0];
    district = Regions[region]![0];
    branches = Regions[district]![0];
    //fellowship data
    group = fellowship["groups"]![0];

    //getting user data to display
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        this.logInUser = UserModel.fromMap(value.data());
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("UPDATE PERSONAL"),
      elevation: 0.3,
      centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10, left: 10, right: 10),
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
                        style: TextStyle(fontSize: 16),
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
                            hint: Text("select region"),
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
                            style: TextStyle(fontSize: 16)),
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
                                  branches = Regions[district]!.first;
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
                if (isChosen)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: Column(
                      children: [
                        Text("Branch: ${logInUser.branches}",
                            style: TextStyle(fontSize: 16)),
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
                              value: branches,
                              isExpanded: true,
                              items: Regions[district]
                                  ?.map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  branches = value!;
                                });
                              },
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
                      Text("Home Town: ${logInUser.homeTown}", style: TextStyle(fontSize: 16)),
                      TextFormField(
                          validator: (value) {
                            if (homeTown.text.isEmpty) {
                              return ("Required");
                            }
                          },
                          textInputAction: TextInputAction.next,
                          controller: homeTown,
                          decoration: InputDecoration(
                            label: Text("Home Town"),
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
                      Text("Digital Address: ${logInUser.residentialAddress}", style: TextStyle(fontSize: 16)),
                      TextFormField(
                          validator: (value) {
                            if (residentialAddress.text.isEmpty) {
                              return ("Required");
                            }
                          },
                          textInputAction: TextInputAction.done,
                          controller: residentialAddress,
                          decoration: InputDecoration(
                            label: Text("Digital Address"),
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
                            style: TextStyle(fontSize: 16)),
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
                ElevatedButton(onPressed: (){
                  if(personalFormKey.currentState!.validate()){
                    updateBran();
                    Navigator.pop(context);
                  }
                }, child: Text("UPDATE"))
              ],
            ),
          ),
        ),
      ),
    ));
  }
  void updateBran() async {
    try {
       // postDetailsToFireStore().catchError((e){
         // Fluttertoast.showToast(msg: e!.message);
      FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      await firebaseStore
          .collection("Users")
          .doc(user!.uid).update(updateUserData().toMap()).catchError((e){
            Fluttertoast.showToast(gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG,msg: e!.message);
      });
        }
       // )
       //      .catchError((e) {
       //    Fluttertoast.showToast(msg: e!.message);
       //  });

        //Fluttertoast.showToast(msg: "Please Wait, you account is been creating");
    on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }

  updateUserData() async {
    UserModel userModel = UserModel();
    userModel.region = region.trim();
    userModel.district = district.trim();
    userModel.branches = branches.trim();
    userModel.homeTown = homeTown.text.trim();
    userModel.residentialAddress = residentialAddress.text.trim();
    userModel.group = group.trim();
  }
    //Navigator.of(context).popUntil((route) => route.isFirst);
//   } postDetailsToFireStore() async {
// //calling firestore
//     //calling user model
//     //sending data to the server
//     FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
//     User? user = _auth.currentUser;
//     UserModel userModel = UserModel();
//     //writing values to the FirebaseStore
//     userModel.region = region.trim();
//     userModel.district = district.trim();
//     userModel.branches = branches.trim();
//     userModel.homeTown = homeTown.text.trim();
//     userModel.residentialAddress = residentialAddress.text.trim();
//     userModel.group = group.trim();
//     await firebaseStore
//         .collection("Users")
//         .doc(logInUser.uid).set(userModel.toMap());
//     //Navigator.of(context).popUntil((route) => route.isFirst);
//   }
}
