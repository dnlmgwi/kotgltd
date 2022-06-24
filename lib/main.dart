import 'package:flutter/services.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/auth/pages/sign_in_page.dart';
import 'package:kotgltd/features/auth/services/auth_state.dart';
import 'package:kotgltd/features/onBoarding/onBoardingPages.dart';
import 'package:kotgltd/features/onBoarding/onboarding.dart';
import 'package:kotgltd/features/team/model/team.dart';
import 'package:kotgltd/features/wallet/models/wallet.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/models.dart';
import 'package:kotgltd/pages/dashboard_page.dart';
import 'package:kotgltd/pages/pages.dart';
import 'package:kotgltd/services/connection_state/connection_service.dart';
import 'package:kotgltd/services/connection_state/connection_state_providers.dart';
import 'package:lottie/lottie.dart';

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

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
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
        home: Consumer(builder: (context, ref, child) {
          var network = ref.watch(networkStateProvider);
          return network.map(
              data: (data) {
                if (data.value == NetworkStatus.isOn) {
                  return AuthStateWidget(
                      signedInBuilder: (_) => DashboardPage(),
                      // noProfileBuilder: (_) => CreateProfileWidget(),
                      signedOutBuilder: (_) =>
                          OnboardingPage(pages: onBoardingPages));
                } else {
                  return Scaffold(
                    body: Center(
                      child: Lottie.asset('assets/images/8719-t-rex.json'),
                    ),
                  );
                }
              },
              loading: (loading) =>
                  Scaffold(body: Center(child: CircularProgressIndicator())),
              error: (error) =>
                  Scaffold(body: Center(child: CircularProgressIndicator())));
        }),
        getPages: Pages.routes,
      );
    });
  }
}
