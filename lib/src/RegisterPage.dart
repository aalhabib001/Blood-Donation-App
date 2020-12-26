import 'package:blood_donation_app/src/Networking/NetworkHandling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './Widget/EntryFieldWidget.dart';
import './Widget/RedBigButton.dart';
import 'DonationInfoPage.dart';
import 'Widget/bezierContainer.dart';

const SERVER_IP = 'https://blood-donation-backend-se231.herokuapp.com/api';
final storage = FlutterSecureStorage();

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

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
              top: -height * .25,
              right: -MediaQuery.of(context).size.width * .35,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(
                    //   'asset/l2.png',
                    //   height: 110,
                    //   width: 100,
                    // ),
                    EntryFieldWidget(
                      title: "Name",
                      isPassword: false,
                      tc: _nameController,
                    ),
                    EntryFieldWidget(
                      title: "Email",
                      isPassword: false,
                      tc: _emailController,
                    ),
                    EntryFieldWidget(
                      title: "Phone",
                      isPassword: false,
                      tc: _phoneController,
                    ), EntryFieldWidget(
                      title: "Location",
                      isPassword: false,
                      tc: _locationController,
                    ), EntryFieldWidget(
                      title: "Blood Group",
                      isPassword: false,
                      tc: _bloodGroupController,
                    ),
                    EntryFieldWidget(
                      title: "Password",
                      isPassword: true,
                      tc: _passwordController,
                    ),
                    //SizedBox(height: 15),
                    GestureDetector(
                        onTap: () async {
                          var email = _emailController.text;
                          var password = _passwordController.text;
                          var name = _nameController.text;
                          var phone = _phoneController.text;
                          var bloodGroup = _bloodGroupController.text;
                          var location = _locationController.text;

                          var jwt = await attemptRegister(
                            name: name,
                            email: email,
                            phone: phone,
                            password: password,
                            bloodGroup: bloodGroup,
                            location: location,
                          );

                          print(jwt);

                          if (jwt != null) {
                            storage.write(key: "jwt", value: jwt);
                            storage.write(key: "jwt_blood_app", value: jwt);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DonationInfoPage(jwt),
                              ),
                            );
                          } else {
                            displayDialog(context, "An Error Occurred",
                                "No account was found matching that username and password");
                          }
                        },
                        child: RedBigButton(text: "Register"))
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
