import 'package:candy_shop/core/provider/firebase_provider.dart';
import 'package:candy_shop/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/constant/firebase_constant.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
   firestore: ref.read(fireStorageProvider),
   auth: ref.read(authProvider),
   googleSignIn: ref.read(authGoogleProvider)
   );
});


class AuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;


  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

    CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);
    Stream get authStateChange => _auth.authStateChanges();
    Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
  

  Future googleSignIn({required bool islogin})async{
    UserCredential userCredential;
    try {
      final GoogleSignInAccount? authGoogle = await _googleSignIn.signIn(); 
      final googleAuth = await authGoogle?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken
      );
      if (islogin) {
       userCredential  =await _auth.signInWithCredential(credential);
      }else{
        userCredential = await _auth.currentUser!.linkWithCredential(credential);
      }
      UserModel userData;
     
        userData = UserModel(
          name: userCredential.user!.displayName ?? "",
          profilePic: userCredential.user!.photoURL ?? "",
          banner: "",
          uid: userCredential.user!.uid,
          isAuthenticated: true
        );
        await _users.doc(userCredential.user!.uid).set(userData.toMap());
        return userData;

    }on FirebaseException catch (e) {
      throw "something goes wrong ${e.message}";
    }
  }

  Future createUser({required String email,required String password,required String name, required String profilePic, required String banner,required bool isAuthenticated})async{
    try {
      final register = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(register.user!.uid);
        UserModel userData = UserModel(
        name: name,
        profilePic: profilePic,
        banner: banner,
        uid: register.user!.uid,
        isAuthenticated: isAuthenticated
        );
        await _users.doc(register.user!.uid).set(userData.toMap());
        return userData;
    }on FirebaseAuth catch (e) {
      throw("something goes wrong $e");
    }
  }


  Future signIn({required String email,required String password})async{
    try {
      final auth = await  _auth.signInWithEmailAndPassword(email: email, password: password);
        UserModel userData = UserModel(
        name: "",
        profilePic: "",
        banner: "",
        uid: auth.user!.uid,
        isAuthenticated: false
    );
      return userData;
    }on FirebaseAuthException catch (e) {
      throw "something goes wrong ${e.message}";
    }
  }

  Future anonymouslySignIn()async{
    try {
      UserCredential auth = await _auth.signInAnonymously();
      UserModel userData = UserModel(
        name: "Guess",
        profilePic: "https://th.bing.com/th/id/R.caa6e2ed5e29c6bb5d9baa9ddc9d52c4?rik=b%2b0Z73kDfURHvg&pid=ImgRaw&r=0",
        banner: "",
        uid: auth.user!.uid,
        isAuthenticated: false
    );
    await _users.doc(auth.user!.uid).set(userData.toMap());
    return userData;
    } on FirebaseAuthException catch (e) {
      throw("something goes wrong ${e.message}");
    }
  }

  signOut(){
    _googleSignIn.signOut();
    _auth.signOut();
  }

}