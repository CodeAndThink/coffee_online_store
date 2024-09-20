import 'package:coffee_online_store/model/models/cart_item_model.dart';
import 'package:coffee_online_store/view/main/cart/item/cart_card.dart';
import 'package:coffee_online_store/view/main/order_tracking/order_tracking_screen.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  double totalPrice = 0;
  int _selectedPayment = 0;
  @override
  void initState() {
    super.initState();
    _loadCartList();
  }

  void _removeCartItem(int index) {
    context.read<CartServiceBloc>().add(RemoveCartItem(index));
  }

  void _loadCartList() {
    context.read<CartServiceBloc>().add(GetCart());
  }

  Widget _showBottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return FractionallySizedBox(
      heightFactor: 0.80,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(33.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.orderInformation,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 35),
                Text(
                  AppLocalizations.of(context)!.deliveryAddress,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 19),
                // Delivery address
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Card(
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/delivery.svg',
                                fit: BoxFit.cover,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Anderson',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                '3 Addersion Court Chino Hills, HO56824, United States',
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/edit.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                // Payment option 1
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: _selectedPayment,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedPayment = value!;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.onlineBanking,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                'maybank2u (one-time)',
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/pics/fpx.png',
                          height: 35,
                          fit: BoxFit.fitHeight,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                // Payment option 2
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: _selectedPayment,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedPayment = value!;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.creditCard,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                '2540 xxxx xxxx 2648',
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        //Visa icon
                        Image.asset(
                          'assets/pics/visa.png',
                          height: 35,
                          fit: BoxFit.fitHeight,
                        ),
                        //Master card icon
                        Image.asset(
                          'assets/pics/master_card.png',
                          height: 35,
                          fit: BoxFit.fitHeight,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                //Subtotal
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.subtotal,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      NumberFormat.simpleCurrency().format(totalPrice),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                //Tax
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tax,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      NumberFormat.simpleCurrency().format(totalPrice),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                //Delivery fee
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deliveryFee,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      NumberFormat.simpleCurrency().format(totalPrice),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    width: screenWidth - 50,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.totalPrice,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              NumberFormat.simpleCurrency().format(totalPrice),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 51,
                          width: 162,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondary, // Màu nền của nút
                                elevation: 2, // Độ cao (bóng đổ)
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderTrackingScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/credit_card.svg',
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).colorScheme.surface,
                                        BlendMode.srcIn),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.payNow,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  AppLocalizations.of(context)!.myCart,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                  child: BlocConsumer<CartServiceBloc, CartServiceState>(
                      listener: (context, state) {
                if (state is CartLoaded) {
                  List<CartItemModel> listCartItem = state.listCartItem;
                  double price = 0;
                  for (int i = 0; i < listCartItem.length; i++) {
                    price +=
                        listCartItem[i].quantity * listCartItem[i].coffee.price;
                  }
                  setState(() {
                    totalPrice = price;
                  });
                }
              }, builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CartLoaded) {
                  List<CartItemModel> listCartItem = state.listCartItem;

                  return ListView.builder(
                      itemCount: listCartItem.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: Key(
                                '${index}_${listCartItem[index].coffee.name}'),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              _removeCartItem(index);
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: Colors.transparent,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: 120,
                                width: 60,
                                child: Card(
                                  color: const Color(0xFFFFE5E5),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/delete.svg',
                                      colorFilter: const ColorFilter.mode(
                                          Color(0xFFFF3030), BlendMode.srcIn),
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CartCard(
                                cartItemModel: listCartItem[index],
                              ),
                            ));
                      });
                } else if (state is CartError) {
                  return Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/not_found.svg',
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/pics/coffee (3).png',
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      ],
                    ),
                  );
                }
              })),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 100,
                  width: screenWidth - 50,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalPrice,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            NumberFormat.simpleCurrency().format(totalPrice),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 51,
                        width: 162,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary, // Màu nền của nút
                              elevation: 2, // Độ cao (bóng đổ)
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return _showBottomSheet(context);
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/buy.svg',
                                  height: 24,
                                  width: 24,
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.surface,
                                      BlendMode.srcIn),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.checkOut,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
