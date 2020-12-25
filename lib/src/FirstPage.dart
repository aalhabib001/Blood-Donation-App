import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './Networking/NetworkHandling.dart';
import 'DonationInfoPage.dart';
import 'Model/DonationData.dart';
import 'Welcome.dart';
import 'Widget/bezierContainer.dart';

final storage = FlutterSecureStorage();

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/l2.png',
                    height: 110,
                    width: 110,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You can share message, why not blood!',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      String jwtToken =
                          await storage.read(key: "jwt_blood_app");
                      print(jwtToken);

                      if (jwtToken != null) {
                        List<DonationData> donationData =
                            await getData(jwtToken: jwtToken);
                        if (donationData != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonationInfoPage(jwtToken),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomePage(),
                            ),
                          );
                        }
                      }
                      else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WelcomePage(),
                          ),
                        );
                      }
                    },
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 50,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
