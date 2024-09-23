import 'package:coffee_online_store/model/models/user_model.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadLocalUserProfile();
  }

  void _loadLocalUserProfile() {
    context.read<AuthServiceBloc>().add(GetLocalUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.profile,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: BlocBuilder<AuthServiceBloc, AuthServiceState>(
              builder: (context, state) {
            if (state is AuthServiceLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadLocalUserProfileSuccess) {
              final UserModel userData = state.userMetadata.userData;
              return Column(
                children: [
                  //Name
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                            width: 50.0,
                            height: 50.0,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/profile.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.secondary,
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.fullName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              userData.displayName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 19,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/icons/edit.svg'),
                        )
                      ],
                    ),
                  ),
                  //Phone number
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                            width: 50.0,
                            height: 50.0,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/call.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.secondary,
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.phoneNumber,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              userData.phoneNumber,
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 19,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/icons/edit.svg'),
                        )
                      ],
                    ),
                  ),
                  //Email
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                            width: 50.0,
                            height: 50.0,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/email.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.secondary,
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.email,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              userData.email,
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 19,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/icons/edit.svg'),
                        )
                      ],
                    ),
                  ),
                  //Address
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                            width: 50.0,
                            height: 50.0,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/locate.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.secondary,
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.address,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              userData.address,
                              style: Theme.of(context).textTheme.headlineMedium,
                              overflow: TextOverflow.clip,
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 19,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/icons/edit.svg'),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is AuthServiceError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.dataLoadError,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            } else {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.noDataAvailable,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            }
          })),
    );
  }
}
