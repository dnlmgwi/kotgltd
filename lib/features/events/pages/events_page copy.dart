// import 'package:animate_do/animate_do.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/features/events/providers/events_providers.dart';
// import 'package:kotgltd/packages/dependencies.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:skeleton_animation/skeleton_animation.dart';
// import 'package:flutter/material.dart';
// // import 'package:external_app_launcher/external_app_launcher.dart';

// class EventsPage extends ConsumerWidget {
//   EventsPage({Key? key}) : super(key: key);

//   final scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context, ref) {
//     Future<void> _refreshEvents(BuildContext context) async {
//       return ref.refresh(eventsRepoProvider);
//     }

//     void updateTermsAndConditions(BuildContext context, bool tc) {
//       ref.read(tcEventsProvider.state).state = tc;
//     }

//     final _eventsRepo = ref.watch(eventsRepoProvider);

//     void _showEventDestailsBottomSheet(
//         {required String eventId,
//         required String eventName,
//         required String desciption,
//         required String imageUrl}) async {
//       await Get.bottomSheet(Container(
//         color: kotgBlack,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 15,
//                   top: 18,
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       eventName,
//                       style: GoogleFonts.sarala(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 26.sp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Spacer(),
//                     IconButton(
//                         onPressed: () => Get.back(), icon: Icon(Ionicons.close))
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(10),
//                 height: 200,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                     image: DecorationImage(
//                         image: NetworkImage(imageUrl), fit: BoxFit.cover)),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: MarkdownBody(
//                   shrinkWrap: true,
//                   data: desciption,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ));

//       // The code below will run after the bottom sheet goes away
//       print('The Bottom Sheet has gone away!');
//     }

//     void _showEventRegBottomSheet({
//       required String eventId,
//       required String eventName,
//       required String eventPrice,
//     }) async {
//       await Get.bottomSheet(
//         LoaderOverlay(
//           overlayOpacity: 1.0,
//           child: Container(
//             color: kotgBlack,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 15,
//                       top: 18,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Event Reservation',
//                           style: GoogleFonts.sarala(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 26.sp,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Spacer(),
//                         Consumer(builder: (context, ref, _) {
//                           final _tc = ref.watch(tcEventsProvider.state).state;

