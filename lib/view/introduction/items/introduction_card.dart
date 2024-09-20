import 'package:coffee_online_store/model/models/triple_value_model.dart';
import 'package:flutter/material.dart';

class IntroductionCard extends StatelessWidget {
  const IntroductionCard({super.key, required this.value});
  final TripleValue value;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenWidth * 0.5,
                  maxWidth: screenWidth * 0.5,
                  minHeight: 181,
                  minWidth: 181,
                ),
                child: Image.asset(
                  value.a,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value.b,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value.c,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ));
  }
}
