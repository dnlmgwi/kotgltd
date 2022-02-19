// import 'package:date_field/date_field.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/features/auth/providers/auth_providers.dart';
// import 'package:kotgltd/features/profile/providers/profile_providers.dart';
// import 'package:kotgltd/packages/dependencies.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:phone_form_field/phone_form_field.dart';
// import 'package:scroll_snap_list/scroll_snap_list.dart';
// import 'package:intl/intl.dart';

// class CreateProfileWidget extends ConsumerWidget {
//   CreateProfileWidget({Key? key}) : super(key: key);

//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context, ref) {
//     final _firstName = ref.watch(firstNameProvider.state);
//     final _lastName = ref.watch(lastNameProvider.state);
//     final _avatarId = ref.watch(avatarProvider.state);
//     var _phoneNumber = ref.watch(phoneNumberProvider.state);
//     final _dateofBirth = ref.watch(dateOfBirthProvider.state);
//     final _authState = ref.watch(authProvider);

//     final _repo = ref.watch(profileRepoProvider);

//     void updatePhoneNumber(BuildContext context, PhoneNumber phoneNumber) {
//       ref.read(phoneNumberProvider.state).state = phoneNumber;
//     }

//     void updateFirstName(BuildContext context, String firstName) {
//       ref.read(firstNameProvider.state).state = firstName.trim();
//     }

//     void updateLastName(BuildContext context, String lastName) {
//       ref.read(lastNameProvider.state).state = lastName.trim();
//     }

//     void updateDateofBirth(BuildContext context, String dateOfBirth) {
//       ref.read(dateOfBirthProvider.state).state = dateOfBirth;
//     }

//     void updateValue(state, String id) {
//       state.setValue(id);
//     }

//     return LoaderOverlay(
//       overlayOpacity: 0.8,
//       child: Scaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.only(left: 20, right: 20, top: 50),
//               child: Consumer(builder: (context, watch, _) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: <Widget>[
//                           FormField<String>(
//                             onSaved: (value) {
//                               _avatarId.state = value!;
//                             },
//                             builder: (FormFieldState<String> state) {
//                               return Container(
//                                 height: 100,
//                                 child: Consumer(
//                                   builder: (context, watch, child) {
//                                     final _avatarProvider =
//                                         ref.watch(avatarsProvider);

//                                     return _avatarProvider.map(
//                                       data: (avatarResponse) {
//                                         ///Set Default Avatar on Load
//                                         // _avatarId.state = avatarResponse.value[0]['id'];
//                                         return ScrollSnapList(
//                                           onItemFocus: (int index) {
//                                             _avatarId.state = avatarResponse
//                                                 .value[index]['id'];
//                                             updateValue(
//                                                 state,
//                                                 avatarResponse.value[index]
//                                                     ['id']);
//                                           },
//                                           itemSize: 50,
//                                           itemBuilder: (BuildContext contex,
//                                                   int index) =>
//                                               ClipOval(
//                                             child: Image.network(
//                                               avatarResponse.value[index]
//                                                   ['image']['url'],
//                                               width: 100,
//                                               height: 100,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                           selectedItemAnchor:
//                                               SelectedItemAnchor.MIDDLE,
//                                           itemCount:
//                                               avatarResponse.value.length,
//                                           dynamicItemOpacity: 0.2,
//                                           focusOnItemTap: true,
//                                           shrinkWrap: true,
//                                           dynamicItemSize: true,
//                                           margin: EdgeInsets.all(2.5),
//                                           updateOnScroll: true,
//                                           initialIndex: 1,
//                                         );
//                                       },
//                                       loading: (_) => Center(
//                                           child: CircularProgressIndicator()),
//                                       error: (message) => Center(
//                                         child: Icon(
//                                           Ionicons.pulse_outline,
//                                           color:
//                                               Colors.white, //TODO Retry Button
//                                         ), //TODO Error Icon
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ); // Any field widget like DropDownButton,
//                               // Radio, Checkbox, or Slider.
//                             },
//                             validator: (value) {
//                               if (value == null) {
//                                 Get.snackbar(
//                                   "Please Select an Avatar",
//                                   'Scroll or Touch to Select',
//                                   snackPosition: SnackPosition.TOP,
//                                 );
//                                 return 'Please Select and Avatar';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 35,
//                           ),
//                           TextFormField(
//                             initialValue: _firstName.state,
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5.0)),
//                                   borderSide:
//                                       BorderSide(color: kotgGreen, width: 2)),
//                               filled: true,
//                               contentPadding: EdgeInsets.only(
//                                   bottom: 10.0, left: 10.0, right: 10.0),
//                               labelText: 'First Name',
//                               labelStyle: GoogleFonts.oxygen(
//                                   color: kotgGreen,
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.bold),
//                             ),

