import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSized = MediaQuery.of(context).size;
    final screenWidth = screenSized.width;
    return SizedBox(
      height: 122,
      width: screenWidth,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  '24 June | 12:30 PM',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  NumberFormat.simpleCurrency().format(3.00),
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/cup.svg',
                  height: 13,
                  width: 13,
                ),
                const SizedBox(
                  width: 11,
                ),
                Text(
                  'Americano',
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/locate.svg',
                  height: 13,
                  width: 13,
                ),
                const SizedBox(
                  width: 11,
                ),
                Text(
                  '3 Addersion Court Chino Hills, HO56824, United State',
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
