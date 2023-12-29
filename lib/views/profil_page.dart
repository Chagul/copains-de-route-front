import 'package:copains_de_route/components/profil/profile.dart';
import 'package:copains_de_route/cubit/profil/profil_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfilViewCubit>(
        create: (_) => ProfilViewCubit(), child: const ProfilePage());
  }
}