//                           return _tc
//                               ? Container()
//                               : IconButton(
//                                   onPressed: () => Get.back(),
//                                   icon: Icon(Ionicons.close));
//                         })
//                       ],
//                     ),
//                   ),
//                   Consumer(builder: (context, ref, _) {
//                     final _tc = ref.watch(tcEventsProvider.state).state;
//                     final eventRef = ref.watch(eventReferenceProvider(eventId));
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         CheckboxListTile(
//                             activeColor: kotgBlack,
//                             checkColor: kotgGreen,
//                             selected: false,
//                             title: Text('I Accept the terms and conditions'),
//                             tileColor: kotgBlack,
//                             value: _tc,
//                             onChanged: (value) {
//                               updateTermsAndConditions(context, value!);
//                             }),
//                         Padding(
//                             padding: EdgeInsets.only(top: 10.sp, bottom: 35.sp),
//                             child: ElevatedButton(
//                                 child: Text('Confirm'),
//                                 onPressed: () {
//                                   context.loaderOverlay.show();
//                                   if (_tc) {
//                                     _eventsRepo
//                                         .joinEvent(
//                                       eventID: eventId,
//                                       reference: eventRef.value!,
//                                     )
//                                         .whenComplete(() {
//                                       ref.refresh(
//                                         registeredEventsProvider(
//                                           int.parse(eventId),
//                                         ),
//                                       );
//                                       Get.back();
//                                     }).whenComplete(() {
//                                       Get.snackbar("Successfully Reserved",
//                                           'We Are Ready For You!',
//                                           snackPosition: SnackPosition.TOP);
//                                       context.loaderOverlay.hide();
//                                     }).catchError(
//                                       (error) {
//                                         Get.snackbar("Reservation Error",
//                                             error.toString(),
//                                             backgroundColor: Colors.red,
//                                             snackPosition: SnackPosition.TOP);
//                                         context.loaderOverlay.hide();
//                                       },
//                                     );
//                                   } else {
//                                     context.loaderOverlay.hide();
//                                     Get.snackbar(
//                                         "Please Accept Terms And Conditions",
//                                         "You need to agree to our terms to proceed",
//                                         backgroundColor: Colors.red,
//                                         snackPosition: SnackPosition.TOP);
//                                   }
//                                 })),
//                       ],
//                     );
//                   })
//                 ],
//               ),
//             ),
//           ),
//         ),
//         isDismissible: false,
//       );

//       // The code below will run after the bottom sheet goes away
//       print('The Bottom Sheet has gone away!');
//     }

//     return LoaderOverlay(
//       overlayOpacity: 0.8,
//       child: SafeArea(
//         child: Scaffold(
//             body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15, top: 18, bottom: 15),
//               child: Text(
//                 'Events',
//                 style: GoogleFonts.sarala(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 26.sp,
//                   color: kotgGreen,
//                 ),
//               ),
//             ),
//             Divider(),
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: () => _refreshEvents(context),
//                 child: Consumer(builder: (context, ref, _) {
//                   final _events = ref.watch(eventsProvider);
//                   // final _payment = ref.read(walletProvider);

//                   print(_events);
//                   return _events.map(
//                       data: (events) {
//                         if (events.value.isEmpty) {
//                           //print('project snapshot data is: ${projectSnap.data}');
//                           return Center(
//                             child: Text("We couldn't find any events"),
//                           );
//                         }

//                         return ListView.builder(
//                             itemCount: events.value.length,
//                             controller: scrollController,
//                             physics: BouncingScrollPhysics(
//                               parent: AlwaysScrollableScrollPhysics(),
//                             ),
//                             itemBuilder: (BuildContext context, int index) {
//                               return FadeIn(
//                                 delay: Duration(milliseconds: 500),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     _showEventDestailsBottomSheet(
//                                       eventId: events.value[index].id,
//                                       desciption: events
//                                           .value[index].attributes.description!,
//                                       eventName:
//                                           events.value[index].attributes.name!,
//                                       imageUrl: events.value[index]
//                                               ['attributes']['image']['data']
//                                           ['attributes']['url'],
//                                     );
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Container(
//                                       height: 200,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Container(
//                                                   height: 40,
//                                                   child: Card(
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15.0),
//                                                     ),
//                                                     color: Colors.black87,
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                           Ionicons
//                                                               .trophy_outline,
//                                                           size: 25,
//                                                           color: kotgGold,
//                                                         ),
//                                                         Expanded(
//                                                           flex: 2,
//                                                           child: Text('MWK' +
//                                                               events
//                                                                   .value[index][
//                                                                       'attributes']
//                                                                       ['prize']
//                                                                   .toString()),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 3,
//                                                 child: Container(
//                                                   height: 40,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           Container(
//                                             height: 70,
//                                             child: Card(
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15.0),
//                                               ),
//                                               color: Colors.black87,
//                                               child: ListTile(
//                                                   trailing: Container(child:
//                                                       Consumer(builder:
//                                                           (context, ref, _) {
//                                                     final _regRepo = ref.watch(
//                                                       registeredEventsProvider(
//                                                         int.parse(events
//                                                             .value[index]['id']),
//                                                       ),
//                                                     );

