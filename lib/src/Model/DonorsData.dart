class DonorsData {
  final String name;
  final String location;
  final String bloodGroup;
  final String phoneNo;

  DonorsData({this.name, this.location, this.bloodGroup, this.phoneNo});

  factory DonorsData.fromJson(Map<String, dynamic> json) => DonorsData(
      name: json['name'],
      location: json['location'],
      bloodGroup: json['bloodGroup'],
      phoneNo: json['phone']);
}
