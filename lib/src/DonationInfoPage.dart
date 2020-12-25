import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Model/DonationData.dart';
import 'Widget/bezierContainer.dart';

final storage = FlutterSecureStorage();

// ignore: must_be_immutable
class DonationInfoPage extends StatelessWidget {
  DonationInfoPage(this.donationData);

  List<DonationData> donationData;

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
              Icons.logout,
            ),
            onPressed: () async {
              await storage.delete(key: "jwt_blood_app");
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: -height * .25,
              right: -MediaQuery.of(context).size.width * .35,
              child: BezierContainer(),
            ),
            Center(
              child: ListView.builder(
                itemCount: donationData.length,
                itemBuilder: _buildItemsForListView1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildItemsForListView1(BuildContext context, int index) {
    var color = new List(2);
    color[0] = Colors.orange;
    color[1] = Colors.blue;

    var cl;
    if (index % 2 == 0)
      cl = Colors.orange;
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
          ListTile(
            leading: Text(
              donationData[index].bloodGroup,
              style: TextStyle(fontSize: 25),
            ),
            title: Text(donationData[index].description +
                " at " +
                donationData[index].hospitalName),
            subtitle: Text(donationData[index].address +
                ", " +
                donationData[index].areaDivision),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(donationData[index].name),
              const SizedBox(height: 5, width: 8),
              Text(
                donationData[index].phoneNo,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 5, width: 8),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
