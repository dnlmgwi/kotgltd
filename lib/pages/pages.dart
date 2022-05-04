import 'package:kotgltd/features/auth/pages/sign_in_page.dart';
import 'package:kotgltd/features/auth/pages/sign_up_page.dart';
import 'package:kotgltd/features/events/pages/event_details_page.dart';
import 'package:kotgltd/features/profile/widgets/update_profile_widget.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/pages/create_team_widget.dart';
import 'package:kotgltd/pages/dashboard_page.dart';
import 'package:kotgltd/features/events/pages/events_page.dart';
import 'package:kotgltd/pages/invite_requests_widget.dart';
import 'package:kotgltd/pages/join_team_widget.dart';

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
