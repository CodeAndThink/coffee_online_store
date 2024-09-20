import 'package:coffee_online_store/view/main/order/item/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.myOrder,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Container(
                      width: screenWidth * 0.5,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.onGoing,
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Container(
                      width: screenWidth * 0.5,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.history,
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: 0,
                left: _selectedIndex == 0
                    ? screenWidth * 0.125
                    : screenWidth * 0.625,
                child: Container(
                  width: screenWidth * 0.25,
                  height: 4,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 31, right: 31),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const OrderCard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
