import 'package:coffee_online_store/view/auth/forgot_password_screen.dart';
import 'package:coffee_online_store/view/auth/signup_screen.dart';
import 'package:coffee_online_store/view/main/ad/ad_screen.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_bloc.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn(String email, String password) {
    context.read<AuthBloc>().add(SignInEvent(email, password));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AdScreen()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.message,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.surface),
            )));
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(41),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.signIn,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 21),
                  Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 46),
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _emailController,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.emailAddress,
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 1,
                                  ),
                                ),
                                prefixIcon: SizedBox(
                                  width: 50,
                                  height: 29,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.mail_outline,
                                        size: 18,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: VerticalDivider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          thickness: 1,
                                          width: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                suffixIcon: _emailController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.clear_sharp,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          _emailController.clear();
                                        },
                                      )
                                    : null,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            );
                          },
                        ),
                        const SizedBox(height: 36),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.password,
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1,
                              ),
                            ),
                            prefixIcon: SizedBox(
                              width: 50,
                              height: 29,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.lock_outline,
                                    size: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: VerticalDivider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      thickness: 1,
                                      width: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons
                                        .visibility,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText =
                                      !_obscureText;
                                });
                              },
                            ),
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                          obscureText: _obscureText,
                        ),
                        const SizedBox(height: 24),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen()));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid,
                                  ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: screenHeight * 0.25, right: 47),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      _signIn(_emailController.text, _passwordController.text);
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
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 71, left: 41),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.newMember,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUp,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
