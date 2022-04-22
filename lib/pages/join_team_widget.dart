import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotgltd/features/team/providers/team_providers.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class JoinTeamWidget extends ConsumerWidget {
  JoinTeamWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final _userRepo = ref.watch(teamRepoProvider);
    final _inviteRepo = ref.watch(inviteRepoProvider);

    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 18, bottom: 25),
            child: Text(
              'Join Team',
              style: GoogleFonts.sarala(
                fontWeight: FontWeight.w600,
                fontSize: 26.sp,
                color: kotgGreen,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35, left: 35, top: 25),
            child: Text(
                'Request a join code from a friend so that you can be added to a team',
                style: GoogleFonts.sarala(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                )),
          ),
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
                        controller: inviteCodeController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: kotgGreen, width: 2)),
                          filled: true,
                          contentPadding: EdgeInsets.all(10.sp),
                          labelText: 'Enter Invite Code'.toUpperCase(),
                          labelStyle: GoogleFonts.oxygen(
                              color: kotgGreen,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                        ),
                        // autofocus: true,
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
                              "Join ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _inviteRepo
                                .sendInvite(
                              inviteCode: inviteCodeController.text,
                            )
                                .catchError((error, stackTrace) {
                              // context.loaderOverlay.hide();

                              Get.snackbar(
                                  "Connection Error", error!.toString(),
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP);
                            }).then((value) {
                              Get.snackbar("Invite Sent", "Please Wait",
                                  snackPosition: SnackPosition.TOP);
                              ref.refresh(teamRepoProvider);
                            }).whenComplete(() => Get.back());
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
    );
  }
}
