import 'package:chatgpt/constants.dart';
import 'package:chatgpt/providers/api_models_provider.dart';
import 'package:chatgpt/providers/messaging_provider.dart';
import 'package:chatgpt/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          color: cardColor,
        ),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => APIModelProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MessagingProvider(),
          ),
        ],
        child: const ChatScreen(),
      ),
    );
  }
}
