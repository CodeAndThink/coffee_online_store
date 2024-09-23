import 'package:coffee_online_store/values/static_values.dart';
import 'package:coffee_online_store/view/main/contact/call_screen.dart';
import 'package:coffee_online_store/view/main/contact/message_screen.dart';
import 'package:coffee_online_store/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:coffee_online_store/viewmodel/bloc/map_bloc/map_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/map_bloc/map_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/map_bloc/map_service_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:latlong2/latlong.dart';

class TrackingMapScreen extends StatefulWidget {
  const TrackingMapScreen({super.key});

  @override
  TrackingMapScreenState createState() => TrackingMapScreenState();
}

class TrackingMapScreenState extends State<TrackingMapScreen> {
  LatLng currentPoint = const LatLng(0.0, 0.0);
  @override
  void initState() {
    super.initState();
  }

  void _getCurrentPosition() {
    context.read<MapServiceBloc>().add(PermissionRequest());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
        body: Stack(
      children: [
        BlocConsumer<MapServiceBloc, MapServiceState>(
          listener: (context, state) {
            if (state is MapLoaded) {
              setState(() {
                currentPoint = state.position;
              });
            }
          },
          builder: (context, state) {
            if (state is MapLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MapError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              return FlutterMap(
                options: MapOptions(
                  initialCenter: currentPoint,
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    maxZoom: 19,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: currentPoint,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Current location tapped!')),
                            );
                          },
                          child: Icon(Icons.location_pin,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 45),
                        ),
                        alignment: Alignment.center,
                        rotate: false,
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
        //Get location button
        Positioned(
            right: 16,
            bottom: screenHeight * 0.36,
            child: SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                  _getCurrentPosition();
                },
                icon: SvgPicture.asset('assets/icons/detect.svg'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                ),
              ),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: screenHeight * 0.35,
          child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              color: Theme.of(context).colorScheme.secondary,
              elevation: 4,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18, left: 30, right: 30, bottom: 18),
                    child: Row(
                      children: [
                        ClipOval(
                          child: FadeInImage.assetNetwork(
                            placeholder: urlEmptyHolder,
                            image: '',
                            fit: BoxFit.cover,
                            width: 50.0,
                            height: 50.0,
                            fadeInDuration: const Duration(milliseconds: 300),
                            fadeOutDuration: const Duration(milliseconds: 300),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                urlErrorHolder,
                                fit: BoxFit.cover,
                                width: 50.0,
                                height: 50.0,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Leslie Sheeran',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface),
                        ),
                        const Spacer(),
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  const Color(0xFF839DAD)),
                            ),
                            iconSize: 14,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CallScreen()));
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/call.svg',
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  const Color(0xFF839DAD)),
                            ),
                            iconSize: 14,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MessageScreen(
                                          shipperName: 'Leslie Sheeran')));
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/message.svg',
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                        height: screenHeight * 0.25,
                        width: screenWidth,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: screenWidth - 60,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          width: 50.0,
                                          height: 50.0,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/icons/home.svg',
                                              width: 21,
                                              height: 21,
                                              colorFilter: ColorFilter.mode(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  BlendMode.dstIn),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Adam Coffee Shop',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .preparingYourOrder,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Transform.rotate(
                                    angle: 50 * pi / 180,
                                    child: Image.asset(
                                      'assets/pics/path.png',
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Row(
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
                                              'assets/icons/delivery.svg',
                                              width: 21,
                                              height: 21,
                                              colorFilter: ColorFilter.mode(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  BlendMode.dstIn),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .sendToYou,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .arrivalTime('12:00 AM'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              )),
        ),
        //Appbar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            title: Row(
              children: [
                const Spacer(),
                IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/home.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.surface,
                          BlendMode.srcIn),
                    ))
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ],
    ));
  }
}
