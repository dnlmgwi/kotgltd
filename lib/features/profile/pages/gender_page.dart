import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class GenderPage extends ConsumerWidget {
  GenderPage({
    Key? key,
    required this.gender,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final String gender;

  @override
  Widget build(BuildContext context, ref) {
    final _repo = ref.watch(profileRepoProvider);
    final _gender = ref.watch(genderProvider.state).state;

    void updateGender(String gender) {
      ref.read(genderProvider.state).state = gender;
    }

    void updateDetails(
      String gender,
    ) {
      if (gender.isEmpty) gender = _gender;

      if (gender.isNotEmpty) updateGender(gender);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kotgBlack,
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back, color: kotgGreen),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.pop();
            }
          },
        ),
        title: Text(
          'Gender',
          style: GoogleFonts.sarala(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: kotgGreen,
          ),
        ),
      ),
      body: LoaderOverlay(
        overlayOpacity: 0.8,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Consumer(builder: (context, watch, _) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              'Gender',
                              style: GoogleFonts.oxygen(
                                  color: kotgGreen,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton(
                                isExpanded: true,
                                hint: Text('Select your gender'),
                                alignment: Alignment.center,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),

                                // isExpanded: true,
                                enableFeedback: true,
                                value: _gender,
                                items: Gender.values
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.name,
                                    child: Text(
                                      value.name.replaceAll('_', ' '),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  updateGender(value.toString());
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
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
                        onPressed: () {
                          updateDetails(gender);
                          if (_formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            _repo
                                .updateGender(
                              gender: _gender,
                            )
                                .then((value) {
                              context.loaderOverlay.hide();
                              ref.refresh(profileProvider);
                              context.pop();
                            }).catchError((error, stackTrace) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        error.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )));

                              context.loaderOverlay.hide();
                            });
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
