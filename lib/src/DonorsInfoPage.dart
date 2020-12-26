import 'package:blood_donation_app/src/Model/DonorsData.dart';
import 'package:blood_donation_app/src/RequestPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Networking/NetworkHandling.dart';
import 'Widget/bezierContainer.dart';

final storage = FlutterSecureStorage();

// ignore: must_be_immutable
class DonorsInfoPage extends StatelessWidget {
  DonorsInfoPage(this.jwt);

  List<DonorsData> donorsData;
  String jwt;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestPage()));
              //Navigator.push(context, route)
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () async {
              await storage.delete(key: "jwt_blood_app");
              // Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              //Navigator.push(context, route)
            },
          )
        ],
      ),
      body: Container(
        height: height,
        child: FutureBuilder(
            future: getDonors(jwtToken: jwt),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Yes");
                donorsData = snapshot.data;

                return Stack(
                  children: [
                    Positioned(
                      top: -height * .25,
                      right: -MediaQuery.of(context).size.width * .35,
                      child: BezierContainer(),
                    ),
                    Center(
                      child: ListView.builder(
                        itemCount: donorsData.length,
                        itemBuilder: _buildItemsForListView1,
                      ),
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    Positioned(
                      top: -height * .25,
                      right: -MediaQuery.of(context).size.width * .35,
                      child: BezierContainer(),
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }
            }),
      ),
    );
  }

  Card _buildItemsForListView1(BuildContext context, int index) {
    var cl;
    if (index % 3 == 0)
      cl = Colors.yellow;
    else if (index % 2 == 0)
      cl = Colors.red;
    else
      cl = Colors.blue;
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cl, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 4,
          ),
          ListTile(
            leading: Text(
              donorsData[index].bloodGroup,
              style: TextStyle(fontSize: 25),
            ),
            title: Text(donorsData[index].name, style: TextStyle(fontSize: 20)),
            subtitle: Text(donorsData[index].location,
                style: TextStyle(fontSize: 20)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(height: 2, width: 8),
              Icon(Icons.phone_android),
              const SizedBox(width: 4),
              Text(
                donorsData[index].phoneNo,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 2, width: 8),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
