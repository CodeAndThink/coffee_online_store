import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:coffee_online_store/view/main/cart/cart_screen.dart';
import 'package:coffee_online_store/view/main/detail/detail_screen.dart';
import 'package:coffee_online_store/view/main/home/item/coffee_card.dart';
import 'package:coffee_online_store/view/main/profile/profile_screen.dart';
import 'package:flutter/material.dart';
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

  final List<CoffeeDataModel> data = [
    CoffeeDataModel(
        name: 'Americano', price: 1.2, url: 'assets/pics/americano.png'),
    CoffeeDataModel(
        name: 'Cappuccino', price: 2.3, url: 'assets/pics/cappuccino.png'),
    CoffeeDataModel(
        name: 'Flat White', price: 3.4, url: 'assets/pics/flat_white.png'),
    CoffeeDataModel(name: 'Mocha', price: 4.5, url: 'assets/pics/mocha.png'),
    CoffeeDataModel(
        name: 'Coffee 1', price: 5.6, url: 'assets/pics/coffee (2).png'),
    CoffeeDataModel(
        name: 'Coffee 2', price: 6.7, url: 'assets/pics/coffee (3).png'),
    CoffeeDataModel(
        name: 'Coffee 3', price: 7.8, url: 'assets/pics/coffee (4).png'),
    CoffeeDataModel(
        name: 'Coffee 1', price: 5.6, url: 'assets/pics/coffee (2).png'),
    CoffeeDataModel(
        name: 'Coffee 2', price: 6.7, url: 'assets/pics/coffee (3).png'),
    CoffeeDataModel(
        name: 'Coffee 3', price: 7.8, url: 'assets/pics/coffee (4).png'),
    CoffeeDataModel(
        name: 'Americano', price: 1.2, url: 'assets/pics/americano.png'),
    CoffeeDataModel(
        name: 'Cappuccino', price: 2.3, url: 'assets/pics/cappuccino.png'),
    CoffeeDataModel(
        name: 'Flat White', price: 3.4, url: 'assets/pics/flat_white.png'),
    CoffeeDataModel(name: 'Mocha', price: 4.5, url: 'assets/pics/mocha.png'),
    CoffeeDataModel(
        name: 'Coffee 1', price: 5.6, url: 'assets/pics/coffee (2).png'),
    CoffeeDataModel(
        name: 'Coffee 2', price: 6.7, url: 'assets/pics/coffee (3).png'),
    CoffeeDataModel(
        name: 'Coffee 3', price: 7.8, url: 'assets/pics/coffee (4).png'),
    CoffeeDataModel(
        name: 'Coffee 1', price: 5.6, url: 'assets/pics/coffee (2).png'),
    CoffeeDataModel(
        name: 'Coffee 2', price: 6.7, url: 'assets/pics/coffee (3).png'),
    CoffeeDataModel(
        name: 'Coffee 3', price: 7.8, url: 'assets/pics/coffee (4).png'),
  ];

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
                Text(
                  'Trg1432001',
                  style: Theme.of(context).textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const Spacer(),
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
          child: Column(
            children: [
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
                            child: Column(
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
                                        '4 / 8',
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
                                    children: List.generate(
                                      8,
                                      (index) => SvgPicture.asset(
                                          'assets/icons/inactive_cup.svg'),
                                    ),
                                  )),
                                )
                              ],
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
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: _scrollController,
                                itemCount: (data.length / 4).ceil(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final int startIndex = index * 4;
                                  final int endIndex =
                                      (startIndex + 4) < data.length
                                          ? startIndex + 4
                                          : data.length;

                                  final List<CoffeeDataModel> pageData =
                                      data.sublist(startIndex, endIndex);

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
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SmoothPageIndicator(
                                  controller:
                                      _scrollController, // Controller của PageView
                                  count: (data.length / 4)
                                      .ceil(), // Số lượng trang
                                  effect: WormEffect(
                                    dotColor: Theme.of(context)
                                        .colorScheme
                                        .surface, // Màu dot
                                    activeDotColor: Theme.of(context)
                                        .colorScheme
                                        .primary, // Màu dot active
                                    dotHeight: 8,
                                    dotWidth: 10,
                                    spacing: 5, // Khoảng cách giữa các dot
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
