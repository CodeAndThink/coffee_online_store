import 'package:coffee_online_store/view/main/rewards/redeem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  RewardsScreenState createState() => RewardsScreenState();
}

class RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.rewards,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),

            // Loyalty Card Section
            SizedBox(
              height: 122,
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 9),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.loyaltyCard,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                            ),
                            const Spacer(),
                            Text(
                              '4 / 8',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 61,
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              8,
                              (index) => SvgPicture.asset(
                                  'assets/icons/inactive_cup.svg'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 19),

            // My Points Section
            SizedBox(
              height: 122,
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 25, right: 23, bottom: 25),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.myPoints}:',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                          const Spacer(),
                          Text(
                            '2750',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          )
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            backgroundColor:
                                const Color(0xFFA2CDE9).withOpacity(0.19)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RedeemScreen()));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.redeemDrinks,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 12,
                            shadows: [
                              const Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 31),

            // History Rewards Section
            Text(
              AppLocalizations.of(context)!.historyRewards,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 15),

            // List of rewards - Expanded ListView
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Americano',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '24 June | 12:30 PM',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '+ 12 Pts',
                            style: Theme.of(context).textTheme.headlineLarge,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
