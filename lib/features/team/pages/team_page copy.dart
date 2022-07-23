import 'package:badges/badges.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/components.dart';
import 'package:kotgltd/features/team/model/userEntity.dart';
import 'package:kotgltd/features/team/providers/team_providers.dart';
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
                await showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          width: double.infinity,
                          height: 60.h,
                          color: kotgBlack,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BottomSheetHandle(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 18, bottom: 5),
                                child: Text(
                                  'Team List',
                                  style: GoogleFonts.sarala(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp,
                                    color: kotgGreen,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 5, bottom: 5),
                                child: Text('Manage your invites here',
                                    style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.grey)),
                              ),
                              Divider(),
                              FutureBuilder(
                                // Initialize FlutterFire:
                                future: _userRepo.getInvites(
                                    inviteCode: inviteCode),
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
                                    var invite =
                                        snapshot.data as List<InviteEntity>;

                                    if (invite.isEmpty) {
                                      //print('project snapshot data is: ${projectSnap.data}');
                                      return Center(
                                        child: Text(
                                            "We couldn't find any requests",
                                            style: GoogleFonts.sarala(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10.sp,
                                            )),
                                      );
                                    }

                                    return Expanded(
                                      child: ListView.builder(
                                          itemCount: invite.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            void accept() {
                                              _inviteRepo
                                                  .acceptInvite(
                                                    inviteID: invite[index].id,
                                                  )
                                                  .then((value) => ref.refresh(
                                                      teamRepoProvider))
                                                  .then(
                                                      (value) => context.pop());
                                            }

                                            void decline() {
                                              _inviteRepo
                                                  .declineInvite(
                                                    inviteID: invite[index].id,
                                                  )
                                                  .then((value) => ref.refresh(
                                                      teamRepoProvider))
                                                  .then(
                                                      (value) => context.pop());
                                            }

                                            return ListTile(
                                              leading: TextAvatar(
                                                shape: Shape.Circular,
                                                size: 50,
                                                textColor: Colors.white,
                                                fontSize: 35,
                                                upperCase: true,
                                                numberLetters: 2,
                                                text: invite[index]
                                                    .inviteAttributes
                                                    .user!
                                                    .data
                                                    .userAttributes
                                                    .email,
                                              ),
                                              title: Text(invite[index]
                                                  .inviteAttributes
                                                  .user!
                                                  .data
                                                  .userAttributes
                                                  .email),
                                              subtitle: invite[index]
                                                      .inviteAttributes
                                                      .claimed!
                                                  ? Text('Member')
                                                  : Text(''),
                                              trailing: Wrap(
                                                spacing: 10.sp,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: accept,
                                                    child: Icon(
                                                        Ionicons.checkmark),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(14.sp),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: decline,
                                                    child: Icon(Ionicons.close),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.red,
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(14.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    );
                                  }
                                  // Otherwise, show something whilst waiting for initialization to complete
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ],
                          ),
                        ));
              }

              void _showOptionsBottomSheet({required int teamId}) async {
                await showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          width: double.infinity,
                          height: 60.h,
                          color: kotgBlack,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BottomSheetHandle(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 18, bottom: 5),
                                child: Text(
                                  'Options',
                                  style: GoogleFonts.sarala(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Divider(),

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
                                subtitle: Text(
                                    'Learn about your role as team captain',
                                    style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.grey)),
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
                                    'You will no longer be able to manage this team',
                                    style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.grey)),
                                onTap: () {
                                  _userRepo.deleteTeam().then((value) {
                                    ref.refresh(teamRepoProvider);
                                    context.pop();
                                  }).catchError((error, stackTrace) {
                                    const snackBar = SnackBar(
                                      content: Text(" Error"), //TODO Error
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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
                return TeamsPageOptions(error: error.value);
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
    String? error,
  }) : super(key: key);

  final String error = "";

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => context.push('/dashboard/team/create'),
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
                  onTap: () => context.push('/dashboard/team/join'),
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
