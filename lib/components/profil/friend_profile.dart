import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class FriendProfile extends StatelessWidget {
  const FriendProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("${BlocProvider.of<ProfilViewCubit>(context).getInfo()}");
  }
}
