import 'package:chat_app/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodal {
  final String? email;
  final String? id;
  final String? username;
  Usermodal({required this.email, this.id, this.username});
  @override
  String toString() {
    return ' id $id,email : $email ,usernam :  $username';
  }

 static Future<Usermodal?> fromEmail(String email) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(kusersCollection)
        .where('email', isEqualTo: email)
        .limit(1) // safer: only fetch first match
        .get();
    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      return Usermodal(
        email: doc['email'],
        id: doc['userId'],
        username: doc['username'],
      );
    }
    return null; // no user found
  }
}
