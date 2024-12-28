import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../functions/check_internet.dart';
import '../modle/user.dart';


class FireStore {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection('Users');
      

  Future<void> addUser(UserModel userModel) {
  return userCollectionRef
      .doc(userModel.userId)
      .set(userModel.toJson())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await userCollectionRef.doc(userId).get();
      return documentSnapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<Map> signUpPostData(Map data) async {
   
      if (await checkInternet()) {
       try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );

      await userCredential.user!.sendEmailVerification();

      await addUser(UserModel(
    userId: userCredential.user!.uid,
    email: userCredential.user!.email!,
    name: data['name'],
  ));

      return {
        'status': 'verification_email_sent',
        'userId': userCredential.user!.uid,
      };
    } catch (e) {
      return {'status': e.toString()};
    }
      } else {
        return {'status': 'disconnection'};
      }
     
  }

   Future<String> checkEmailVerification() async {
  User? user = _auth.currentUser;
  if (user != null) {
    await user.reload();
    user = _auth.currentUser; 
    if (user != null && user.emailVerified) {
      return 'verified';
    } else {
      return 'Not verified';
    }
  } else {
    return 'user not found';
  }
}

Future<Map> signInWithEmailAndPassword(
      String email, String password) async {
    if (await checkInternet()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (!userCredential.user!.emailVerified) {
        return {'status' : 'not verified'};
      }
        return {
          'status': 'success',
          'userId': userCredential.user!.uid,
          'email' : email,
        };
      } catch (e) {
        return {'status' : e.toString()};
      }
    } else {
      return {'status': 'disconnection'};
    }
  }
}