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

class SelectGamePage extends StatelessWidget {
  SelectGamePage({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 15),
                child: Text(
                  'Find Team',
                  style: GoogleFonts.sarala(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: kotgGreen,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          Divider(),
          Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('My Invites'),
                  ))),
          Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Create Team'),
                  ))),
          Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Join Team'),
                  ))),
          Divider(),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              Future<void> _refreshEvents() async {
                return ref.refresh(teamFutureProvider);
              }

              final teamState = ref.watch(teamFutureProvider);
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15.sp,
                        top: 18,
                      ),
                      child: Text(
                        "Find Teams",
                        style: GoogleFonts.sarala(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 15.sp),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => _refreshEvents(),
                        child: ListView.builder(
                            // the number of items in the list
                            itemCount: data.value.length,

                            // display each item of the product list
                            itemBuilder: (context, index) {
                              return Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Text(data.value[index]
                                            ['attributes']['team_name']),
                                        trailing: OutlinedButton(
                                            style: ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                primary: kotgPurple),
                                            onPressed: () {},
                                            child: Text('Join',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                ))),
                                      )));
                            }),
                      ),
                    ),
                  ],
                );
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
                return CircularProgressIndicator();
              });
            }),
          ),
        ],
      )),
    );
  }
}
