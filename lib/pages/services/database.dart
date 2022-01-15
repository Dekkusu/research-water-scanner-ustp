import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //Collection for database
  final CollectionReference clientData =
      FirebaseFirestore.instance.collection('Clients');

  Future updateUserData(String name, String userAddress, String emailAdd,
      String password, String imgSrc) async {
    return await clientData.doc(uid).set({
      'name': name,
      'address': userAddress,
      'email': emailAdd,
      'password': password,
      'profile-img': imgSrc,
    });
  }

  //Add document for submitting complaint
  Future submitComplaintData(String address, String description,
      String waterImageSrc, String status, String imageUrl) async {
    int n = 1;
    String documentName = 'complaint-$n';

    var currentDocumentName = await clientData
        .doc(uid)
        .collection('Complaint')
        .doc(documentName)
        .get();
    while (currentDocumentName.exists) {
      String documentPostFix =
          currentDocumentName.id.split("-").last.toString();
      if (documentPostFix == n.toString()) {
        n = n.toInt();
        n = n + 1;
        documentName = 'complaint-$n';
        currentDocumentName = await clientData
            .doc(uid)
            .collection('Complaint')
            .doc(documentName)
            .get();
      } else {
        break;
      }
    }
    return await clientData
        .doc(uid)
        .collection('Complaint')
        .doc(documentName)
        .set({
      'complaint #': documentName,
      'address': address,
      'description': description,
      'water-img': waterImageSrc,
      'status': status,
      'image link': imageUrl,
    });
  }

  //upload image
  Future uploadImg(String destination, File img) async {
    final storageReference = FirebaseStorage.instance.ref(destination);
    await storageReference.putFile(img);
    return await storageReference.getDownloadURL();
  }

  //get image
  downloadImg(String destination) {
    return FirebaseStorage.instance
        .ref(destination)
        .getDownloadURL()
        .toString();
  }

  //snapshot user data
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      name: snapshot.get('name') ?? '',
      address: snapshot.get('address') ?? '',
      email: snapshot.get('email') ?? '',
      password: snapshot.get('password') ?? '',
      image: snapshot.get('profile-img'),
    );
  }

  //Fetch user data
  Stream<UserData> get userData {
    return clientData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  List<UserComplaint> _submissionList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserComplaint(
          complaintNum: doc.get('complaint #'),
          address: doc.get('address') ?? ' ',
          description: doc.get('description') ?? ' ',
          image: doc.get('water-img') ?? ' ',
          status: doc.get('status'),
          imageUrl: doc.get('image link'));
    }).toList();
  }

  //user complaints
  Stream<List<UserComplaint>> get submittedComplaints {
    return clientData
        .doc(uid)
        .collection('Complaint')
        .snapshots()
        .map(_submissionList);
  }

  //snapshot individual complaint docu
  UserComplaint _userComplaintFromSnapshot(DocumentSnapshot snapshot) {
    return UserComplaint(
      complaintNum: snapshot.get('complaint #'),
      address: snapshot.get('address') ?? '',
      image: snapshot.get('water-img'),
      description: snapshot.get('description'),
      status: snapshot.get('status'),
      imageUrl: snapshot.get('image link'),
    );
  }

  Stream<UserComplaint> submittedComplaintsDocument(String? docName) {
    return clientData
        .doc(uid)
        .collection('Complaint')
        .doc(docName)
        .snapshots()
        .map(_userComplaintFromSnapshot);
  }
}
