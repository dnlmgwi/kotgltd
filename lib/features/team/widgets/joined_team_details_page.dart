// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:kotgltd/features/team/providers/team_providers.dart';
// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/packages/dependencies.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:lottie/lottie.dart';
// import 'package:share_plus/share_plus.dart';

// class JoinedTeamDetailsPage extends ConsumerWidget {
//   JoinedTeamDetailsPage({Key? key}) : super(key: key);

//   final TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context, ref) {
//     final _userRepo = ref.watch(teamRepoProvider);
//     final _inviteRepo = ref.watch(inviteRepoProvider);

//     void _showOptionsBottomSheet(
//         {required String inviteCode, required String teamId}) async {
//       await Get.bottomSheet(Container(
//         width: double.infinity,
//         height: 60.h,
//         color: kotgBlack,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15, top: 18, bottom: 25),
//               child: Text(
//                 'Options',
//                 style: GoogleFonts.sarala(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 26.sp,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Ionicons.share_outline),
//               title: Text('Send Invite Code'),
//               subtitle: Text(
//                   'Send Invite Code to your friends so that you can take part together'),
//               onTap: () {
//                 Share.share(inviteCode);
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Ionicons.exit_outline,
//                 color: Colors.red,
//               ),
//               title: Text(
//                 'Leave Team',
//                 style: TextStyle(
//                   color: Colors.red,
//                 ),
//               ),
//               subtitle: Text('You will no longer be part of this team'),
//               onTap: () {
//                 _userRepo.leaveTeam().then((value) {
//                   ref.refresh(teamRepoProvider);
//                   context.pop();
//                 });
//               },
//             ),
//           ],
//         ),
//       ));

//       // The code below will run after the bottom sheet goes away
//       print('The Bottom Sheet has gone away!');
//     }

//     return LoaderOverlay(
//       overlayOpacity: 0.8,
//       child: Scaffold(
//           body: SafeArea(
//         child: FutureBuilder(
//             // Initialize FlutterFire:
//             future: _userRepo.getJoinedTeam(),
//             builder: (context, snapshot) {
//               // Check for errors
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Icon(
//                     Ionicons.pulse_outline,
//                     color: Colors.white,
//                   ),
//                 );
//               }
//               // Once complete, show your application
//               if (snapshot.connectionState == ConnectionState.done) {
//                 var team = snapshot.data as List;

//                 if (team[0]['team'] == null) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Lottie.asset(
//                             'assets/images/game-console-animation.json'),
//                         Text(
//                           'Request sent, now we wait.',
//                           style: GoogleFonts.sarala(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 20.sp,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: team.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 35, top: 30, bottom: 25),
//                                   child: ListTile(
//                                     title: Text(
//                                       team[index]['team']['team_name'],
//                                       style: TextStyle(fontSize: 25.sp),
//                                     ),
//                                     trailing: IconButton(
//                                         onPressed: () {
//                                           _showOptionsBottomSheet(
//                                               inviteCode: team[index]['team']
//                                                   ['invite_code'],
//                                               teamId: team[index]['id']);
//                                         },
//                                         icon: Icon(
//                                           Ionicons.ellipsis_vertical_outline,
//                                         )),

//                                     // Get.toNamed('/joinRequests',
//                                     //     arguments: {
//                                     //       'inviteCode': team[0]['invite_code'],
//                                     //       'teamId': team[0]['id']
//                                     //     })
//                                   ),
//                                 ),
//                               ),
//                               // ListTile(
//                               //   leading: Icon(Ionicons.share_social_outline),
//                               //   title: Text('Send Invite Code'),
//                               //   onTap: () {

//                               //   },
//                               // ),
//                               Divider(),

//                               //   Slidable(
//                               //     actionPane: SlidableDrawerActionPane(),
//                               //     closeOnScroll: true,
//                               //     actionExtentRatio: 1.0,
//                               //     child: Container(
//                               //       child: ListTile(
//                               //         leading: ClipOval(
//                               //           child: Image.network(
//                               //             team[index]['team']['team_members'][index]
//                               //                     ['member']['profile']['avatar']
//                               //                 ['image']['url'],
//                               //             width: 40,
//                               //             height: 40,
//                               //             fit: BoxFit.cover,
//                               //           ),
//                               //         ),
//                               //         title: Text(team[index]['team']
//                               //                 ['team_members'][index]['member']
//                               //             ['username']),
//                               //       ),
//                               //     ),
//                               //     actions: <Widget>[
//                               //       IconSlideAction(
//                               //         caption: 'Leave Team',
//                               //         color: Colors.red,
//                               //         icon: Ionicons.exit_outline,
//                               //         onTap: () => {
//                               //           _userRepo
//                               //               .deleteTeamJoinRequests(
//                               //                   id: team[index]['id'])
//                               //               .then((value) =>
//                               //                   ref.refresh(teamRepoProvider))
//                               //         },
//                               //       ),
//                               //     ],
//                               //   ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }
//               // Otherwise, show something whilst waiting for initialization to complete
//               return Center(child: CircularProgressIndicator());
//             }),
//       )),
//     );
//   }
// }
