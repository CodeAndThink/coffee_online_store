import 'package:coffee_online_store/firebase_options.dart';
import 'package:coffee_online_store/model/connection/local/cart_service.dart';
import 'package:coffee_online_store/model/connection/repository/authentication_repository.dart';
import 'package:coffee_online_store/model/connection/repository/coffee_data_repository.dart';
import 'package:coffee_online_store/view/introduction/introduction_screen.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/map_bloc/map_service_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/settings_bloc/settings_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/settings_bloc/settings_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final CartService cartService = CartService();
  final CoffeeDataRepository coffeeDataRepository =
      CoffeeDataRepository(cartService);
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(FirebaseAuth.instance);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => SettingsBloc()),
    BlocProvider(create: (context) => AuthBloc(authenticationRepository)),
    BlocProvider(create: (context) => CoffeeDataBloc(coffeeDataRepository)),
    BlocProvider(create: (context) => CartServiceBloc(coffeeDataRepository)),
    BlocProvider(create: (context) => MapServiceBloc()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return MaterialApp(
        theme: state.themeData,
        locale: state.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const IntroductionScreen(),
      );
    });
  }
}
