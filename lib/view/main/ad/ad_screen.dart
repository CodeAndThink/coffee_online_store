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
  bool _showWidgetAfterAnimation = false;
  @override
  void initState() {
    super.initState();
    _fetchCoffeData();
    // Tạo AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Thời gian của hoạt ảnh
      vsync: this,
    );

    // Khởi tạo Offset Animation
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.75),
      end: const Offset(0.0, 0.25),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Khởi tạo Fade Animation
    _fadeAnimation = Tween<double>(
      begin: 0.0, // Bắt đầu với opacity 0 (ẩn)
      end: 1.0, // Kết thúc với opacity 1 (hiện)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Thêm AnimationStatusListener
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showWidgetAfterAnimation = true;
        });
      }
    });

    // Bắt đầu hoạt ảnh
    _controller.forward();
  }

  void _fetchCoffeData() {
    context.read<CoffeeDataBloc>().add(FetchCoffeeType());
  }

  void _showToast(BuildContext context, String message) {
    // Lấy ScaffoldMessengerState từ context
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Kiểm tra nếu không có SnackBar đang hiển thị
    if (scaffoldMessenger.mounted) {
      // Hiển thị SnackBar mới
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
    _controller.dispose(); // Dọn dẹp controller khi không cần thiết
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
                opacity: 0.6, // Giá trị độ trong suốt (từ 0.0 đến 1.0)
                child: Image.asset(
                  'assets/pics/ad_background.jpg',
                  fit: BoxFit.fitHeight,
                ),
              )),
          SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
                opacity: _fadeAnimation, // Áp dụng Fade Animation
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
                                  .withOpacity(
                                      0.5), // Màu và độ trong suốt của shadow
                              spreadRadius: 30, // Độ lan của shadow
                              blurRadius: 20, // Độ mờ của shadow
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
                            offset: const Offset(
                                3.0, 3.0), // Độ lệch của shadow (x, y)
                            blurRadius: 8.0, // Độ mờ của shadow
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(
                                    0.8), // Màu sắc và độ trong suốt của shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          if (_showWidgetAfterAnimation)
            Positioned(
                top: 50,
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
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                        (Route<dynamic> route) => false);
                  } else if (state is DataError) {
                    _showToast(context, state.message);
                  } else {}
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
                })),
        ],
      ),
    );
  }
}
