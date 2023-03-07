import 'package:candy_shop/features/auth/controller/auth_controller.dart';
import 'package:candy_shop/features/auth/view/Home.dart';
import 'package:candy_shop/features/auth/view/Login.dart';
import 'package:candy_shop/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: myTheme.darkTheme,
      theme: myTheme.lightTheme,
      themeMode: ThemeMode.system,
      home: ref.watch(authStateChangeProvider).when(
        data: (data) {
          if(data == null){
            return Login();
          }
          return const Home();
        },
        error: (error, stackTrace) => const Scaffold(body: Center(child: Text("440 error"),)),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(),)),
        )
    );
  }
}

