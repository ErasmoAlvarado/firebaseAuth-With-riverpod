import 'package:candy_shop/features/auth/repository/auth_repository.dart';
import 'package:candy_shop/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userProvider = StateProvider<UserModel?>((ref) 
=> UserModel(name: "error", profilePic: "error", banner: "error", uid: 'error', isAuthenticated: false) 
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});


final authControllerProvider = StateNotifierProvider<AuthController,bool>((ref) {
  return AuthController(authRepository:ref.watch(authRepositoryProvider) , ref: ref);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref}):
  _authRepository = authRepository,
  _ref  = ref,
   super(false);

   Stream<UserModel> getUser({required uid}){
    return _authRepository.getUserData(uid);
   }

   logOut()async{
    _authRepository.signOut();
   }
   
   Stream get authStateChange => _authRepository.authStateChange;

    Future signInWithGoogle(BuildContext context) async {
    try {
    state = true;
    _ref.read(userProvider.notifier).state = UserModel(name: "error", profilePic: "error", banner: "error", uid: 'error', isAuthenticated: false);
    final user = await _authRepository.googleSignIn(islogin: true);
    _ref.read(userProvider.notifier).state = user;
    state = false;
    } catch (e) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("something goes wrong $e")));
    }
  }

  void signGuess()async{
    state = true;
    _ref.read(userProvider.notifier).state = UserModel(name: "error", profilePic: "error", banner: "error", uid: 'error', isAuthenticated: false);
    final user = await _authRepository.anonymouslySignIn();
    _ref.read(userProvider.notifier).state = user;
    state = false;
  }
  
  Future createUser({required String email,required String password,required String name, required bool isAuthenticated,required BuildContext context})async{
    try {
    state = true;
    _ref.read(userProvider.notifier).state = UserModel(name: "error", profilePic: "error", banner: "error", uid: 'error', isAuthenticated: false);
    final user = await _authRepository.createUser(email: email, password: password, name: name, profilePic: "https://th.bing.com/th/id/R.caa6e2ed5e29c6bb5d9baa9ddc9d52c4?rik=b%2b0Z73kDfURHvg&pid=ImgRaw&r=0", banner: "", isAuthenticated: isAuthenticated);
    _ref.read(userProvider.notifier).state = user;
    state = false;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Welcome")));
    } catch (e) {
     return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("something goes wrong $e")));
    }
  }
  
   signPasswordEmail({required String email,required String password,required BuildContext context})async{
    try {
    state = true;
    _ref.read(userProvider.notifier).state = UserModel(name: "error", profilePic: "error", banner: "error", uid: 'error', isAuthenticated: false);
    final user = await _authRepository.signIn(email: email, password: password);
    _ref.read(userProvider.notifier).state = user;
    state = false;
    } catch (e) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("something goes wrong $e")));
    }
  }  
}
