import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic15/providers/puzzle_provider.dart';
import 'package:provider/provider.dart';
import 'screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // HydratedBloc.storage = await HydratedStorage.build(
  //     storageDirectory: await getApplicationDocumentsDirectory());

  // final storage = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });

  // runApp(const MyApp());

  // final storage = await HydratedStorage.build(
  //     storageDirectory: await getApplicationDocumentsDirectory());
  //
  // HydratedBlocOverrides.runZoned(
  //   () => runApp(const MyApp()),
  //   storage: storage,
  //   blocObserver: MyBlocObserver(),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PuzzleProvider>(
            create: (context) => PuzzleProvider()),
        // ChangeNotifierProvider<FocusProvider>(create: (context) => FocusProvider()),
      ],
      child: Consumer<PuzzleProvider>(
          builder: (context, PuzzleProvider notifier, child) {
            return const MaterialApp(
              // debugShowCheckedModeBanner: false,
              // title: 'Least Squares',
              // theme: notifier.theme,
              home: HomeScreen(),
            );
          }),
    );
    // return BlocProvider(
    //   create: (context) => PuzzleBloc(),
    //   child: MaterialApp(
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: const HomeScreen(),
    //   ),
    // );
  }
}
