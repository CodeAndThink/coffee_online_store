import 'package:coffee_online_store/view/auth/email_code_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(41),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 21),
                Text(
                  AppLocalizations.of(context)!.enterEmail,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 46),
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _textEditingController,
                        builder: (context, value, child) {
                          return TextFormField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.emailAddress,
                              hintStyle: Theme.of(context).textTheme.bodySmall,
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
                              suffixIcon: _textEditingController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear_sharp,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        _textEditingController.clear();
                                      },
                                    )
                                  : null,
                            ),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.5, right: 47),
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
                            builder: (context) =>
                                const EmailCodeVerificationScreen()));
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
