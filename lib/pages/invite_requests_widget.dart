// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:kotgltd/features/team/providers/team_providers.dart';
// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/packages/dependencies.dart';

// class InviteRequestsPage extends ConsumerWidget {
//   InviteRequestsPage({Key? key}) : super(key: key);

//   // final TextEditingController controller = TextEditingController();
//   final TextEditingController inviteCodeController = TextEditingController();

//   @override
//   Widget build(BuildContext context, ref) {
//     final _userRepo = ref.watch(teamRepoProvider);

//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15, top: 18, bottom: 25),
//               child: Text(
//                 'Manage Team',
//                 style: GoogleFonts.sarala(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 26.sp,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.only(right: 35, left: 35),
//               child: Text(
//                   'Swipe Right to add a gamer or swipe left to remove a gamer',
//                   style: GoogleFonts.sarala(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 10.sp,
//                   )),
//             ),
//             SizedBox(
//               height: 35,
//             ),
//             Container(
//               height: 50.h,
//               child: FutureBuilder(
//                 // Initialize FlutterFire:
//                 future: _userRepo.getJoinRequests(
//                     inviteCode: Get.arguments['inviteCode']!),
//                 builder: (context, snapshot) {
//                   // Check for errors
//                   if (snapshot.hasError) {
//                     return Container(
//                       height: 130,
//                       child: Center(
//                         child: Icon(
//                           Ionicons.pulse_outline,
//                           color: Colors.white,
//                         ), //TODO Error Icon
//                       ),
//                     );
//                   }
//                   // Once complete, show your application
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     var joinRequest = snapshot.data as List;

//                     if (joinRequest.isEmpty) {
//                       //print('project snapshot data is: ${projectSnap.data}');
//                       return Center(
//                         child: Text("We couldn't find any requests",
//                             style: GoogleFonts.sarala(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 10.sp,
//                               color: Colors.grey,
//                             )),
//                       );
//                     }
//                     return Container(
//                       height: 50.h,
//                       child: ListView.builder(
//                           itemCount: joinRequest.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Slidable(
//                               closeOnScroll: true,
//                               child: ListTile(
//                                 // leading: CircleAvatar(),
//                                 title: Text(
//                                     joinRequest[index]['member']['username']),
//                                 subtitle:
//                                     Text(joinRequest[index]['member']['email']),
//                                 trailing:
//                                     (joinRequest[index]['claimed'] as bool)
//                                         ? Text('Member')
//                                         : Container(),
//                               ),
//                               startActionPane: ActionPane(
//                                 // A motion is a widget used to control how the pane animates.
//                                 motion: const ScrollMotion(),

//                                 // A pane can dismiss the Slidable.
//                                 dismissible:
//                                     DismissiblePane(onDismissed: () {}),

//                                 // All actions are defined in the children parameter.
//                                 children: const [
//                                   // A SlidableAction can have an icon and/or a label.
//                                   SlidableAction(
//                                     onPressed: doNothing,
//                                     backgroundColor: Color(0xFFFE4A49),
//                                     foregroundColor: Colors.white,
//                                     icon: Icons.delete,
//                                     label: 'Delete',
//                                   ),
//                                   SlidableAction(
//                                     onPressed: doNothing,
//                                     backgroundColor: Color(0xFF21B7CA),
//                                     foregroundColor: Colors.white,
//                                     icon: Icons.share,
//                                     label: 'Share',
//                                   ),
//                                 ],
//                               ),

//                               // The end action pane is the one at the right or the bottom side.
//                               endActionPane: const ActionPane(
//                                 motion: ScrollMotion(),
//                                 children: [
//                                   SlidableAction(
//                                     // An action can be bigger than the others.
//                                     flex: 2,
//                                     onPressed: doNothing,
//                                     backgroundColor: Color(0xFF7BC043),
//                                     foregroundColor: Colors.white,
//                                     icon: Icons.archive,
//                                     label: 'Archive',
//                                   ),
//                                   SlidableAction(
//                                     onPressed: doNothing,
//                                     backgroundColor: Color(0xFF0392CF),
//                                     foregroundColor: Colors.white,
//                                     icon: Icons.save,
//                                     label: 'Save',
//                                   ),
//                                 ],
//                               ),
//                               actions: <Widget>[
//                                 IconSlideAction(
//                                   caption: 'Remove',
//                                   color: Colors.red,
//                                   icon: Ionicons.trash_outline,
//                                   onTap: () => {
//                                     _userRepo
//                                         .deleteTeamJoinRequests(
//                                             id: joinRequest[index]['id'])
//                                         .then((value) =>
//                                             ref.refresh(teamRepoProvider))
//                                   },
//                                 ),
//                               ],
//                               secondaryActions: [
//                                 if (!(joinRequest[index]['claimed'] as bool))
//                                   IconSlideAction(
//                                     caption: 'Accept',
//                                     color: kotgGreen,
//                                     icon: Ionicons.add_circle_outline,
//                                     onTap: () => {
//                                       _userRepo
//                                           .claimJoinRequest(
//                                             id: joinRequest[index]['id'],
//                                             teamId: Get.arguments['teamId'],
//                                           )
//                                           .then((value) =>
//                                               ref.refresh(teamRepoProvider))
//                                     },
//                                   ),
//                               ],
//                             );
//                           }),
//                     );
//                   }
//                   // Otherwise, show something whilst waiting for initialization to complete
//                   return Center(child: CircularProgressIndicator());
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
