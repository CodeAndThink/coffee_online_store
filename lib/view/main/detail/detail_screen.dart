import 'package:coffee_online_store/model/models/cart_item_model.dart';
import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:coffee_online_store/view/main/cart/cart_screen.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.coffee});
  final CoffeeDataModel coffee;

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  final TextEditingController _countController = TextEditingController();
  int _selectedShot = 0;
  int _selectedTemp = 0;
  int _selectedSize = 0;
  int _selectedIce = 0;

  @override
  void initState() {
    super.initState();
    _countController.text = '0';
  }

  void _addCartItem(CartItemModel cartItemModel) {
    context.read<CartServiceBloc>().add(AddCartItem(cartItemModel));
  }

  void _increment() {
    final currentValue = int.tryParse(_countController.text) ?? 0;
    if (currentValue < 100) {
      setState(() {
        _countController.text = (currentValue + 1).toString();
      });
    }
  }

  void _decrement() {
    final currentValue = int.tryParse(_countController.text) ?? 0;
    if (currentValue > 0) {
      setState(() {
        _countController.text = (currentValue - 1).toString();
      });
    }
  }

  void _updateValue(String value) {
    final newValue = int.tryParse(value);
    if (newValue == null || newValue < 0) {
      // Nếu không phải số hoặc số âm, đặt lại giá trị về 0
      _countController.text = '0';
    } else if (newValue > 100) {
      // Nếu số lớn hơn 100, đặt lại giá trị về 100
      _countController.text = '100';
    }
  }

  Widget _appBarLayout() {
    return Row(
      children: [
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.details,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartScreen()));
          },
          icon: SvgPicture.asset('assets/icons/buy.svg'),
          iconSize: 24,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
        appBar: AppBar(
          title: _appBarLayout(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth - 60,
                      height: 146,
                      child: Card(
                        child: Center(
                          child: Image.asset(
                            widget.coffee.url,
                            height: 128,
                            width: 172,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Choose number of products
                          Column(
                            children: [
                              const SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.coffee.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 50,
                                    child: Card(
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                _decrement();
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 14,
                                              )),
                                          SizedBox(
                                            width: 29,
                                            child: TextField(
                                              controller: _countController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              onChanged: _updateValue,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                _increment();
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 14,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 21,
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                            ],
                          ),
                          //Choose number of shot
                          Column(
                            children: [
                              const SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.shot,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedShot = 0;
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        _selectedShot == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .surface,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.single,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: _selectedShot == 0
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .surface
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedShot = 1;
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        _selectedShot == 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .surface,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.double,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: _selectedShot == 1
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .surface
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                            ],
                          ),
                          //Choose type of carry
                          Column(
                            children: [
                              const SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.select,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedTemp =
                                            0; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/hot.svg',
                                      height: 26,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedTemp =
                                            1; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/carry.svg',
                                      height: 34,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                            ],
                          ),
                          //Choose size
                          Column(
                            children: [
                              const SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.size,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedSize =
                                            0; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/cup.svg',
                                      height: 22,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedSize =
                                            1; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/cup.svg',
                                      height: 31,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedSize =
                                            2; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/cup.svg',
                                      height: 38,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 2
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                            ],
                          ),
                          //Choose how many of ice
                          Column(
                            children: [
                              const SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.ice,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedIce =
                                            0; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/ice.svg',
                                      height: 14,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedIce =
                                            1; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/some_ice.svg',
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedIce =
                                            2; // Cập nhật trạng thái khi nhấn icon
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/many_ice.svg',
                                      height: 27,
                                      colorFilter: ColorFilter.mode(
                                        _selectedTemp == 2
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 23),
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      height: 100,
                      width: screenWidth - 60,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.totalAmount,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const Spacer(),
                              Text(
                                NumberFormat.simpleCurrency().format(
                                    widget.coffee.price *
                                        int.parse(_countController.text)),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          BlocListener<CartServiceBloc, CartServiceState>(
                            listener: (context, state) {
                              if (state is CartSaveSuccess) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartScreen()));
                              } else if (state is CartError) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  state.message,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                )));
                              }
                            },
                            child: SizedBox(
                              height: 46,
                              width: screenWidth - 60,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondary, // Màu nền của nút
                                    elevation: 2, // Độ cao (bóng đổ)
                                  ),
                                  onPressed: () {
                                    if (int.parse(_countController.text) > 0) {
                                      final CartItemModel newCartItem =
                                          CartItemModel(
                                              coffee: widget.coffee,
                                              ice: _selectedIce,
                                              quantity: int.parse(
                                                  _countController.text),
                                              shot: _selectedShot,
                                              size: _selectedSize,
                                              temp: _selectedTemp);
                                      _addCartItem(newCartItem);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .pleaseSelectNumberProduct,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface),
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ));
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.checkOut,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
