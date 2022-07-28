import 'package:kotgltd/features/auth/pages/forgot_password_page.dart';
import 'package:kotgltd/features/auth/providers/auth_providers.dart';
import 'package:kotgltd/features/auth/providers/auth_state.dart';
import 'package:kotgltd/features/checkout/payment_approval.dart';
import 'package:kotgltd/features/profile/pages/birthday_page.dart';
import 'package:kotgltd/features/profile/pages/gender_page.dart';
import 'package:kotgltd/features/profile/pages/name_page.dart';
import 'package:kotgltd/features/profile/pages/phoneNumber_page.dart';
import 'package:kotgltd/features/stories/pages/stories_page.dart';
import 'package:kotgltd/features/stories/pages/story_page.dart';
import 'package:kotgltd/features/team/pages/team_page.dart';
import 'package:kotgltd/features/team/widgets/create_team_widget.dart';
import 'package:kotgltd/features/team/widgets/join_team_widget.dart';
import 'package:kotgltd/features/tickets/pages/payment_page.dart';
import 'package:kotgltd/features/tickets/pages/ticket_page.dart';
import 'package:kotgltd/features/transactions/pages/transactions_page.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/features.dart';
import 'package:kotgltd/packages/pages.dart';
import 'package:kotgltd/pages/errorScreen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = GoRouterRefreshStream(
    ref.watch(authStateProvider.stream),
  );

  ref.onDispose(() {
    listenable.dispose();
  });

  return GoRouter(
    initialLocation: "/auth",
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorScreen(state.error!),
    ),
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
          case '/':
            state.location == '/';
            break;
          case '/auth':
            return '/';

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
      GoRoute(path: '/', builder: (context, state) => DashboardPage(), routes: [
        GoRoute(
          path: 'transactions',
          builder: (context, state) => TransactionsPage(),
        ),
        GoRoute(
            path: 'stories',
            builder: (context, state) => StoriesPage(),
            routes: [
              GoRoute(
                path: 'post',
                builder: (context, state) {
                  final postId = state.queryParams['id'];
                  final slug = state.queryParams['slug'];

                  return StoryPage(
                    id: postId!,
                    slug: slug!,
                  );
                },
              ),
            ]),
        GoRoute(
            path: 'profile',
            builder: (context, state) => ProfilePage(),
            routes: [
              GoRoute(
                path: 'name',
                builder: (context, state) {
                  final firstName = state.queryParams['firstName'];
                  final lastName = state.queryParams['lastName'];

                  return NamePage(
                    firstName: firstName!,
                    lastName: lastName!,
                  );
                },
              ),
              GoRoute(
                  path: 'gender',
                  builder: (context, state) {
                    final gender = state.queryParams['gender'];

                    return GenderPage(gender: gender!);
                  }),
              GoRoute(
                  path: 'birthday',
                  builder: (context, state) {
                    final birthday = state.queryParams['dob'];

                    return BirthdayPage(
                      birthday: birthday!,
                    );
                  }),
              GoRoute(
                  path: 'phoneNumber',
                  builder: (context, state) {
                    final phoneNumber = state.queryParams['phoneNumber'];

                    return PhoneNumberPage(
                      phoneNumber: phoneNumber!,
                    );
                  }),
            ]),
        GoRoute(
            path: 'team',
            builder: (context, state) => SelectGamePage(),
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
            builder: (context, state) => EventsPage(),
            routes: [
              GoRoute(
                path: 'ticket/:id',
                builder: (context, state) {
                  final eventId = state.params['id'];

                  return TicketPage(
                    eventId: eventId!,
                  );
                },
              ),
              GoRoute(
                path: 'payment',
                builder: (context, state) {
                  final ticketRef = state.queryParams['ref'];
                  final name = state.queryParams['name'];
                  final price = state.queryParams['price'];

                  return PaymentPage(
                    ticketRef: ticketRef!,
                    eventName: name!,
                    price: price!,
                  );
                },
              ),
            ]),
      ]),
      GoRoute(
        path: '/payment-approval',
        builder: (context, state) => PaymentApprovalPage(),
      ),
    ],
  );
});
