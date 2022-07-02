import 'package:kotgltd/features/auth/pages/widgets/forgot_password_widget.dart';
import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/features/auth/providers/auth_state.dart';
import 'package:kotgltd/features/team/pages/team_page.dart';
import 'package:kotgltd/features/team/widgets/create_team_widget.dart';
import 'package:kotgltd/features/team/widgets/join_team_widget.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/features.dart';
import 'package:kotgltd/packages/pages.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = GoRouterRefreshStream(
    ref.watch(authStateProvider.stream),
  );

  ref.onDispose(() {
    listenable.dispose();
  });

  return GoRouter(
    initialLocation: "/auth",
    debugLogDiagnostics: true,
    redirect: (state) {
      // We want to READ the state, here.
      // GoRouter is already aware of state changes through `refreshListenable`
      // We don't want to trigger a rebuild of this provider.
      final user = ref.read(authStateProvider).value;

      // From here we can use the state and implement our custom logic
      // var isLoggingIn = state.location == '/auth';

      if (user == AuthState.isNotLoggedIn) {
        switch (state.location) {
          case '/auth/register':
            state.location == '/auth/register';
            break;
          case '/auth':
            state.location == '/auth';
            break;
          // case '/':
          //   state.location == '/auth';
          //   break;
          default:
        }
      }

      // At this point, IF we're in the login page, go to the home page
      if (user == AuthState.isLoggedIn) {
        switch (state.location) {
          case '/dashboard':
            state.location == '/dashboard';
            break;
          case '/auth':
            return '/dashboard';

          // case '/':
          //   state.location == '/auth';
          //   break;
          default:
        }
      }

      // There's no need for a redirect at this point.
      return null;
    },
    // This is crucial to make the router work with Riverpod.
    refreshListenable: listenable,
    routes: [
      GoRoute(
          path: '/auth',
          builder: (context, state) => SignInPage(),
          routes: [
            GoRoute(
              path: 'register',
              builder: (context, state) => SignUpPage(),
            ),
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) => ForgotPasswordPage(),
            ),
          ]),
      GoRoute(
          path: '/dashboard',
          builder: (context, state) => DashboardPage(),
          routes: [
            GoRoute(
                path: 'profile',
                builder: (context, state) => ProfilePage(),
                routes: []),
            GoRoute(
                path: 'team',
                builder: (context, state) => TeamsPage(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => CreateTeamWidget(),
                  ),
                  GoRoute(
                    path: 'join',
                    builder: (context, state) => JoinTeamWidget(),
                  ),
                ]),
            GoRoute(
                path: 'tickets',
                builder: (context, state) => TicketsPage(),
                routes: []),
            GoRoute(
                path: 'events',
                builder: (context, state) => TicketsPage(),
                routes: []),
          ]),
    ],
  );
});
