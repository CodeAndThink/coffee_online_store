import 'package:coffee_online_store/model/models/triple_value_model.dart';
import 'package:coffee_online_store/values/static_values.dart';
import 'package:coffee_online_store/view/introduction/items/introduction_card.dart';
import 'package:coffee_online_store/view/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  IntroductionScreenState createState() => IntroductionScreenState();
}

class IntroductionScreenState extends State<IntroductionScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final localization = AppLocalizations.of(context)!;
    final List<TripleValue> list = TutorialValue(localization).get();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.75,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return IntroductionCard(value: list[index]);
              },
              itemCount: list.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: pageController,
              count: list.length,
              effect: WormEffect(
                dotColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                activeDotColor: Theme.of(context).colorScheme.secondary,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 16,
              ),
              onDotClicked: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 30),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.surface,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
