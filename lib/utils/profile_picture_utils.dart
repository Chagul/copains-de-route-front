import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePictureUtils {
  static String? _getUrlProfilePicPromoterFromEvent(Event event) {
    if (event.promoterProfilePicLocation != null) {
      return CopainsDeRouteApi()
          .getUserProfilePicUrl(event.promoterProfilePicLocation!);
    }
    return null;
  }

  static String? _getUrlProfilePicFromUser(UserDTO user) {
    if (user.profilePicLocation != null) {
      return CopainsDeRouteApi().getUserProfilePicUrl(user.profilePicLocation!);
    }
    return null;
  }

  static Widget getEventPromoterProfilePicWidget(BuildContext context) {
    if (ProfilePictureUtils._getUrlProfilePicPromoterFromEvent(
            context.read<DetailEventCubit>().event) !=
        null) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
            ProfilePictureUtils._getUrlProfilePicPromoterFromEvent(
                context.read<DetailEventCubit>().event)!),
      );
    } else {
      return const Icon(Icons.person);
    }
  }

  static Widget getUserProfilePicWidget(BuildContext context) {
    if (ProfilePictureUtils._getUrlProfilePicFromUser(
            context.read<LoginCubit>().user) !=
        null) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
            ProfilePictureUtils._getUrlProfilePicFromUser(
                context.read<LoginCubit>().user)!),
      );
    } else {
      return CircleAvatar(
          radius: 50,
          backgroundColor:
              CustomColorScheme.customPrimaryColor.withOpacity(0.5),
          child: const CircleAvatar(
              radius: 48,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.black,
              )));
    }
  }

  static Widget getParticipantProfilPicWidget(UserDTO participant) {
    if (ProfilePictureUtils._getUrlProfilePicFromUser(participant) != null) {
      return CircleAvatar(
          radius: 17,
          backgroundColor:
              CustomColorScheme.customPrimaryColor.withOpacity(0.5),
          child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  ProfilePictureUtils._getUrlProfilePicFromUser(
                      participant)!)));
    } else {
      return CircleAvatar(
          radius: 17,
          backgroundColor:
              CustomColorScheme.customPrimaryColor.withOpacity(0.5),
          child: const CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.person,
                color: Colors.black,
              )));
    }
  }
}
