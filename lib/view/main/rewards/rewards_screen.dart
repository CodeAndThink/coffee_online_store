import 'package:coffee_online_store/view/main/rewards/item/reward_card.dart';
import 'package:coffee_online_store/view/main/rewards/redeem_screen.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_state.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  RewardsScreenState createState() => RewardsScreenState();
}

class RewardsScreenState extends State<RewardsScreen> {
  @override
  void initState() {
    super.initState();
    _getLocalUserProfile();
  }

  void _getLocalUserProfile() {
    context.read<AuthServiceBloc>().add(GetLocalUserProfile());
  }

  void _loadOrderList(String userDocId) {
    context.read<OrderServiceBloc>().add(LoadOrderByUserDocId(userDocId));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.rewards,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: BlocListener<AuthServiceBloc, AuthServiceState>(
              listener: (context, state) {
            if (state is LoadLocalUserProfileSuccess) {
              _loadOrderList(state.userMetadata.userDocId);
            }
          }, child: BlocBuilder<OrderServiceBloc, OrderServiceState>(
                  builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadOrderSuccess) {
              final listOrders = state.listBill;
              int totalCups = listOrders
                  .expand((coffeeBill) => coffeeBill.listOrderCoffee)
                  .fold(0, (sum, cartItem) => sum + cartItem.quantity);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),

                  // Loyalty Card Section
                  SizedBox(
                    height: 122,
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 9),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.loyaltyCard,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${totalCups.toString()} / 8',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 61,
                              width: screenWidth - 96,
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (int i = 0; i < 8; i++)
                                      i < totalCups % 8
                                          ? SvgPicture.asset(
                                              'assets/icons/inactive_cup.svg',
                                              height: 24,
                                              width: 24,
                                              colorFilter: ColorFilter.mode(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  BlendMode.srcIn),
                                            )
                                          : SvgPicture.asset(
                                              'assets/icons/inactive_cup.svg',
                                              height: 24,
                                              width: 24,
                                            )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 19),

                  // My Points Section
                  SizedBox(
                    height: 122,
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 25, right: 23, bottom: 25),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.myPoints}:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                ),
                                const Spacer(),
                                Text(
                                  (totalCups * 12).toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                )
                              ],
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  backgroundColor: const Color(0xFFA2CDE9)
                                      .withOpacity(0.19)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RedeemScreen()));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.redeemDrinks,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: 12,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 31),

                  // History Rewards Section
                  Text(
                    AppLocalizations.of(context)!.historyRewards,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 15),

                  // List of rewards - Expanded ListView
                  Expanded(
                    child: ListView.builder(
                      itemCount: listOrders.length,
                      itemBuilder: (context, index) {
                        final coffeeBill = listOrders[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: coffeeBill.listOrderCoffee.map((cartItem) {
                            return RewardCard(
                              orderItem: cartItem,
                              orderDateTime: coffeeBill.orderTime,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is OrderError) {
              return Center(
                child:
                    Text(AppLocalizations.of(context)!.loadCoffeeDataFailure),
              );
            } else {
              return Center(
                child: Text(AppLocalizations.of(context)!.noDataAvailable),
              );
            }
          })),
        ));
  }
}
