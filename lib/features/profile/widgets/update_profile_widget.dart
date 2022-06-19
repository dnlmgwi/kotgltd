import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart' as pn;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

class UpdateProfileWidget extends ConsumerWidget {
  UpdateProfileWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, ref) {
    final _firstName = ref.watch(firstNameProvider.state);
    final _lastName = ref.watch(lastNameProvider.state);
    // final _avatarId = ref.watch(avatarProvider.state);
    var _phoneNumber = ref.watch(phoneNumberProvider.state);
    final _dateofBirth = ref.watch(dateOfBirthProvider.state);

    final _dateofBirthFinal =
        ref.watch(dateOfBirthFinalProvider(_dateofBirth.state).state);

    final _repo = ref.watch(profileRepoProvider);

    // void updatePhoneNumber(BuildContext context, PhoneNumber phoneNumber) {
    //   ref.read(phoneNumberProvider.state).state = phoneNumber;
    // }

    void updateFirstName(BuildContext context, String firstName) {
      ref.read(firstNameProvider.state).state = firstName.trim();
    }

    void updateLastName(BuildContext context, String lastName) {
      ref.read(lastNameProvider.state).state = lastName.trim();
    }

    void updateDateofBirth(BuildContext context, DateTime dateOfBirth) {
      ref.read(dateOfBirthProvider.state).state = dateOfBirth;
    }

    void updateValue(state, String id) {
      state.setValue(id);
    }

    void updateDetails(String firstName, String lastName) {
      updateFirstName(context, firstName);
      updateLastName(context, lastName);
    }

    final _profile = ref.watch(profileProvider);

    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kotgBlack,
          elevation: 0.0,
          title: Text(
            'Edit Profile',
            style: GoogleFonts.sarala(
              fontWeight: FontWeight.w600,
              fontSize: 26.sp,
              color: kotgGreen,
            ),
          ),
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: kotgGreen,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Consumer(builder: (context, watch, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer(builder: (context, ref, _) {
                      return _profile.map(
                          loading: (loading) => Center(
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
                              ),
                          data: (data) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  // FormField<String>(
                                  //   onSaved: (value) {
                                  //     _avatarId.state = value!;
                                  //   },
                                  //   builder: (FormFieldState<String> state) {
                                  //     return Container(
                                  //       height: 100,
                                  //       child: Consumer(
                                  //         builder: (context, watch, child) {
                                  //           final _avatarProvider =
                                  //               ref.watch(avatarsProvider);

                                  //           return _avatarProvider.map(
                                  //             data: (avatarResponse) {
                                  //               ///Set Default Avatar on Load
                                  //               // _avatarId.state = avatarResponse.value[0]['id'];
                                  //               return ScrollSnapList(
                                  //                 onItemFocus: (int index) {
                                  //                   _avatarId.state = avatarResponse
                                  //                       .value[index]['id'];
                                  //                   updateValue(
                                  //                       state,
                                  //                       avatarResponse.value[index]
                                  //                           ['id']);
                                  //                 },
                                  //                 itemSize: 50,
                                  //                 itemBuilder: (BuildContext contex,
                                  //                         int index) =>
                                  //                     ClipOval(
                                  //                   child: Image.network(
                                  //                     avatarResponse.value[index]
                                  //                         ['image']['url'],
                                  //                     width: 100,
                                  //                     height: 100,
                                  //                     fit: BoxFit.cover,
                                  //                   ),
                                  //                 ),
                                  //                 selectedItemAnchor:
                                  //                     SelectedItemAnchor.MIDDLE,
                                  //                 itemCount:
                                  //                     avatarResponse.value.length,
                                  //                 dynamicItemOpacity: 0.2,
                                  //                 focusOnItemTap: true,
                                  //                 shrinkWrap: true,
                                  //                 dynamicItemSize: true,
                                  //                 margin: EdgeInsets.all(2.5),
                                  //                 updateOnScroll: true,
                                  //                 initialIndex: 1,
                                  //               );
                                  //             },
                                  //             loading: (_) => Center(
                                  //                 child: CircularProgressIndicator()),
                                  //             error: (message) => Center(
                                  //               child: Icon(
                                  //                 Ionicons.pulse_outline,
                                  //                 color:
                                  //                     Colors.white, //TODO Retry Button
                                  //               ), //TODO Error Icon
                                  //             ),
                                  //           );
                                  //         },
                                  //       ),
                                  //     ); // Any field widget like DropDownButton,
                                  //     // Radio, Checkbox, or Slider.
                                  //   },
                                  //   validator: (value) {
                                  //     if (value == null) {
                                  //       Get.snackbar(
                                  //         "Please Select an Avatar",
                                  //         'Scroll or Touch to Select',
                                  //         snackPosition: SnackPosition.TOP,
                                  //       );
                                  //       return 'Please Select and Avatar';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),

                                  ListTile(
                                    leading: TextAvatar(
                                      shape: Shape.Circular,
                                      textColor: Colors.white,
                                      fontSize: 30,
                                      upperCase: true,
                                      numberLetters: 2,
                                      text:
                                          data.value.profileAttributes.username,
                                    ),
                                    title: Text(
                                      data.value.profileAttributes.username,
                                    ),
                                    subtitle: Text(
                                      data.value.profileAttributes.email,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Ionicons.medal_outline,
                                      size: 40,
                                    ),
                                    title: Text('Joined'),
                                    subtitle: Text(timeago.format(data
                                        .value.profileAttributes.createdAt)),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  TextFormField(
                                    initialValue:
                                        data.value.profileAttributes.firstName,
                                    enabled: data.value.profileAttributes
                                            .firstName.isEmpty
                                        ? true
                                        : false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(13.sp),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              color: kotgGreen, width: 2)),
                                      filled: true,
                                      labelText: 'First Name',
                                      labelStyle: GoogleFonts.oxygen(
                                          color: kotgGreen,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    maxLines: 1,
                                    onChanged: (String firstName) =>
                                        updateFirstName(context, firstName),
                                    showCursor: true,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter valid Firstname';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    initialValue:
                                        data.value.profileAttributes.lastName,
                                    enabled: data.value.profileAttributes
                                            .lastName.isEmpty
                                        ? true
                                        : false,
                                    keyboardType: TextInputType.emailAddress,

                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              color: kotgGreen, width: 2)),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(13.sp),
                                      labelText: 'Last Name',
                                      labelStyle: GoogleFonts.oxygen(
                                          color: kotgGreen,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // autofocus: true,
                                    maxLines: 1,
                                    onChanged: (String lastName) =>
                                        updateLastName(context, lastName),
                                    showCursor: true,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter valid Last Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  // PhoneFormField(
                                  //   autovalidateMode:
                                  //       AutovalidateMode.onUserInteraction,
                                  //   autofillHints: [
                                  //     AutofillHints.telephoneNumber
                                  //   ], // default to null
                                  //   enabled: true, // default
                                  //   decoration: InputDecoration(
                                  //     focusedBorder: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(5.0)),
                                  //         borderSide: BorderSide(
                                  //             color: kotgGreen, width: 2)),
                                  //     filled: true,
                                  //     contentPadding: EdgeInsets.all(13.sp),
                                  //     labelText: 'Phone',
                                  //     labelStyle: GoogleFonts.oxygen(
                                  //         color: kotgGreen,
                                  //         fontSize: 15.sp,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  //   onChanged: (phone) =>
                                  //       updatePhoneNumber(context, phone!),
                                  //   defaultCountry: IsoCode.MW,
                                  //   showFlagInInput: true,
                                  //   validator: PhoneValidator.validMobile(),
                                  //   enableInteractiveSelection: true,
                                  //   initialValue: phoneNumber,
                                  //   countrySelectorNavigator:
                                  //       CountrySelectorNavigator.bottomSheet(),
                                  // ),
                                  // DateTimePicker(
                                  //   initialValue: data
                                  //       .value.profileAttributes.dateOfBirth,
                                  //   enabled: data.value.profileAttributes
                                  //           .dateOfBirth.isEmpty
                                  //       ? true
                                  //       : false,
                                  //   firstDate: DateTime(1900),
                                  //   lastDate: DateTime(2100),
                                  //   dateLabelText: 'Date of Birth',
                                  //   onChanged: (val) => print(val),
                                  //   decoration: InputDecoration(
                                  //     contentPadding: EdgeInsets.all(13.sp),
                                  //     focusedBorder: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(5.0)),
                                  //         borderSide: BorderSide(
                                  //             color: kotgGreen, width: 2)),
                                  //     filled: true,
                                  //     labelText: 'Date Of Birth',
                                  //     labelStyle: GoogleFonts.oxygen(
                                  //         color: kotgGreen,
                                  //         fontSize: 15.sp,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  //   type: DateTimePickerType.date,
                                  //   initialDate: DateTime.now(),
                                  //   calendarTitle: 'Date of Birth',
                                  //   validator: (value) {
                                  //     if (value!.isEmpty) {
                                  //       return 'Please enter valid Date Of Birth';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   onSaved: (val) => print(val),
                                  // ),
                                  // SizedBox(
                                  //   height: 35,
                                  // ),
                                  ElevatedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      enableFeedback: true,
                                      primary: kotgBlack,
                                      backgroundColor: kotgGreen,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.loaderOverlay.show();

                                        if (_firstName.state != "" ||
                                            _lastName.state != "") {
                                          _repo
                                              .updateProfile(
                                            firstName: _firstName.state,
                                            lastName: _lastName.state,
                                            dateOfBirth:
                                                _dateofBirthFinal.state,
                                            phoneNumber: _phoneNumber.state,
                                          )
                                              .then((value) {
                                            context.loaderOverlay.hide();
                                            ref.refresh(profileProvider);
                                          }).onError((error, stackTrace) {
                                            Get.snackbar(
                                              "Update Error",
                                              error!.toString(),
                                              backgroundColor: Colors.red,
                                              snackPosition: SnackPosition.TOP,
                                            );
                                            context.loaderOverlay.hide();
                                          }); //TODO Show Error
                                        } else {
                                          Get.snackbar(
                                            "Update Error",
                                            r'''You Can't Make This Change''',
                                            backgroundColor: Colors.red,
                                            snackPosition: SnackPosition.TOP,
                                          );
                                          context.loaderOverlay.hide();
                                        }
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
                          },
                          error: (error) {
                            return Container(
                              child: Center(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enableFeedback: true,
                                        primary: kotgBlack,
                                        backgroundColor: kotgGreen,
                                      ),
                                      onPressed: () {
                                        ref.refresh(profileProvider);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Try Again",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ), //TODO Error Icon
                              ),
                            );
                          });
                    }),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
