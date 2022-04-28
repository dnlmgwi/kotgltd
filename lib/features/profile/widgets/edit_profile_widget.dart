// import 'package:ionicons/ionicons.dart';
// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/features/profile/providers/profile_providers.dart';
// import 'package:kotgltd/packages/dependencies.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:scroll_snap_list/scroll_snap_list.dart';

// class EditProfileWidget extends ConsumerWidget {
//   EditProfileWidget({Key? key}) : super(key: key);

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context, ref) {
//     var _avatarId = ref.watch(avatarProvider);

//     final _repo = ref.watch(profileRepoProvider);

//     //Get the current user

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
//                     // Form(
//                     //   key: _formKey,
//                     //   child: Column(
//                     //     children: <Widget>[
//                     //       FormField<String>(
//                     //         onSaved: (value) {
//                     //           _avatarId = value!;
//                     //         },
//                     //         builder: (FormFieldState<String> state) {
//                     //           return Container(
//                     //             height: 100,
//                     //             child: Consumer(
//                     //               builder: (context, watch, child) {
//                     //                 final _avatarProvider =
//                     //                     ref.watch(avatarsProvider);

//                     //                 return _avatarProvider.map(
//                     //                   data: (avatarResponse) {
//                     //                     ///Set Default Avatar on Load
//                     //                     // _avatarId.state = avatarResponse.value[0]['id'];
//                     //                     return ScrollSnapList(
//                     //                       onItemFocus: (int index) {
//                     //                         _avatarId = avatarResponse
//                     //                             .value[index]['id'];
//                     //                         updateValue(
//                     //                             state,
//                     //                             avatarResponse.value[index]
//                     //                                 ['id']);
//                     //                       },
//                     //                       itemSize: 50,
//                     //                       itemBuilder: (BuildContext contex,
//                     //                               int index) =>
//                     //                           ClipOval(
//                     //                         child: Image.network(
//                     //                           avatarResponse.value[index]
//                     //                               ['image']['url'],
//                     //                           width: 100,
//                     //                           height: 100,
//                     //                           fit: BoxFit.cover,
//                     //                         ),
//                     //                       ),
//                     //                       selectedItemAnchor:
//                     //                           SelectedItemAnchor.MIDDLE,
//                     //                       itemCount:
//                     //                           avatarResponse.value.length,
//                     //                       dynamicItemOpacity: 0.2,
//                     //                       focusOnItemTap: true,
//                     //                       shrinkWrap: true,
//                     //                       dynamicItemSize: true,
//                     //                       margin: EdgeInsets.all(2.5),
//                     //                       updateOnScroll: true,
//                     //                       initialIndex: 1,
//                     //                     );
//                     //                   },
//                     //                   loading: (_) => Center(
//                     //                       child: CircularProgressIndicator()),
//                     //                   error: (message) => Center(
//                     //                     child: Icon(
//                     //                       Ionicons.pulse_outline,
//                     //                       color:
//                     //                           Colors.white, //TODO Retry Button
//                     //                     ), //TODO Error Icon
//                     //                   ),
//                     //                 );
//                     //               },
//                     //             ),
//                     //           ); // Any field widget like DropDownButton,
//                     //           // Radio, Checkbox, or Slider.
//                     //         },
//                     //         validator: (value) {
//                     //           if (value == null) {
//                     //             Get.snackbar(
//                     //               "Please Select an Avatar",
//                     //               'Scroll or Touch to Select',
//                     //               snackPosition: SnackPosition.TOP,
//                     //             );
//                     //             return 'Please Select and Avatar';
//                     //           }
//                     //           return null;
//                     //         },
//                     //       ),
//                     //       SizedBox(
//                     //         height: 35,
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
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
//                               .editProfile(
//                             avatarId: _avatarId,
//                           )
//                               .then((value) {
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
//                             "Save",
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
