import 'package:coffee_online_store/model/models/coffee_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.coffeeBill});
  final CoffeeBill coffeeBill;

  @override
  Widget build(BuildContext context) {
    final screenSized = MediaQuery.of(context).size;
    final screenWidth = screenSized.width;
    return SizedBox(
      height: 130,
      width: screenWidth,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('dd MMMM | h:mm a').format(coffeeBill.orderTime),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Text(
                    NumberFormat.simpleCurrency().format(coffeeBill
                        .listOrderCoffee
                        .map((item) => item.quantity * item.coffee.price)
                        .reduce((sum, itemTotal) => sum + itemTotal)),
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/cup.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Text(
                    coffeeBill.listOrderCoffee
                        .map((item) => item.coffee.name)
                        .toList()
                        .join(' | '),
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.clip,
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/locate.svg',
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Text(
                    coffeeBill.deliveryAddress,
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                      coffeeBill.deliveryState == false
                          ? AppLocalizations.of(context)!.notDelivered
                          : AppLocalizations.of(context)!.delivered,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: coffeeBill.deliveryState == false
                                  ? Colors.redAccent
                                  : Colors.greenAccent))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
