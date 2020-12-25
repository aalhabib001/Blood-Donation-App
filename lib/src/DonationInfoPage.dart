import 'package:flutter/material.dart';
import 'Model/DonationData.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

// ignore: must_be_immutable
class DonationInfoPage extends StatelessWidget {
  DonationInfoPage(this.donationData);

  List<DonationData> donationData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
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
      body: Center(
          child: ListView.builder(
        itemCount: donationData.length,
        itemBuilder: _buildItemsForListView1,
      )),
    );
  }

  Card _buildItemsForListView1(BuildContext context, int index) {
    return Card(
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
