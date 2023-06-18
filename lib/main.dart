import 'package:flutter/material.dart';
import 'package:google_mao/config/config.dart';
import 'package:google_mao/features/auth/presentacion/providers/login_form_provider.dart';
// import 'package:google_mao/order_traking_page.dart';
import 'package:provider/provider.dart';

// import 'config/config.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
        )
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
