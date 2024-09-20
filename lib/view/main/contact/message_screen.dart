import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.shipperName});
  final String shipperName;

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
      });
      _messageController.clear(); // Xóa nội dung sau khi gửi
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime); // Định dạng 12 giờ với AM/PM
  }

  Widget _chatBox(int index) {
    return Align(
        alignment:
            index % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              index % 2 == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _messages[index],
                style: TextStyle(
                    color: index % 2 == 0 ? Colors.white : Colors.black),
              ),
            ),
            Text(
              _formatTime(DateTime.now()),
              textAlign: index % 2 == 0 ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          widget.shipperName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _chatBox(index);
              },
            )),
            SafeArea(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                controller: _messageController,
                style: Theme.of(context).textTheme.headlineSmall,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.saySomething,
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2),
                  ),
                  //Outline when not input
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  //Outline when input
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2),
                  ),
                  //Icon
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/send.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.dstIn),
                    ),
                    onPressed: () {
                      _sendMessage();
                      _messageController.clear();
                    },
                  ),
                ),
                onChanged: (value) {},
              ),
            ))
          ],
        ),
      ),
    );
  }
}
