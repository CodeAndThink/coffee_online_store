import 'package:coffee_online_store/view/main/rewards/item/redeem_card.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  RedeemScreenState createState() => RedeemScreenState();
}

class RedeemScreenState extends State<RedeemScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          AppLocalizations.of(context)!.redeem,
          style: Theme.of(context).textTheme.headlineMedium,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: BlocBuilder<CoffeeDataBloc, CoffeeDataState>(
            builder: (context, state) {
          if (state is DataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DataLoaded) {
            final listCoffee = state.listData;
            return ListView.builder(
                itemCount: listCoffee.length,
                itemBuilder: (context, index) {
                  return RedeemCard(coffeeData: listCoffee[index]);
                });
          } else if (state is DataError) {
            return Center(
              child: Text(AppLocalizations.of(context)!.loadCoffeeDataFailure),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.noDataAvailable),
            );
          }
        }),
      ),
    );
  }
}
