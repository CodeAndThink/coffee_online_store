import 'package:coffee_online_store/view/main/order_tracking/tracking_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSized = MediaQuery.of(context).size;
    final screenWidth = screenSized.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/take_away.svg',
              height: screenWidth * 0.5,
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              AppLocalizations.of(context)!.orderSuccess,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                AppLocalizations.of(context)!.orderSuccessNote,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 81,
            ),
            SizedBox(
              height: 50,
              width: screenWidth - 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackingMapScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 2,
                ),
                child: Text(
                  AppLocalizations.of(context)!.trackMyOrder,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
