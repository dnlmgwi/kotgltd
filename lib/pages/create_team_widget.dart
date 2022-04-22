import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotgltd/features/team/providers/team_providers.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CreateTeamWidget extends ConsumerWidget {
  CreateTeamWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  // final TextEditingController controller = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();
  final TextEditingController teamNameController = TextEditingController();
  // final TextEditingController createinviteCodeController =
  //     TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final _userRepo = ref.watch(teamRepoProvider);
    final _teamName = ref.watch(teamNameProvider.state);

    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 18, bottom: 25),
            child: Text(
              'Create Team',
              style: GoogleFonts.sarala(
                fontWeight: FontWeight.w600,
                fontSize: 26.sp,
                color: kotgPurple,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35, left: 35),
            child: Text('Create Your Team and Take Part In Our Events',
                style: GoogleFonts.sarala(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                )),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35, left: 35),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: teamNameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: kotgPurple, width: 2)),
                              filled: true,
                              contentPadding: EdgeInsets.all(10.sp),
                              labelText: 'Enter Your Team Name'.toUpperCase(),
                              labelStyle: GoogleFonts.oxygen(
                                  color: kotgPurple,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                            ),
                            // autofocus: true,
                            maxLines: 1,
                            onChanged: (String teamName) =>
                                _teamName.state = teamName,
                            showCursor: true,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid Name';
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
                              backgroundColor: kotgPurple,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Create",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.loaderOverlay.show();
                                _userRepo
                                    .createTeam(
                                      teamName: teamNameController.text,
                                    )
                                    .catchError((error, stackTrace) {
                                      context.loaderOverlay.hide();
                                      Get.snackbar(
                                          "Connection Error", error!.toString(),
                                          backgroundColor: Colors.red,
                                          snackPosition: SnackPosition.BOTTOM);
                                    })
                                    .then((value) =>
                                        ref.refresh(teamRepoProvider))
                                    .whenComplete(() => Get.back());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
