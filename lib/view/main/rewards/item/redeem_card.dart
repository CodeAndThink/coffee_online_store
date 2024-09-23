import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:coffee_online_store/values/static_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class RedeemCard extends StatelessWidget {
  const RedeemCard({
    super.key,
    required this.coffeeData,
  });
  final CoffeeDataModel coffeeData;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final now = DateTime.now();
    return GestureDetector(
        child: SizedBox(
      height: 120,
      width: screenWidth,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              FadeInImage.assetNetwork(
                placeholder: urlEmptyHolder,
                image: coffeeData.url,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(urlErrorHolder);
                },
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffeeData.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.validUntil(
                        DateFormat('dd.MM.yy')
                            .format(now.add(const Duration(days: 30)))
                            .toString()),
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  child: Text(
                    '+ ${pointRedeem.toString()}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.surface),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
