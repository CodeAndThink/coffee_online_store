import 'package:coffee_online_store/values/static_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  CallScreenState createState() => CallScreenState();
}

class CallScreenState extends State<CallScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.incomingCall,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 13,
            ),
            //Call duration
            Text(
              '00:15',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
            ),
            const SizedBox(
              height: 40,
            ),
            //Avatar
            ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: urlEmptyHolder,
                image: '',
                fit: BoxFit.cover,
                width: 133.0,
                height: 133.0,
                fadeInDuration: const Duration(milliseconds: 300),
                fadeOutDuration: const Duration(milliseconds: 300),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    urlErrorHolder,
                    fit: BoxFit.cover,
                    width: 133.0,
                    height: 133.0,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            //Name
            Text(
              'Leslie Sheeran',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Mute button
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: SizedBox(
                        height: 63,
                        width: 63,
                        child: IconButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.1)),
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/volume_off.svg',
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.25,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.mute,
                          style: Theme.of(context).textTheme.headlineMedium,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    )
                  ],
                ),
                //Keypab button
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: SizedBox(
                        height: 63,
                        width: 63,
                        child: IconButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.1)),
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/keypad.svg',
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.25,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.keypad,
                          style: Theme.of(context).textTheme.headlineMedium,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    )
                  ],
                ),
                //Speaker button
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: SizedBox(
                        height: 63,
                        width: 63,
                        child: IconButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.1)),
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/speaker.svg',
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.25,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.speaker,
                          style: Theme.of(context).textTheme.headlineMedium,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            //Exit call button
            Padding(
              padding: const EdgeInsets.all(50),
              child: SizedBox(
                height: 63,
                width: 63,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red[600]),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/exit_call.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.surface,
                          BlendMode.srcIn),
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
