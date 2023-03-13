import 'package:chatgpt/constants.dart';
import 'package:chatgpt/models/api_model.dart';
import 'package:chatgpt/providers/api_models_provider.dart';
import 'package:chatgpt/providers/messaging_provider.dart';
import 'package:chatgpt/widgets/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController userInputController = TextEditingController();
  ScrollController chatScrollController = ScrollController();
  FocusNode userInputFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    MessagingProvider myMessagingProvider =
        Provider.of<MessagingProvider>(context, listen: false);
    myMessagingProvider.addListener(() async {
      Future.delayed(const Duration(milliseconds: 300))
          .then((value) => chatScrollController.animateTo(
                chatScrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ));
    });

    return Consumer2<APIModelProvider, MessagingProvider>(
        builder: (context, apiProvider, msgProvider, __) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ChatGPT',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () async =>
                  openModelSelectionModel(context, apiProvider),
              child: Text(
                apiProvider.currentModel,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: msgProvider.clearChat,
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatScrollController,
                itemCount: msgProvider.chats.length,
                itemBuilder: (c, i) => Chat(
                  message: msgProvider.chats.elementAt(i).message,
                  sender: msgProvider.chats.elementAt(i).sender,
                ),
              ),
            ),
            Container(
              color: cardColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: userInputFocus,
                      controller: userInputController,
                      onSubmitted: (val) =>
                          onSubmitQuery(apiProvider, msgProvider),
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Ask your question here',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () => onSubmitQuery(apiProvider, msgProvider),
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void onSubmitQuery(
      APIModelProvider apiProvider, MessagingProvider msgProvider) {
    msgProvider.appendMessage(
        apiProvider.currentModel, userInputController.text);
    userInputController.clear();
    userInputFocus.unfocus();
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> openModelSelectionModel(
      BuildContext context, APIModelProvider provider) async {
    final String? model = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) => FutureBuilder(
        future: provider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No data',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          List<APIModel> models = snapshot.data!;

          return ListView.builder(
            itemCount: models.length,
            itemBuilder: (context, index) {
              APIModel apiModel = models.elementAt(index);
              return ListTile(
                title: Text(
                  apiModel.id,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () => Navigator.of(context).pop(apiModel.id),
              );
            },
          );
        },
      ),
    );
    if (model != null) {
      provider.setModel(model);
    }
  }
}
