import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  RedeemScreenState createState() => RedeemScreenState();
}

class RedeemScreenState extends State<RedeemScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          AppLocalizations.of(context)!.redeem,
          style: Theme.of(context).textTheme.headlineMedium,
        )),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              shape: const RoundedRectangleBorder(
                side: BorderSide.none, // Loại bỏ viền
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/pics/coffee (0).png',
                    height: 80,
                    width: 100,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cafe Latte',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Valid until 04.07.21',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary),
                      child: Text(
                        '1340 pts',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.surface),
                      ))
                ],
              ),
            );
          }),
    );
  }
}
