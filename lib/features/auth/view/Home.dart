import 'package:candy_shop/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      body: StreamBuilder<UserModel>(
        stream: ref.read(authControllerProvider.notifier).getUser(uid: ref.watch(userProvider)!.uid),
        builder: (context, snapshot) {
        
          if (snapshot.connectionState == ConnectionState.waiting || ref.watch(userProvider)!.name == "error") {
            return Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: (){ref.read(authControllerProvider.notifier).logOut();}, child: const Text("back")),
                const SizedBox(height: 10,),
                const CircularProgressIndicator(),
              ],
            ),);
          }
  
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(snapshot.data!.profilePic),
                radius: 80,
              ),
              const SizedBox(height: 10,),
              Text(snapshot.data!.name),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){ref.read(authControllerProvider.notifier).logOut();},
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.purple[200]
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width/1.1,
                    child: const Text("exit",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}