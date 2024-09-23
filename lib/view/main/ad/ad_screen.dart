import 'package:coffee_online_store/view/main/main_screen.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({super.key});

  @override
  AdScreenState createState() => AdScreenState();
}

class AdScreenState extends State<AdScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.75),
      end: const Offset(0.0, 0.25),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fetchCoffeData();
      }
    });

    _controller.forward();
  }

  void _fetchCoffeData() {
    context.read<CoffeeDataBloc>().add(FetchCoffeeType());
  }

  void _showToast(BuildContext context, String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (scaffoldMessenger.mounted) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/pics/ad_background.jpg',
                  fit: BoxFit.fitHeight,
                ),
              )),
          SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.5),
                              spreadRadius: 30,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/pics/coffee (3).png',
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Text(
                      AppLocalizations.of(context)!.shopName,
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 8.0,
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            top: screenHeight * 0.75,
            child: BlocConsumer<CoffeeDataBloc, CoffeeDataState>(
                listener: (context, state) {
              if (state is DataLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.loadCoffeeDataSuccess,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  duration: const Duration(seconds: 1),
                ));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (Route<dynamic> route) => false);
              } else if (state is DataError) {
                _showToast(context, state.message);
              }
            }, builder: (context, state) {
              if (state is DataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DataLoaded) {
                return Container();
              } else if (state is DataError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}
