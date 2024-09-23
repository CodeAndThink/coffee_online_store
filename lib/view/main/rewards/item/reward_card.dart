import 'package:coffee_online_store/model/models/cart_item_model.dart';
import 'package:coffee_online_store/values/static_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RewardCard extends StatelessWidget {
  const RewardCard(
      {super.key, required this.orderItem, required this.orderDateTime});
  final CartItemModel orderItem;
  final DateTime orderDateTime;

  @override
  Widget build(BuildContext context) {
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
                  orderItem.coffee.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('dd MMMM | h:mm a').format(orderDateTime),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const Spacer(),
            Text(
              '+ ${(orderItem.quantity * rewardPointPerCoffee).toString()} Pts',
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
