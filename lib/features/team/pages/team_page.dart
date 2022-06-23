import 'package:badges/badges.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/team/providers/team_providers.dart';
import 'package:kotgltd/features/team/widgets/create_team_widget.dart';
import 'package:kotgltd/features/team/widgets/join_team_widget.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class TeamsPage extends ConsumerWidget {
  TeamsPage({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 18, bottom: 15),
            child: Text(
              'Team',
              style: GoogleFonts.sarala(
                fontWeight: FontWeight.w600,
                fontSize: 26.sp,
                color: kotgGreen,
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              final teamState = ref.watch(teamStateFutureProvider);
              final _userRepo = ref.watch(teamRepoProvider);
              final _inviteRepo = ref.watch(inviteRepoProvider);

              void _showManageTeamBottomSheet(
                  {required String inviteCode, required int teamId}) async {
                await Get.bottomSheet(Container(
                  width: double.infinity,
                  height: 60.h,
                  color: kotgBlack,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 18, bottom: 5),
                        child: Text(
                          'Join Requests',
                          style: GoogleFonts.sarala(
                            fontWeight: FontWeight.w600,
                            fontSize: 26.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 35, left: 35, bottom: 5),
                        child: Text(
                            'Swipe Right to add a gamer or swipe left to remove a gamer',
                            style: GoogleFonts.sarala(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            )),
                      ),
                      Divider(),
                      Expanded(
                        child: FutureBuilder(
                          // Initialize FlutterFire:
                          future:
                              _userRepo.getJoinRequests(inviteCode: inviteCode),
                          builder: (context, snapshot) {
                            // Check for errors
                            if (snapshot.hasError) {
                              return Center(
                                child: Icon(
                                  Ionicons.pulse_outline,
                                  color: Colors.white,
                                ), //TODO Error Icon
                              );
                            }
                            // Once complete, show your application
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              var invite = snapshot.data as List;

                              if (invite.isEmpty) {
                                //print('project snapshot data is: ${projectSnap.data}');
                                return Center(
                                  child: Text("We couldn't find any requests",
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp,
                                      )),
                                );
                              }

                              return Expanded(
                                child: ListView.builder(
                                    itemCount: invite.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      void accept(BuildContext context) {
                                        _inviteRepo
                                            .acceptInvite(
                                              inviteID: invite[index]['id'],
                                            )
                                            .then((value) =>
                                                ref.refresh(teamRepoProvider))
                                            .then((value) => Get.back());
                                      }

                                      void decline(BuildContext context) {
                                        _inviteRepo
                                            .declineInvite(
                                              inviteID: invite[index]['id'],
                                            )
                                            .then((value) =>
                                                ref.refresh(teamRepoProvider))
                                            .then((value) => Get.back());
                                      }

                                      return Slidable(
                                        startActionPane: ActionPane(
                                          // A motion is a widget used to control how the pane animates.
                                          motion: const ScrollMotion(),

                                          // A pane can dismiss the Slidable.
                                          // dismissible: DismissiblePane(
                                          //     onDismissed: () {}),

                                          // All actions are defined in the children parameter.
                                          children: [
                                            // A SlidableAction can have an icon and/or a label.
                                            SlidableAction(
                                              onPressed: decline,
                                              backgroundColor:
                                                  Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Decline',
                                            ),
                                          ],
                                        ),

                                        // The end action pane is the one at the right or the bottom side.
                                        endActionPane: ActionPane(
                                          motion: ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: accept,
                                              backgroundColor:
                                                  Color(0xFF0392CF),
                                              foregroundColor: Colors.white,
                                              icon: Ionicons.add_circle_outline,
                                              label: 'Accept',
                                            ),
                                          ],
                                        ),

                                        child: ListTile(
                                          leading: TextAvatar(
                                            shape: Shape.Circular,
                                            size: 50,
                                            textColor: Colors.white,
                                            fontSize: 35,
                                            upperCase: true,
                                            numberLetters: 2,
                                            text: invite[index]['attributes']
                                                    ['user']['data']
                                                ['attributes']['email'],
                                          ),
                                          title: Text(invite[index]
                                                  ['attributes']['user']['data']
                                              ['attributes']['email']),
                                          trailing: (invite[index]['attributes']
                                                  ['claimed'] as bool)
                                              ? Text('Member')
                                              : Text(''),
                                        ),
                                      );
                                    }),
                              );
                            }
                            // Otherwise, show something whilst waiting for initialization to complete
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                ));

                print('The Bottom Sheet has gone away!');
              }

              void _showOptionsBottomSheet({required int teamId}) async {
                await Get.bottomSheet(Container(
                  width: double.infinity,
                  height: 60.h,
                  color: kotgBlack,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 18, bottom: 25),
                        child: Text(
                          'Options',
                          style: GoogleFonts.sarala(
                            fontWeight: FontWeight.w600,
                            fontSize: 26.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   leading: Icon(Ionicons.share_social_outline),
                      //   title: Text('Send Invite Code'),
                      //   subtitle: Text(
                      //       'Send Invite Code to your friends so that you can take part together'),
                      //   onTap: () {
                      //     Share.share(inviteCode);
                      //   },
                      // ),
                      ListTile(
                        leading: Icon(
                          Ionicons.information_circle_outline,
                        ),
                        title: Text(
                          'Team Captain Rules',
                        ),
                        subtitle: Text('knowledge is power'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(
                          Ionicons.exit_outline,
                          color: Colors.red,
                        ),
                        title: Text(
                          'Delete Team',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        subtitle: Text(
                            'You will no longer be able to manage this team'),
                        onTap: () {
                          _userRepo.deleteTeam().then((value) {
                            ref.refresh(teamRepoProvider);
                            Get.back();
                          }).catchError((error, stackTrace) {
                            Get.snackbar("Connection Error", error!.toString(),
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.TOP);
                          });
                        },
                      ),
                    ],
                  ),
                ));

                // The code below will run after the bottom sheet goes away
                print('The Bottom Sheet has gone away!');
              }

              return teamState.map(data: (data) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 35, top: 30, bottom: 25),
                          child: ListTile(
                            title: Text(
                              data.value.teamName,
                              style: TextStyle(fontSize: 25.sp),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  _showOptionsBottomSheet(teamId: 0);
                                },
                                icon: Icon(
                                  Ionicons.ellipsis_vertical_outline,
                                )),

                            // Get.toNamed('/joinRequests',
                            //     arguments: {
                            //       'inviteCode': team[0]['invite_code'],
                            //       'teamId': team[0]['id']
                            //     })
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            leading: Icon(Ionicons.share_outline),
                            title: Text('Send Invite Code'),
                            onTap: () => Share.share(data.value.inviteCode),
                          ),
                          ListTile(
                            leading: Icon(Ionicons.person_add_outline),
                            title: Text('Invites'),
                            trailing: FutureBuilder(
                                future: _userRepo.getInviteCount(
                                    inviteCode: data.value.inviteCode),
                                builder: (context, snapshot) {
                                  // Check for errors
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Icon(
                                        Ionicons.pulse_outline,
                                        color: Colors.white,
                                      ), //TODO Error Icon
                                    );
                                  }
                                  // Once complete, show your application
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    var count = snapshot.data as num;

                                    if (count == 0) {
                                      return Text('');
                                    }

                                    return Badge(
                                      position:
                                          BadgePosition.topEnd(top: 0, end: 3),
                                      animationDuration:
                                          Duration(milliseconds: 300),
                                      animationType: BadgeAnimationType.slide,
                                      badgeContent: Text(
                                        count.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
                                  // Otherwise, show something whilst waiting for initialization to complete
                                  return Badge(
                                    position:
                                        BadgePosition.topEnd(top: 0, end: 3),
                                    animationDuration:
                                        Duration(milliseconds: 300),
                                    animationType: BadgeAnimationType.slide,
                                    badgeContent: Text(
                                      '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                            onTap: () => _showManageTeamBottomSheet(
                              inviteCode: data.value.inviteCode,
                              teamId: data.value.id,
                            ),
                          ),
                          // ListTile(
                          //   leading: Icon(Ionicons.notifications_outline),
                          //   trailing: Text('Coming Soon'),
                          //   enabled: false,
                          //   title: Text('Notifications'),
                          //   // trailing: Badge(
                          //   //   position: BadgePosition.topEnd(top: 0, end: 3),
                          //   //   animationDuration: Duration(milliseconds: 300),
                          //   //   animationType: BadgeAnimationType.slide,
                          //   //   badgeContent: Text(
                          //   //     '2',
                          //   //     style: TextStyle(color: Colors.white),
                          //   //   ),
                          //   // ),
                          //   onTap: () {},
                          // ),
                          ListTile(
                            leading: Icon(Ionicons.stats_chart_outline),
                            title: Text('Team Stats'),
                            trailing: Text('Coming Soon'),
                            enabled: false,
                            onTap: () {},
                          ),
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 18, bottom: 15),
                        child: Text(
                          'Team Members',
                          style: GoogleFonts.sarala(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: data.value.teamMembers!.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 18, bottom: 15),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Looking abit too empty here...player?',
                                        style: GoogleFonts.sarala(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Container(
                                        width: 50.w,
                                        child: ElevatedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enableFeedback: true,
                                            primary: kotgBlack,
                                            backgroundColor: kotgGreen,
                                          ),
                                          icon: Icon(Ionicons.share_outline),
                                          label: Text(
                                            'Send Invite Code',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            Share.share(data.value.inviteCode);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            : ListView.builder(
                                itemCount: data.value.teamMembers!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    // leading: ClipOval(
                                    //   child: Container(),
                                    //   // child: Image.network(
                                    //   //   team["",""][index]['member']
                                    //   //           ['profile']['avatar']['image']
                                    //   //       ['url'],
                                    //   //   width: 40,
                                    //   //   height: 40,
                                    //   //   fit: BoxFit.cover,
                                    //   // ),
                                    // ),
                                    leading: TextAvatar(
                                      shape: Shape.Circular,
                                      size: 50,
                                      textColor: Colors.white,
                                      fontSize: 35,
                                      upperCase: true,
                                      numberLetters: 2,
                                      text: data.value.teamMembers![index]
                                          ['user']['username'],
                                    ),
                                    title: Text(
                                      data.value.teamMembers![index]['user']
                                          ['username'],
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data.value.teamMembers![index]['user']
                                          ['email'],
                                      style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ]);
              }, loading: (loading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Please wait...',
                        style: GoogleFonts.sarala(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }, error: (error) {
                print(error);
                return TeamsPageOptions();
              });
            }),
          ),
        ],
      )),
    );
  }
}

