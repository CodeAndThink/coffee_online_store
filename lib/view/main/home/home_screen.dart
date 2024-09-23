import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:coffee_online_store/view/main/cart/cart_screen.dart';
import 'package:coffee_online_store/view/main/detail/detail_screen.dart';
import 'package:coffee_online_store/view/main/home/item/coffee_card.dart';
import 'package:coffee_online_store/view/main/profile/profile_screen.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_state.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_state.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PageController _scrollController = PageController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    context.read<AuthServiceBloc>().add(GetLocalUserProfile());
  }

  void _loadOrderList(String userDocId) {
    context.read<OrderServiceBloc>().add(LoadOrderByUserDocId(userDocId));
  }

  String _detectCurrentTime() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour >= 5 && hour < 12) {
      return AppLocalizations.of(context)!
          .goodMorning; // Buổi sáng từ 5 giờ đến 11 giờ 59
    } else if (hour >= 12 && hour < 18) {
      return AppLocalizations.of(context)!
          .goodAfternoon; // Buổi chiều từ 12 giờ đến 17 giờ 59
    } else {
      return AppLocalizations.of(context)!
          .goodEvening; // Buổi tối từ 18 giờ đến 4 giờ 59
    }
  }

  Widget _appBarLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          //
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _detectCurrentTime(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                BlocBuilder<AuthServiceBloc, AuthServiceState>(
                    builder: (context, state) {
                  if (state is LoadLocalUserProfileSuccess) {
                    return Text(
                      state.userMetadata.userData.displayName,
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    );
                  } else {
                    return Text(
                      AppLocalizations.of(context)!.noDataAvailable,
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                })
              ],
            ),
          ),
          const Spacer(),
          //Cart screen
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            icon: SvgPicture.asset('assets/icons/buy.svg'),
            iconSize: 26,
          ),
          const SizedBox(
            width: 10,
          ),
          //Profile screen
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            icon: SvgPicture.asset('assets/icons/profile.svg'),
            iconSize: 26,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
        appBar: AppBar(
          title: _appBarLayout(context),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 122,
                  child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: BlocListener<AuthServiceBloc, AuthServiceState>(
                          listener: (context, state) {
                            if (state is LoadLocalUserProfileSuccess) {
                              _loadOrderList(state.userMetadata.userDocId);
                            }
                          },
                          child:
                              BlocBuilder<OrderServiceBloc, OrderServiceState>(
                                  builder: (context, state) {
                            if (state is OrderLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is LoadOrderSuccess) {
                              final listOrders = state.listBill;
                              int totalCups = listOrders
                                  .expand((coffeeBill) =>
                                      coffeeBill.listOrderCoffee)
                                  .fold(
                                      0,
                                      (sum, cartItem) =>
                                          sum + cartItem.quantity);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7, right: 7, bottom: 9),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .loyaltyCard,
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
                                                    colorFilter:
                                                        ColorFilter.mode(
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
                                        ])),
                                  )
                                ],
                              );
                            } else if (state is OrderError) {
                              return Text(
                                AppLocalizations.of(context)!
                                    .loadCoffeeDataFailure,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                overflow: TextOverflow.ellipsis,
                              );
                            } else {
                              return Text(
                                AppLocalizations.of(context)!.noDataAvailable,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                overflow: TextOverflow.ellipsis,
                              );
                            }
                          }),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.chooseCoffeeTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      width: screenWidth,
                      height: 430,
                      child: BlocBuilder<CoffeeDataBloc, CoffeeDataState>(
                          builder: (context, state) {
                        if (state is DataLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is DataLoaded) {
                          final List<CoffeeDataModel> listData = state.listData;
                          return Column(
                            children: [
                              Expanded(
                                  child: PageView.builder(
                                controller: _scrollController,
                                itemCount: (listData.length / 4).ceil(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final int startIndex = index * 4;
                                  final int endIndex =
                                      (startIndex + 4) < listData.length
                                          ? startIndex + 4
                                          : listData.length;

                                  final List<CoffeeDataModel> pageData =
                                      listData.sublist(startIndex, endIndex);

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 230.0,
                                      childAspectRatio: 1,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: pageData.length,
                                    itemBuilder: (context, gridIndex) {
                                      return CoffeeCard(
                                        coffee: pageData[gridIndex],
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen(
                                                        coffee:
                                                            pageData[gridIndex],
                                                      )));
                                        },
                                      );
                                    },
                                  );
                                },
                              )),
                              const SizedBox(
                                height: 9,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: SmoothPageIndicator(
                                    controller: _scrollController,
                                    count: (listData.length / 4).ceil(),
                                    effect: WormEffect(
                                      dotColor:
                                          Theme.of(context).colorScheme.surface,
                                      activeDotColor:
                                          Theme.of(context).colorScheme.primary,
                                      dotHeight: 8,
                                      dotWidth: 10,
                                      spacing: 5,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (state is DataError) {
                          return Center(
                              child: Text(
                            AppLocalizations.of(context)!.dataLoadError,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ));
                        } else {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!.noDataAvailable,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          );
                        }
                      })),
                ],
              ),
            ),
          )
        ])));
  }
}
