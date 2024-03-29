// import 'package:animate_do/animate_do.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/features/events/providers/events_providers.dart';
// import 'package:kotgltd/features/events/widgets/events_page_skeleton.dart';
// import 'package:kotgltd/packages/dependencies.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:skeleton_animation/skeleton_animation.dart';
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
//         required String imageUrl,
//         required String maxParticipants,
//         required String price,
//         required String dateTime,
//         String link = 'http://www.google.com',
//         required String prize,
//         required String eventDate}) async {
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
//                         onPressed: () => context.pop();,
//                         icon: Icon(
//                           Ionicons.close,
//                         ))
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
//                 padding: const EdgeInsets.all(20.0),
//                 child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         right: 5,
//                       ),
//                       child: Icon(
//                         LineIcons.calendarAlt,
//                       ),
//                     ),
//                     Text(Jiffy(eventDate).format('dd MMM yyyy'),
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 5, left: 20),
//                       child: Icon(
//                         LineIcons.clockAlt,
//                       ),
//                     ),
//                     Text(Jiffy(dateTime).format('h:mm a'),
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 5, left: 20),
//                       child: Icon(
//                         Ionicons.people,
//                       ),
//                     ),
//                     Text(maxParticipants,
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 5, left: 20),
//                       child: Icon(
//                         Ionicons.ticket_outline,
//                       ),
//                     ),
//                     Text('MWK ${price}',
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         )),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         right: 5,
//                       ),
//                       child: Icon(
//                         LineIcons.trophy,
//                       ),
//                     ),
//                     Text('MWK ${prize}',
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 5, left: 20),
//                       child: Icon(
//                         LineIcons.link,
//                       ),
//                     ),
//                     Text(link,
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         )),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: MarkdownBody(
//                   shrinkWrap: true,
//                   data: desciption,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ));
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
//                             fontSize: 25.sp,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Spacer(),
//                         Consumer(builder: (context, ref, _) {
//                           final _tc = ref.watch(tcEventsProvider.state).state;

//                           return _tc
//                               ? Container()
//                               : IconButton(
//                                   onPressed: () => context.pop();,
//                                   icon: Icon(Ionicons.close));
//                         })
//                       ],
//                     ),
//                   ),
//                   Consumer(builder: (context, ref, _) {
//                     final _tc = ref.watch(tcEventsProvider.state).state;
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
//                                         .registerEvent(
//                                       eventID: eventId,
//                                     )
//                                         .then((value) {
//                                       ref.refresh(
//                                         registeredEventsProvider(
//                                           int.parse(eventId),
//                                         ),
//                                       );
//                                       context.pop();
//                                     }).whenComplete(() {
//                                       Get.snackbar("Successfully Reserved",
//                                           'We Are Ready For You!',
//                                           snackPosition: SnackPosition.TOP);
//                                       context.loaderOverlay.hide();
//                                       Gaimon.success();
//                                       ref.refresh(registeredEventsProvider(
//                                         int.parse(
//                                           eventId,
//                                         ),
//                                       ));
//                                     }).catchError(
//                                       (error) {
//                                         Get.snackbar("Reservation Error",
//                                             error.toString(),
//                                             backgroundColor: Colors.red,
//                                             snackPosition: SnackPosition.TOP);
//                                         context.loaderOverlay.hide();
//                                         Gaimon.error();
//                                       },
//                                     );
//                                   } else {
//                                     context.loaderOverlay.hide();
//                                     Gaimon.error();
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

//                   // print(_events);
//                   return _events.map(
//                       data: (events) {
//                         if (events.value.kotgEvents.eventData.isEmpty) {
//                           //print('project snapshot data is: ${projectSnap.data}');
//                           return Center(
//                             child: Text("We couldn't find any events"),
//                           );
//                         }

//                         return Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: DatePicker(
//                                 DateTime.now(),
//                                 initialSelectedDate: DateTime.now(),
//                                 selectionColor: kotgPurple,
//                                 daysCount: 14,
//                                 selectedTextColor: Colors.white,
//                                 onDateChange: (date) {
//                                   // // New date selected
//                                   // setState(() {
//                                   //   _selectedValue = date;
//                                   // });
//                                 },
//                               ),
//                             ),
//                             Expanded(
//                               child: ListView.builder(
//                                   itemCount:
//                                       events.value.kotgEvents.eventData.length,
//                                   controller: scrollController,
//                                   physics: BouncingScrollPhysics(
//                                     parent: AlwaysScrollableScrollPhysics(),
//                                   ),
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return FadeIn(
//                                       delay: Duration(milliseconds: 500),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           _showEventDestailsBottomSheet(
//                                             price: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .eventAttributes
//                                                 .price
//                                                 .toString(),
//                                             prize: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .eventAttributes
//                                                 .prize
//                                                 .toString(),
//                                             maxParticipants: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .eventAttributes
//                                                 .maxParticipants
//                                                 .toString(),
//                                             dateTime:
//                                                 '${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventDate} ${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventTime}',
//                                             eventDate: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .eventAttributes
//                                                 .eventDate,
//                                             eventId: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .id,
//                                             desciption: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .eventAttributes
//                                                 .description,
//                                             eventName: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .eventAttributes
//                                                 .name,
//                                             imageUrl: events
//                                                 .value.kotgEvents.eventData
//                                                 .elementAt(index)
//                                                 .eventAttributes
//                                                 .kotgEventImage
//                                                 .eventImageData
//                                                 .kotgEventImageAttributes
//                                                 .url,
//                                           );
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(5.0),
//                                           child: Container(
//                                             height: 200,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Spacer(),
//                                                 Container(
//                                                   height: 70,
//                                                   child: Card(
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15.0),
//                                                     ),
//                                                     color: Colors.black87,
//                                                     child: ListTile(
//                                                         trailing: Container(
//                                                             child: Consumer(
//                                                                 builder:
//                                                                     (context,
//                                                                         ref,
//                                                                         _) {
//                                                           final _regRepo =
//                                                               ref.watch(
//                                                             registeredEventsProvider(
//                                                               int.parse(events
//                                                                   .value
//                                                                   .kotgEvents
//                                                                   .eventData
//                                                                   .elementAt(
//                                                                       index)
//                                                                   .id),
//                                                             ),
//                                                           );

//                                                           return _regRepo.map(
//                                                               data: (data) {
//                                                                 return data
//                                                                         .value!
//                                                                         .isEmpty
//                                                                     ? OutlinedButton(
//                                                                         style: ElevatedButton.styleFrom(
//                                                                             onPrimary: Colors
//                                                                                 .white,
//                                                                             primary:
//                                                                                 kotgPurple),
//                                                                         onPressed: () =>
//                                                                             _showEventRegBottomSheet(
//                                                                               eventId: events.value.kotgEvents.eventData.elementAt(index).id,
//                                                                               eventPrice: events.value.kotgEvents.eventData.elementAt(index).eventAttributes.price.toString(),
//                                                                               eventName: events.value.kotgEvents.eventData.elementAt(index).eventAttributes.name,
//                                                                             ),
//                                                                         child: Text(
//                                                                             'Join',
//                                                                             style: GoogleFonts
//                                                                                 .poppins(
//                                                                               fontWeight: FontWeight.w600,
//                                                                             )))
//                                                                     : OutlinedButton(
//                                                                         onPressed:
//                                                                             () {
//                                                                           context
//                                                                               .loaderOverlay
//                                                                               .show();
//                                                                           ref
//                                                                               .watch(
//                                                                                 deRegisterEventsProvider(
//                                                                                   int.parse(
//                                                                                     events.value.kotgEvents.eventData.elementAt(index).id,
//                                                                                   ),
//                                                                                 ),
//                                                                               )
//                                                                               .catchError((error) => Get.snackbar(
//                                                                                     "Deregistration Error",
//                                                                                     error.toString(),
//                                                                                     backgroundColor: Colors.red,
//                                                                                     snackPosition: SnackPosition.TOP,
//                                                                                   ))
//                                                                               .whenComplete(() {
//                                                                             Get.snackbar(
//                                                                               "Successfully Deregistered",
//                                                                               'Sad To See you leave!',
//                                                                               snackPosition: SnackPosition.TOP,
//                                                                             );
//                                                                             ref.refresh(
//                                                                               registeredEventsProvider(
//                                                                                 int.parse(events.value.kotgEvents.eventData.elementAt(index).id),
//                                                                               ),
//                                                                             );
//                                                                           }).whenComplete(() {
//                                                                             context.loaderOverlay.hide();

//                                                                             // ref.refresh(
//                                                                             //     eventsProvider);
//                                                                           });
//                                                                         },
//                                                                         child: Text(
//                                                                             'Deregister',
//                                                                             style:
//                                                                                 GoogleFonts.poppins(
//                                                                               fontWeight: FontWeight.w600,
//                                                                             )));
//                                                               },
//                                                               loading: (loading) =>
//                                                                   LoadingIndicator(
//                                                                     indicatorType:
//                                                                         Indicator
//                                                                             .ballPulseSync,
//                                                                     colors: [
//                                                                       kotgPurple
//                                                                     ],
//                                                                     strokeWidth:
//                                                                         0.5,
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .black,
//                                                                     pathBackgroundColor:
//                                                                         Colors
//                                                                             .black,
//                                                                   ),
//                                                               error: (error) =>
//                                                                   Text(
//                                                                       'Error')); //TODO Add Refresh
//                                                         })),
//                                                         subtitle: Wrap(
//                                                           children: [
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .only(
//                                                                 right: 5,
//                                                               ),
//                                                               child: Icon(
//                                                                 LineIcons
//                                                                     .calendarAlt,
//                                                                 size: 15,
//                                                               ),
//                                                             ),
//                                                             Text(
//                                                                 Jiffy(events
//                                                                         .value
//                                                                         .kotgEvents
//                                                                         .eventData
//                                                                         .elementAt(
//                                                                             index)
//                                                                         .eventAttributes
//                                                                         .eventDate)
//                                                                     .format(
//                                                                         'dd MMM yyyy'),
//                                                                 style:
//                                                                     GoogleFonts
//                                                                         .poppins(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 )),
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       right: 5,
//                                                                       left: 20),
//                                                               child: Icon(
//                                                                 LineIcons
//                                                                     .clockAlt,
//                                                                 size: 15,
//                                                               ),
//                                                             ),
//                                                             Text(
//                                                                 Jiffy('${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventDate} ${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventTime}')
//                                                                     .format(
//                                                                         'h:mm a'),
//                                                                 style:
//                                                                     GoogleFonts
//                                                                         .poppins(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 )),
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       right: 5,
//                                                                       left: 20),
//                                                               child: Icon(
//                                                                 Ionicons.people,
//                                                                 size: 15,
//                                                               ),
//                                                             ),
//                                                             Text(
//                                                                 events
//                                                                     .value
//                                                                     .kotgEvents
//                                                                     .eventData
//                                                                     .elementAt(
//                                                                         index)
//                                                                     .eventAttributes
//                                                                     .maxParticipants
//                                                                     .toString(),
//                                                                 style:
//                                                                     GoogleFonts
//                                                                         .poppins(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 )),
//                                                           ],
//                                                         ),
//                                                         title: Text(
//                                                             events
//                                                                 .value
//                                                                 .kotgEvents
//                                                                 .eventData
//                                                                 .elementAt(
//                                                                     index)
//                                                                 .eventAttributes
//                                                                 .name,
//                                                             style: GoogleFonts
//                                                                 .poppins(
//                                                               fontSize: 13.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ))),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(15)),
//                                                 image: DecorationImage(
//                                                     image: NetworkImage(
//                                                       events.value.kotgEvents
//                                                           .eventData
//                                                           .elementAt(index)
//                                                           .eventAttributes
//                                                           .kotgEventImage
//                                                           .eventImageData
//                                                           .kotgEventImageAttributes
//                                                           .url,
//                                                     ),
//                                                     fit: BoxFit.cover)),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                             ),
//                           ],
//                         );
//                       },
//                       error: (error) {
//                         Get.snackbar("Connection Error", error.toString(),
//                             backgroundColor: Colors.red,
//                             snackPosition: SnackPosition.TOP);

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
//                       loading: (loading) => EventsPageSkeletonWidget(
//                           scrollController: scrollController));
//                 }),
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
