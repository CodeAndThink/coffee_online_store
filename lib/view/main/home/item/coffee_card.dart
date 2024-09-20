import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:flutter/material.dart';

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({super.key, required this.coffee, required this.onTap});
  final CoffeeDataModel coffee;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Image.asset(
                    coffee.url,
                    height: 80,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const Spacer(),
                  Text(
                    coffee.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ))),
    );
  }
}
