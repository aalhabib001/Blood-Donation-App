import 'package:blood_donation_app/src/DonationInfoPage.dart';
import 'package:blood_donation_app/src/Networking/NetworkHandling.dart';
import 'package:blood_donation_app/src/Widget/RedBigButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Widget/EntryFieldWidget.dart';
import 'Widget/bezierContainer.dart';

final storage = FlutterSecureStorage();

class RequestPage extends StatelessWidget {
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EntryFieldWidget(title: 'Blood Group',
                      tc: _bloodGroupController,
                      isPassword: false,),
                    EntryFieldWidget(title: 'Hospital',
                        isPassword: false,
                        tc: _hospitalController),
                    EntryFieldWidget(title: 'Address',
                        isPassword: false,
                        tc: _addressController),
                    EntryFieldWidget(title: 'Division',
                        isPassword: false,
                        tc: _divisionController),
                    EntryFieldWidget(title: 'Phone',
                        isPassword: false,
                        tc: _phoneController),
                    EntryFieldWidget(title: 'Description',
                        isPassword: false,
                        tc: _descriptionController),
                    //SizedBox(height: 15),
                    GestureDetector(
                        onTap: () async {
                          var blood = _bloodGroupController.text;
                          var hospital = _hospitalController.text;
                          var address = _addressController.text;
                          var division = _divisionController.text;
                          var phone = _phoneController.text;
                          var description = _descriptionController.text;

                          String jwtToken =
                          await storage.read(key: "jwt_blood_app");
                          print(jwtToken);

                          var res = await postData(bloodGroup: blood,
                              hospitalName: hospital,
                              address: address,
                              description: description,
                              phoneNo: phone,
                              division: division,
                              jwtToken: jwtToken);
                          print(res);

                          if (res) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DonationInfoPage(jwtToken)
                                )
                            );
                          } else {
                            displayDialog(context, "An Error Occurred",
                                "No account was found matching that username and password");
                          }
                        },
                        child: RedBigButton(text: "Request",)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
