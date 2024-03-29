import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/components.dart';
import 'package:kotgltd/features/team/providers/team_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class JoinTeamWidget extends ConsumerWidget {
  JoinTeamWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final _inviteRepo = ref.watch(inviteRepoProvider);

    final _inviteCode = ref.watch(inviteCodeProvider.state).state;

    void updateInviteCode(BuildContext context, String email) {
      ref.read(inviteCodeProvider.state).state = email;
    }

    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kotgBlack,
          leading: IconButton(
            icon: Icon(Ionicons.chevron_back, color: kotgGreen),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BottomSheetHandle(),
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 18, bottom: 5),
                  child: Text(
                    'Join Team',
                    style: GoogleFonts.sarala(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: kotgGreen,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 35, left: 35, bottom: 5),
                  child: Text(
                      'Request a join code from a friend so that you can be added to a team.',
                      style: GoogleFonts.sarala(
                          fontWeight: FontWeight.normal,
                          fontSize: 10.sp,
                          color: Colors.grey)),
                ),
                Divider(),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 35,
                    left: 35,
                  ),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(13.sp),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide:
                                        BorderSide(color: kotgGreen, width: 2)),
                                filled: true,
                                labelText: 'Enter Invite Code'.toUpperCase(),
                                labelStyle: GoogleFonts.oxygen(
                                    color: kotgGreen,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none,
                              ),
                              autofocus: true,
                              onChanged: (String inviteCode) =>
                                  updateInviteCode(context, inviteCode),

                              maxLines: 1,
                              showCursor: true,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid Join Code';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                enableFeedback: true,
                                primary: kotgBlack,
                                backgroundColor: kotgGreen,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Join",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.loaderOverlay.show();
                                  _inviteRepo
                                      .sendInvite(
                                    inviteCode: _inviteCode,
                                  )
                                      .then((value) {
                                    context.loaderOverlay.hide();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Invite Sent, Successfully"),
                                            backgroundColor: Colors.white));

                                    context.loaderOverlay.hide();
                                    ref.refresh(teamRepoProvider);
                                    context.pop();
                                  }).onError((error, stackTrace) {
                                    context.loaderOverlay.hide();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error!.toString()),
                                            backgroundColor: Colors.red));
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