//                             maxLines: 1,
//                             onChanged: (String firstName) =>
//                                 updateFirstName(context, firstName),
//                             showCursor: true,
//                             // The validator receives the text that the user has entered.
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter valid Firstname';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           TextFormField(
//                             initialValue: _lastName.state,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5.0)),
//                                   borderSide:
//                                       BorderSide(color: kotgGreen, width: 2)),
//                               filled: true,
//                               contentPadding: EdgeInsets.all(13),
//                               labelText: 'Last Name',
//                               labelStyle: GoogleFonts.oxygen(
//                                   color: kotgGreen,
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             // autofocus: true,
//                             maxLines: 1,
//                             onChanged: (String lastName) =>
//                                 updateLastName(context, lastName),
//                             showCursor: true,
//                             // The validator receives the text that the user has entered.
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter valid Last Name';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           PhoneFormField(
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             autofillHints: [
//                               AutofillHints.telephoneNumber
//                             ], // default to null
//                             enabled: true, // default
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5.0)),
//                                   borderSide:
//                                       BorderSide(color: kotgGreen, width: 2)),
//                               filled: true,
//                               contentPadding: EdgeInsets.all(13),
//                               labelText: 'Phone',
//                               labelStyle: GoogleFonts.oxygen(
//                                   color: kotgGreen,
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             onChanged: (phone) =>
//                                 updatePhoneNumber(context, phone!),
//                             defaultCountry: 'MW',
//                             showFlagInInput: true,
//                             validator: PhoneValidator.validMobile(),
//                             selectorNavigator:
//                                 const BottomSheetNavigator(), // default to bottom sheet but you can customize how the selector is shown by extending CountrySelectorNavigator
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           DateTimeFormField(
//                             initialDatePickerMode: DatePickerMode.year,
//                             initialEntryMode: DatePickerEntryMode.inputOnly,
//                             decoration: const InputDecoration(
//                               hintStyle: TextStyle(color: Color(0xFFA9F211)),
//                               errorStyle: TextStyle(color: Colors.redAccent),
//                               focusColor: Color(0xFFA9F211),
//                               suffixIcon: Icon(
//                                 Ionicons.calendar_outline,
//                                 color: Color(0xFFA9F211),
//                               ),
//                               disabledBorder: InputBorder.none,
//                               labelText: 'Date of Birth',
//                               filled: true,
//                               contentPadding: EdgeInsets.only(
//                                   bottom: 10.0, left: 10.0, right: 10.0),
//                             ),
//                             mode: DateTimeFieldPickerMode.date,
//                             dateFormat: DateFormat('yyyy-MM-dd'),
//                             autovalidateMode: AutovalidateMode.always,
//                             validator: (e) => (e?.day ?? 0) == 1
//                                 ? 'Please not the first day'
//                                 : null,
//                             onDateSelected: (DateTime value) {
//                               updateDateofBirth(context, value.toString());
//                             },
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     ElevatedButton(
//                       style: OutlinedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         enableFeedback: true,
//                         primary: kotgBlack,
//                         backgroundColor: kotgGreen,
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           context.loaderOverlay.show();
//                           _repo
//                               .createProfile(
//                             firstName: _firstName.state,
//                             lastName: _lastName.state,
//                             dateOfBirth: DateTime.parse(_dateofBirth.state),
//                             avatarId: _avatarId.state,
//                             phoneNumber: _phoneNumber.state,
//                           )
//                               .then((value) {
//                             _authState.isAuth();
//                             context.loaderOverlay.hide();
//                           }).onError((error, stackTrace) {
//                             context.loaderOverlay.hide();
//                           }); //TODO Show Error

//                         }
//                       },
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Text(
//                             "Begin",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
