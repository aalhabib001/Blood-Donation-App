class DonationData{
  final int id;
  final String name;
  final String description;
  final String areaDivision;
  final String address;
  final String hospitalName;
  final String bloodGroup;
  final String phoneNo;

  DonationData({this.id, this.name, this.description, this.areaDivision, this.address, this.hospitalName, this.bloodGroup, this.phoneNo});

  factory DonationData.fromJson(Map<String, dynamic> json) => DonationData(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    areaDivision: json['areaDivision'],
    address: json['address'],
    hospitalName: json['hospitalName'],
    bloodGroup: json['bloodGroup'],
    phoneNo: json['phoneNo']
  );

}