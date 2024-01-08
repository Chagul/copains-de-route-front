import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/profil/profile.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginCubit>(context).refreshUser();
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is UserRefreshingState) {
        return const LoadingWidget();
      }
      if (state is UserRefreshedState) {
        return const ProfilePage();
      }
      return const Center(child: Text("Une erreur est survenue"));
    });
  }
}