class TeamsPageOptions extends StatelessWidget {
  const TeamsPageOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showBottomSheetCreateTeam() async {
      await Get.bottomSheet(
        Container(
          width: double.infinity,
          height: 60.h,
          color: kotgBlack,
          child: CreateTeamWidget(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      );

      // The code below will run after the bottom sheet goes away
      print('The Bottom Sheet has gone away!');
    }

    void _showBottomSheetJoinTeam() async {
      await Get.bottomSheet(
        Container(
          width: double.infinity,
          height: 60.h,
          color: kotgBlack,
          child: JoinTeamWidget(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );

      // The code below will run after the bottom sheet goes away
      print('The Bottom Sheet has gone away!');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [kotgPurpleLight, kotgPurpleDark]),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Opacity(
                    opacity: 0.2,
                    child: Lottie.asset('assets/images/teams_icon.json',
                        fit: BoxFit.cover, height: 80),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showBottomSheetCreateTeam(),
                  child: ListTile(
                      // trailing: Container(
                      //     child: Icon(
                      //         Ionicons.people_outline)),
                      subtitle: Text(
                          'Games are better together. Form a team with other players by inviting them '),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                        ),
                        child: Text(
                          'Create Team',
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [kotgGreenLight, kotgGreenDark]),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Opacity(
                    opacity: 0.2,
                    child: Lottie.asset('assets/images/join_team_icon.json',
                        fit: BoxFit.cover, height: 80),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showBottomSheetJoinTeam(),
                  child: ListTile(
                      // trailing: Container(
                      //     child: Icon(
                      //   Ionicons.person_add_outline,
                      //   color: kotgBlack,
                      // )),
                      subtitle: Text(
                          "Join your friend's team by entering an invite code",
                          style: TextStyle(
                            color: kotgBlack,
                          )),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                        ),
                        child: Text(
                          'Join Team',
                          style: TextStyle(
                            color: kotgBlack,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
