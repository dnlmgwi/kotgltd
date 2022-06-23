import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/packages/features.dart';
import 'package:kotgltd/packages/pages.dart';

class Pages {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: '/signin',
      page: () => SignInPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/signup',
      page: () => SignUpPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/events',
      page: () => EventsPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/tickets',
      page: () => TicketsPage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: '/profile',
      page: () => UpdateProfileWidget(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/event/:id',
      page: () => EventDetailsWidget(),
      transition: Transition.zoom,
    ), // Dynamic route
    GetPage(
        name: '/dashboard',
        page: () => DashboardPage(),
        transition: Transition.fade),
    // GetPage(
    //     name: '/createTeam',
    //     page: () => CreateTeamWidget(),
    //     transition: Transition.fade),
    // GetPage(
    //     name: '/joinTeam',
    //     page: () => JoinTeamWidget(),
    //     transition: Transition.fade),
    // GetPage(
    //   name: '/joinRequests',
    //   page: () => InviteRequestsPage(),
    //   transition: Transition.fade,
    // )
  ];
}
