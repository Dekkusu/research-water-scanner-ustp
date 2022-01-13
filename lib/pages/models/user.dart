class RegisteredUser {
  final String? uid;
  RegisteredUser({this.uid});
}

class UserData {
  final String name;
  final String email;
  final String address;
  final String password;
  final String image;

  UserData(
      {required this.name,
      required this.email,
      required this.address,
      required this.password,
      required this.image});
}

class UserComplaint {
  final String complaintNum;
  final String address;
  final String image;
  final String description;
  final String status;
  final String imageUrl;

  UserComplaint(
      {required this.complaintNum,
      required this.address,
      required this.image,
      required this.description,
      required this.status,
      required this.imageUrl,});
}
