import 'dart:async';
import 'package:coffee_online_store/values/static_values.dart';
import 'package:coffee_online_store/view/main/ad/ad_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailCodeVerificationScreen extends StatefulWidget {
  const EmailCodeVerificationScreen({super.key});

  @override
  EmailCodeVerificationScreenState createState() =>
      EmailCodeVerificationScreenState();
}

class EmailCodeVerificationScreenState
    extends State<EmailCodeVerificationScreen> {
  bool timeUp = false;
  late int _remainingSeconds; // Thời gian còn lại
  Timer? _timer; // Bộ đếm thời gian

  Future<bool> _countdown(int seconds) async {
    _remainingSeconds = seconds;
    final Completer<bool> completer = Completer<bool>();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          timeUp = true;
        }); // Trả về true khi bộ đếm kết thúc
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });

    return completer.future; // Trả về Future<bool>
  }

  @override
  void initState() {
    super.initState();
    _countdown(AuthValue().resendTime);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _textBoxCode(BuildContext context) {
    return SizedBox(
      height: 61,
      width: 48,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

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
                  padding: const EdgeInsets.only(left: 57, right: 57),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textBoxCode(context),
                          _textBoxCode(context),
                          _textBoxCode(context),
                          _textBoxCode(context),
                        ],
                      ),
                      const SizedBox(
                        height: 43,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.resendTime,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('$minutes:$seconds',
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          timeUp
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: screenHeight * 0.5, right: 47),
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
                                  builder: (context) => const AdScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).colorScheme.surface,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
