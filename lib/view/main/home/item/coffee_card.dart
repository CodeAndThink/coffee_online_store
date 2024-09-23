import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:coffee_online_store/values/static_values.dart';
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
                  FadeInImage.assetNetwork(
                    placeholder: urlEmptyHolder,
                    image: coffee.url,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(urlErrorHolder);
                    },
                    width: 100,
                    height: 80,
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