//                                                     return _regRepo.map(
//                                                         data: (data) {
//                                                           return data.value!
//                                                                   .isEmpty
//                                                               ? OutlinedButton(
//                                                                   style: ElevatedButton.styleFrom(
//                                                                       onPrimary:
//                                                                           Colors
//                                                                               .white,
//                                                                       primary:
//                                                                           kotgPurple),
//                                                                   onPressed: () =>
//                                                                       _showEventRegBottomSheet(
//                                                                         eventId:
//                                                                             events.value[index]['id'],
//                                                                         eventPrice: events
//                                                                             .value[index]['attributes']['price']
//                                                                             .toString(),
//                                                                         eventName:
//                                                                             events.value[index]['attributes']['name'],
//                                                                       ),
//                                                                   child: Text(
//                                                                       'Join',
//                                                                       style: GoogleFonts
//                                                                           .poppins(
//                                                                         fontWeight:
//                                                                             FontWeight.w600,
//                                                                       )))
//                                                               : OutlinedButton(
//                                                                   onPressed:
//                                                                       () {
//                                                                     context
//                                                                         .loaderOverlay
//                                                                         .show();
//                                                                     ref
//                                                                         .watch(deRegisterEventsProvider(int.parse(data.value![0][
//                                                                             'id'])))
//                                                                         .catchError((error) =>
//                                                                             Get
//                                                                                 .snackbar(
//                                                                               "Deregistration Error",
//                                                                               error.toString(),
//                                                                               backgroundColor: Colors.red,
//                                                                               snackPosition: SnackPosition.TOP,
//                                                                             ))
//                                                                         .then((value) => ref.refresh(registeredEventsProvider(int.parse(events.value[index]
//                                                                             [
//                                                                             'id']))))
//                                                                         .whenComplete(() =>
//                                                                             Get.snackbar(
//                                                                               "Successfully Deregistered",
//                                                                               'Sad To See you leave!',
//                                                                               snackPosition: SnackPosition.TOP,
//                                                                             ))
//                                                                         .whenComplete(() {
//                                                                       context
//                                                                           .loaderOverlay
//                                                                           .hide();
//                                                                       // ref.refresh(
//                                                                       //     balanceProvider);
//                                                                     });
//                                                                   },
//                                                                   child: Text(
//                                                                       'Deregister',
//                                                                       style: GoogleFonts
//                                                                           .poppins(
//                                                                         fontWeight:
//                                                                             FontWeight.w600,
//                                                                       )));
//                                                         },
//                                                         loading: (loading) =>
//                                                             LoadingIndicator(
//                                                               indicatorType:
//                                                                   Indicator
//                                                                       .ballPulseSync,
//                                                               colors: [
//                                                                 kotgPurple
//                                                               ],
//                                                               strokeWidth: 0.5,
//                                                               backgroundColor:
//                                                                   Colors.black,
//                                                               pathBackgroundColor:
//                                                                   Colors.black,
//                                                             ),
//                                                         error: (error) =>
//                                                             Text('Error'));
//                                                   })),
//                                                   // subtitle: Row(
//                                                   //   children: [
//                                                   //     Icon(
//                                                   //       Ionicons.ticket_outline,
//                                                   //       size: 10.sp,
//                                                   //     ),
//                                                   //     Padding(
//                                                   //       padding:
//                                                   //           const EdgeInsets
//                                                   //               .all(8.0),
//                                                   //       child: Text('MWK ' +
//                                                   //           events.value[index][
//                                                   //                   'attributes']
//                                                   //                   ['price']
//                                                   //               .toString()),
//                                                   //     ),
//                                                   //   ],
//                                                   // ),
//                                                   leading: Column(
//                                                     children: [
//                                                       Text(
//                                                           Jiffy(events.value[
//                                                                           index]
//                                                                       [
//                                                                       'attributes']
//                                                                   [
//                                                                   'event_date'])
//                                                               .format('MMM'),
//                                                           style: GoogleFonts
//                                                               .poppins(
//                                                             fontSize: 12,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           )),
//                                                       Text(
//                                                           Jiffy(events.value[
//                                                                           index]
//                                                                       [
//                                                                       'attributes']
//                                                                   [
//                                                                   'event_date'])
//                                                               .format('do'),
//                                                           style: GoogleFonts
//                                                               .poppins(
//                                                             fontSize: 12,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           )),
//                                                     ],
//                                                   ),
//                                                   title: Text(
//                                                       events.value[index]
//                                                               ['attributes']
//                                                           ['name'],
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                         fontSize: 13.sp,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ))),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                           image: DecorationImage(
//                                               image: NetworkImage(
//                                                   events.value[index]
//                                                               ['attributes']
//                                                           ['image']['data']
//                                                       ['attributes']['url']),
//                                               fit: BoxFit.cover)),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       error: (error) {
//                         // Get.snackbar("Connection Error", error.toString(),
//                         //     backgroundColor: Colors.red,
//                         //     snackPosition: SnackPosition.BOTTOM);

//                         return ListView.builder(
//                             itemCount: 5,
//                             controller: scrollController,
//                             physics: BouncingScrollPhysics(
//                               parent: AlwaysScrollableScrollPhysics(),
//                             ),
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Container(
//                                   height: 200,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Container(
//                                         height: 70,
//                                         child: Card(
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15.0),
//                                           ),
//                                           child: ListTile(
//                                             title: Skeleton(
//                                                 height: 12,
//                                                 width: 24,
//                                                 style: SkeletonStyle.text),
//                                             subtitle: Skeleton(
//                                                 height: 12,
//                                                 width: 15,
//                                                 style: SkeletonStyle.text),
//                                             trailing: Skeleton(
//                                               height: 30,
//                                               width: 65,
//                                               style: SkeletonStyle.text,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[800],
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(15)),
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       loading: (loading) => ListView.builder(
//                           itemCount: 5,
//                           controller: scrollController,
//                           physics: BouncingScrollPhysics(
//                             parent: AlwaysScrollableScrollPhysics(),
//                           ),
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Container(
//                                 height: 200,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Container(
//                                       height: 70,
//                                       child: Card(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                         ),
//                                         child: ListTile(
//                                           title: Skeleton(
//                                               height: 12,
//                                               width: 24,
//                                               style: SkeletonStyle.text),
//                                           subtitle: Skeleton(
//                                               height: 12,
//                                               width: 15,
//                                               style: SkeletonStyle.text),
//                                           trailing: Skeleton(
//                                             height: 30,
//                                             width: 65,
//                                             style: SkeletonStyle.text,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[800],
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(15)),
//                                 ),
//                               ),
//                             );
//                           }));
//                 }),
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
