/*
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;
String email = user?.email ?? "user@example.com"; // Default if email is null
String? photoURL = user?.photoURL;


String firstLetter = email.isNotEmpty ? email[0].toUpperCase() : "?";


CircleAvatar(
radius: 30,
backgroundColor: Colors.blue, // Default background color
backgroundImage: photoURL != null ? NetworkImage(photoURL!) : null, // Show image if available
child: photoURL == null
? Text(
firstLetter, // Show first letter of email
style: TextStyle(fontSize: 24, color: Colors.white),
)
    : null,
)
*/
