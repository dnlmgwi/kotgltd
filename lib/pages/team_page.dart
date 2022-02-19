// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/features/team/providers/team_providers.dart';
// import 'package:kotgltd/packages/dependencies.dart';
// import 'package:kotgltd/pages/create_team_widget.dart';
// import 'package:kotgltd/pages/created_team_details_page.dart';
// import 'package:kotgltd/pages/join_team_widget.dart';
// import 'package:kotgltd/pages/joined_team_details_page.dart';
// import 'package:lottie/lottie.dart';

// class TeamsPage extends ConsumerWidget {
//   TeamsPage({Key? key}) : super(key: key);
//   final scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context, ref) {
//     return SafeArea(
//       child: Scaffold(
//           body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15, top: 18, bottom: 15),
//             child: Text(
//               'Team',
//               style: GoogleFonts.sarala(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 26.sp,
//                 color: kotgGreen,
//               ),
//             ),
//           ),
//           Divider(),
//           Expanded(
//             child: Consumer(builder: (context, ref, _) {
//               final currentteamState = ref.watch(teamStateFutureProvider);
//               final teamState = ref.watch(teamStateProvider);
//               return currentteamState.map(data: (data) {
//                 if (teamState == TeamState.captain) {
//                   return CreatedTeamDetailsPage();
//                 } else if (teamState == TeamState.member) {
//                   return JoinedTeamDetailsPage();
//                 } else if (teamState == TeamState.none) {
//                   return TeamsPageOptions();
//                 } else {
//                   return TeamsPageOptions();
//                 }
//               }, loading: (loading) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Opacity(
//                         opacity: 1.0,
//                         child: Lottie.asset('assets/images/joystick.json',
//                             fit: BoxFit.cover, height: 80),
//                       ),
//                       Text(
//                         'Please wait...',
//                         style: GoogleFonts.sarala(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 20.sp,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }, error: (error) {
//                 return Text(error.toString());
//               });
//             }),
//           ),
//         ],
//       )),
//     );
//   }
// }

// class TeamsPageOptions extends StatelessWidget {
//   const TeamsPageOptions({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     void _showBottomSheetCreateTeam() async {
//       await Get.bottomSheet(
//         Container(
//           width: double.infinity,
//           height: 60.h,
//           color: kotgBlack,
//           child: CreateTeamWidget(),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//         ),
//       );

//       // The code below will run after the bottom sheet goes away
//       print('The Bottom Sheet has gone away!');
//     }

//     void _showBottomSheetJoinTeam() async {
//       await Get.bottomSheet(
//         Container(
//           width: double.infinity,
//           height: 60.h,
//           color: kotgBlack,
//           child: JoinTeamWidget(),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       );

//       // The code below will run after the bottom sheet goes away
//       print('The Bottom Sheet has gone away!');
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Container(
//             height: 150,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [kotgPurpleLight, kotgPurpleDark]),
//               borderRadius: BorderRadius.all(Radius.circular(15)),
//             ),
//             child: Stack(
//               alignment: Alignment.centerRight,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Opacity(
//                     opacity: 0.2,
//                     child: Lottie.asset('assets/images/teams_icon.json',
//                         fit: BoxFit.cover, height: 80),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => _showBottomSheetCreateTeam(),
//                   child: ListTile(
//                       // trailing: Container(
//                       //     child: Icon(
//                       //         Ionicons.people_outline)),
//                       subtitle: Text(
//                           'Games are better together. Form a team with other players by inviting them '),
//                       title: Padding(
//                         padding: const EdgeInsets.only(
//                           top: 15,
//                           bottom: 5,
//                         ),
//                         child: Text(
//                           'Create Team',
//                           style: TextStyle(
//                             fontSize: 25.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Container(
//             height: 150,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [kotgGreenLight, kotgGreenDark]),
//               borderRadius: BorderRadius.all(Radius.circular(15)),
//             ),
//             child: Stack(
//               alignment: Alignment.centerRight,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Opacity(
//                     opacity: 0.2,
//                     child: Lottie.asset('assets/images/join_team_icon.json',
//                         fit: BoxFit.cover, height: 80),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => _showBottomSheetJoinTeam(),
//                   child: ListTile(
//                       // trailing: Container(
//                       //     child: Icon(
//                       //   Ionicons.person_add_outline,
//                       //   color: kotgBlack,
//                       // )),
//                       subtitle: Text(
//                           "Join your friend's team by entering an invite code",
//                           style: TextStyle(
//                             color: kotgBlack,
//                           )),
//                       title: Padding(
//                         padding: const EdgeInsets.only(
//                           top: 15,
//                           bottom: 5,
//                         ),
//                         child: Text(
//                           'Join Team',
//                           style: TextStyle(
//                             color: kotgBlack,
//                             fontSize: 25.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
