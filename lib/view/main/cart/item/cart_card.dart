import 'package:coffee_online_store/model/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.cartItemModel,
  });
  final CartItemModel cartItemModel;

  String _propertiesConverse(
      BuildContext context, int shot, int temp, int size, int ice) {
    List<String> list = [];
    switch (shot) {
      case 0:
        list.add(AppLocalizations.of(context)!.single.toLowerCase());
        break;
      case 1:
        list.add(AppLocalizations.of(context)!.double.toLowerCase());
        break;
      default:
        list.add(AppLocalizations.of(context)!.single.toLowerCase());
    }

    switch (temp) {
      case 0:
        list.add(AppLocalizations.of(context)!.hot.toLowerCase());
        break;
      case 1:
        list.add(AppLocalizations.of(context)!.ice.toLowerCase());
        break;
      default:
        list.add(AppLocalizations.of(context)!.hot.toLowerCase());
    }

    switch (size) {
      case 0:
        list.add(AppLocalizations.of(context)!.small.toLowerCase());
        break;
      case 1:
        list.add(AppLocalizations.of(context)!.medium.toLowerCase());
        break;
      case 2:
        list.add(AppLocalizations.of(context)!.big.toLowerCase());
        break;
      default:
        list.add(AppLocalizations.of(context)!.small.toLowerCase());
    }

    switch (ice) {
      case 0:
        list.add(AppLocalizations.of(context)!.ice.toLowerCase());
        break;
      case 1:
        list.add(AppLocalizations.of(context)!.littleIce.toLowerCase());
        break;
      case 2:
        list.add(AppLocalizations.of(context)!.fullIce.toLowerCase());
        break;
      default:
        list.add(AppLocalizations.of(context)!.ice.toLowerCase());
    }

    return list.join(' | ');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return GestureDetector(
        child: SizedBox(
          height: 120,
          width: screenWidth,
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    cartItemModel.coffee.url,
                    height: 80,
                    width: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItemModel.coffee.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                            _propertiesConverse(
                                context,
                                cartItemModel.shot,
                                cartItemModel.temp,
                                cartItemModel.size,
                                cartItemModel.ice),
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 12)),
                        Text(
                          'x ${cartItemModel.quantity}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    NumberFormat.simpleCurrency().format(
                        cartItemModel.coffee.price * cartItemModel.quantity),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ),
        ));
  }
}
