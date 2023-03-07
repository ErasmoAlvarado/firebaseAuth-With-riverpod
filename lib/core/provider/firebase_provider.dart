import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance ;
});

final authGoogleProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final fireStorageProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});