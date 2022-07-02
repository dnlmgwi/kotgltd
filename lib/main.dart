import 'package:flutter/services.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/team/model/team.dart';
import 'package:kotgltd/features/wallet/models/wallet.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
import 'package:kotgltd/pages/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kotgBlack,
    systemNavigationBarColor: kotgBlack,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TokenAdapter());
  Hive.registerAdapter(TeamAdapter());
  Hive.registerAdapter(WalletAdapter());
  await Hive.openBox<User>('user');
  await Hive.openBox<Team>('team');
  await Hive.openBox<Token>('token');

  //Remove #
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        title: 'King of The Grid Esports',
        theme: ThemeData(
            focusColor: kotgGreen,
            highlightColor: kotgGreen,
            colorScheme:
                ColorScheme.dark(primary: kotgGreen, secondary: kotgGreen),
            backgroundColor: kotgBlack,
            canvasColor: kotgBlack),
        themeMode: ThemeMode.dark,
      );
    });
  }
}
