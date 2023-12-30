import 'package:copains_de_route/cubit/profil/add_friend_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({
    super.key,
    required this.cubit,
  });

  final AddFriendCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back)),
            ]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.30),
            const Text(
              "Ajouter un ami",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: cubit.loginToAdd,
                decoration: const InputDecoration(
                    filled: true, fillColor: Colors.white),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColorScheme.customSecondaryColor),
                child: const Text(
                  "Envoyer une demande d'ami",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  cubit.addFriend();
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
