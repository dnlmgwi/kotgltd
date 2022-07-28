import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/bottomSheetHandle.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/events/widgets/events_page_skeleton.dart';
import 'package:kotgltd/features/tickets/widgets/ticket_widget.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
// import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventsPage extends ConsumerWidget {
  EventsPage({Key? key}) : super(key: key);

  final scrollController = ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context, ref) {
    Future<void> _refreshEvents() async {
      return ref.refresh(eventsRepoProvider);
    }

    void updateTermsAndConditions(BuildContext context, bool tc) {
      ref.read(tcEventsProvider.state).state = tc;
    }

    final _eventsRepo = ref.watch(eventsRepoProvider);

    void _showEventDetailsBottomSheet(
        {required String eventId,
        required String eventName,
        required String desciption,
        required String imageUrl,
        required String maxParticipants,
        required String price,
        required String dateTime,
        String link = 'http://www.kotg.club',
        required String prize,
        required String eventDate}) async {
      await showMaterialModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => Container(
          color: kotgBlack,
          child: Scrollbar(
            interactive: true,
            thickness: 10, //width of scrollbar
            radius: Radius.circular(20), //corner radius of scrollbar
            scrollbarOrientation: ScrollbarOrientation.left,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BottomSheetHandle(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 18,
                    ),
                    child: Row(
                      children: [
                        AutoSizeText(
                          eventName,
                          maxLines: 2,
                          style: GoogleFonts.sarala(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: kotgGreen,
                          ),
                        ),
                        Spacer(),
                        // IconButton(
                        //     onPressed: () => context.pop(),
                        //     icon: Icon(
                        //       Ionicons.close,
                        //     ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              //image size fill
                              image: imageProvider,
                              fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child:
                            CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
                      ), //show progress  while loading image
                      errorWidget: (context, url, error) =>
                          Icon(LineIcons.imageFile),
                      //show no iamge availalbe image on error laoding
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: Icon(
                            LineIcons.calendarAlt,
                          ),
                        ),
                        Text(Jiffy(eventDate).format('dd MMM yyyy'),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 20),
                          child: Icon(
                            LineIcons.clockAlt,
                          ),
                        ),
                        Text(Jiffy(dateTime).format('h:mm a'),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 20),
                          child: Icon(
                            Ionicons.people,
                          ),
                        ),
                        Text(maxParticipants,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 20),
                          child: Icon(
                            Ionicons.ticket_outline,
                          ),
                        ),
                        Text('MWK ${price}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: Icon(
                            LineIcons.trophy,
                          ),
                        ),
                        Text('MWK ${prize}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 20),
                          child: Icon(
                            LineIcons.link,
                          ),
                        ),
                        Text(link,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MarkdownBody(
                      shrinkWrap: true,
                      data: desciption,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    void _showTicketBottomSheet({required String eventId}) async {
      await showMaterialModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => Container(
          color: kotgBlack,
          child: Scrollbar(
            interactive: true,
            thickness: 10, //width of scrollbar
            radius: Radius.circular(20), //corner radius of scrollbar
            scrollbarOrientation: ScrollbarOrientation.left,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomSheetHandle(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 18, bottom: 15),
                    child: Row(
                      children: [
                        Text(
                          "My Ticket",
                          style: GoogleFonts.sarala(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Spacer(),

                        // IconButton(
                        //     onPressed: () => context.pop(),
                        //     icon: Icon(
                        //       Ionicons.close,
                        //     ))
                      ],
                    ),
                  ),
                  TicketWidget(
                    width: 350,
                    height: 500,
                    isCornerRounded: true,
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Text(eventId),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    void _showEventRegDialog({
      required String eventId,
      required String eventName,
      required String eventPrice,
    }) async {
      await showDialog(
        context: context,
        builder: (context) => Consumer(
          builder: ((context, ref, child) {
            final _tc = ref.watch(tcEventsProvider.state).state;

            return LoaderOverlay(
              overlayOpacity: 0.8,
              child: AlertDialog(
                backgroundColor: kotgBlack,
                title: Text(
                  'Event Reservation',
                  style: GoogleFonts.sarala(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: Colors.grey,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 15),
                        child: Text(
                            'By selecting confirm your spot will be reserved, until you pay the registration fee.',
                            style: GoogleFonts.sarala(
                                fontWeight: FontWeight.normal,
                                fontSize: 10.sp,
                                color: Colors.grey)),
                      ),
                      // BottomSheetHandle(),
                      CheckboxListTile(
                          activeColor: kotgBlack,
                          checkColor: kotgGreen,
                          selected: false,
                          title: Text('I Accept the terms and conditions'),
                          tileColor: kotgBlack,
                          value: _tc,
                          onChanged: (value) {
                            updateTermsAndConditions(context, value!);
                          }),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      child: Text('Confirm'),
                      onPressed: () {
                        context.loaderOverlay.show();
                        if (_tc) {
                          _eventsRepo
                              .registerEvent(
                            eventID: eventId,
                          )
                              .then((ticket) {
                            Navigator.pop(context);
                            context.loaderOverlay.hide();

                            context.push('/events/ticket/${eventId}');

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Sucessfully Reserved")));

                            ref.refresh(registeredEventsProvider(
                              int.parse(
                                eventId,
                              ),
                            ));
                          }).onError(
                            (error, stackTrace) {
                              context.push('/profile');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(error.toString()),
                                      backgroundColor: Colors.red));

                              context.loaderOverlay.hide();
                            },
                          );
                        } else {
                          context.loaderOverlay.hide();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Please Accept Terms And Conditions"),
                              backgroundColor: Colors.red));
                        }
                      }),
                  OutlinedButton(
                    child: Text('Dismiss'),
                    style: ButtonStyle(),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            );
          }),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 18, bottom: 15),
            child: Text(
              'Events',
              style: GoogleFonts.sarala(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: kotgGreen,
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _refreshEvents(),
              child: Consumer(builder: (context, ref, _) {
                final _events = ref.watch(eventsProvider);
                // final _payment = ref.read(walletProvider);

                // print(_events);
                return _events.map(
                    data: (events) {
                      if (events.value.kotgEvents.eventData.isEmpty) {
                        //print('project snapshot data is: ${projectSnap.data}');
                        return Center(
                          child: Text("We couldn't find any events"),
                        );
                      }

                      return Column(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(5.0),
                          //   child: DatePicker(
                          //     DateTime.now(),
                          //     initialSelectedDate: DateTime.now(),
                          //     selectionColor: kotgPurple,
                          //     daysCount: 14,
                          //     dateTextStyle: GoogleFonts.poppins(
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.grey,
                          //     ),
                          //     dayTextStyle: GoogleFonts.poppins(
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.grey,
                          //     ),
                          //     monthTextStyle: GoogleFonts.poppins(
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.grey,
                          //     ),
                          //     selectedTextColor: Colors.white,
                          //     onDateChange: (date) {
                          //       // // New date selected
                          //       // setState(() {
                          //       //   _selectedValue = date;
                          //       // });
                          //     },
                          //   ),
                          // ),
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    events.value.kotgEvents.eventData.length,
                                controller: scrollController,
                                physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return FadeIn(
                                    delay: Duration(milliseconds: 500),
                                    child: GestureDetector(
                                      onTap: () {
                                        _showEventDetailsBottomSheet(
                                            price: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .eventAttributes
                                                .price
                                                .toString(),
                                            prize: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .eventAttributes
                                                .prize
                                                .toString(),
                                            maxParticipants: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .eventAttributes
                                                .maxParticipants
                                                .toString(),
                                            dateTime:
                                                '${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventDate} ${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventTime}',
                                            eventDate: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .eventAttributes
                                                .eventDate,
                                            eventId: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .id,
                                            desciption: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .eventAttributes
                                                .description,
                                            eventName: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .eventAttributes
                                                .name,
                                            imageUrl: events
                                                .value.kotgEvents.eventData
                                                .elementAt(index)
                                                .eventAttributes
                                                .kotgEventImage
                                                .eventImageData
                                                .kotgEventImageAttributes
                                                .url);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 200,
                                          child: Stack(
                                            alignment: AlignmentDirectional
                                                .bottomStart,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: events
                                                    .value.kotgEvents.eventData
                                                    .elementAt(
                                                      index,
                                                    )
                                                    .eventAttributes
                                                    .kotgEventImage
                                                    .eventImageData
                                                    .kotgEventImageAttributes
                                                    .url,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      //image size fill
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
                                                ), //show progress  while loading image
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  LineIcons.imageFile,
                                                ),
                                                //show no iamge availalbe image on error laoding
                                              ),
                                              Container(
                                                height: 70,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  color: Colors.black87,
                                                  child: ListTile(
                                                      trailing: Container(child:
                                                          Consumer(builder:
                                                              (context, ref,
                                                                  _) {
                                                        final _regRepo =
                                                            ref.watch(
                                                          registeredEventsProvider(
                                                            int.parse(events
                                                                .value
                                                                .kotgEvents
                                                                .eventData
                                                                .elementAt(
                                                                    index)
                                                                .id),
                                                          ),
                                                        );

                                                        return _regRepo.map(
                                                            data: (data) {
                                                              return data.value!
                                                                      .isEmpty
                                                                  ? OutlinedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          onPrimary: Colors
                                                                              .white,
                                                                          primary:
                                                                              kotgPurple),
                                                                      onPressed:
                                                                          () {
                                                                        _showEventRegDialog(
                                                                          eventId: events
                                                                              .value
                                                                              .kotgEvents
                                                                              .eventData
                                                                              .elementAt(index)
                                                                              .id,
                                                                          eventPrice: events
                                                                              .value
                                                                              .kotgEvents
                                                                              .eventData
                                                                              .elementAt(index)
                                                                              .eventAttributes
                                                                              .price
                                                                              .toString(),
                                                                          eventName: events
                                                                              .value
                                                                              .kotgEvents
                                                                              .eventData
                                                                              .elementAt(index)
                                                                              .eventAttributes
                                                                              .name,
                                                                        );
                                                                      },
                                                                      child: Text(
                                                                          'Join',
                                                                          style: GoogleFonts
                                                                              .poppins(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          )))
                                                                  : OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        context.push(
                                                                            '/events/ticket/${events.value.kotgEvents.eventData.elementAt(index).id}');
                                                                        // _showTicketBottomSheet(
                                                                        //     eventId:
                                                                        //         events.value.kotgEvents.eventData.elementAt(index).id);
                                                                        // context
                                                                        //     .loaderOverlay
                                                                        //     .show();
                                                                        // ref
                                                                        //     .watch(
                                                                        //       deRegisterEventsProvider(
                                                                        //         int.parse(
                                                                        //           events.value.kotgEvents.eventData.elementAt(index).id,
                                                                        //         ),
                                                                        //       ),
                                                                        //     )
                                                                        //     .catchError((error) => Get.snackbar(
                                                                        //           "Deregistration Error",
                                                                        //           error.toString(),
                                                                        //           backgroundColor: Colors.red,
                                                                        //           snackPosition: SnackPosition.TOP,
                                                                        //         ))
                                                                        //     .whenComplete(() {
                                                                        //   Get.snackbar(
                                                                        //     "Successfully Deregistered",
                                                                        //     'Sad To See you leave!',
                                                                        //     snackPosition: SnackPosition.TOP,
                                                                        //   );
                                                                        //   ref.refresh(
                                                                        //     registeredEventsProvider(
                                                                        //       int.parse(events.value.kotgEvents.eventData.elementAt(index).id),
                                                                        //     ),
                                                                        //   );
                                                                        // }).whenComplete(() {
                                                                        //   context.loaderOverlay.hide();

                                                                        //   // ref.refresh(
                                                                        //   //     eventsProvider);
                                                                        // });
                                                                      },
                                                                      child: Text(
                                                                          'View Ticket',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          )));
                                                            },
                                                            loading: (loading) =>
                                                                LoadingIndicator(
                                                                  indicatorType:
                                                                      Indicator
                                                                          .ballPulseSync,
                                                                  colors: [
                                                                    kotgPurple
                                                                  ],
                                                                  strokeWidth:
                                                                      0.5,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  pathBackgroundColor:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                            // OutlinedButton(
                                                            //     onPressed:
                                                            //         () {
                                                            // _showTicketBottomSheet(
                                                            //     eventId:
                                                            //         events.value.kotgEvents.eventData.elementAt(index).id);
                                                            // context
                                                            //     .loaderOverlay
                                                            //     .show();
                                                            // ref
                                                            //     .watch(
                                                            //       deRegisterEventsProvider(
                                                            //         int.parse(
                                                            //           events.value.kotgEvents.eventData.elementAt(index).id,
                                                            //         ),
                                                            //       ),
                                                            //     )
                                                            //     .catchError((error) => Get.snackbar(
                                                            //           "Deregistration Error",
                                                            //           error.toString(),
                                                            //           backgroundColor: Colors.red,
                                                            //           snackPosition: SnackPosition.TOP,
                                                            //         ))
                                                            //     .whenComplete(() {
                                                            //   Get.snackbar(
                                                            //     "Successfully Deregistered",
                                                            //     'Sad To See you leave!',
                                                            //     snackPosition: SnackPosition.TOP,
                                                            //   );
                                                            //   ref.refresh(
                                                            //     registeredEventsProvider(
                                                            //       int.parse(events.value.kotgEvents.eventData.elementAt(index).id),
                                                            //     ),
                                                            //   );
                                                            // }).whenComplete(() {
                                                            //   context.loaderOverlay.hide();

                                                            //   // ref.refresh(
                                                            //   //     eventsProvider);
                                                            // });
                                                            // },
                                                            // child:
                                                            // ),
                                                            error: (error) => OutlinedButton(
                                                                onPressed: () =>
                                                                    ref.refresh(registeredEventsProvider(int.parse(events
                                                                        .value
                                                                        .kotgEvents
                                                                        .eventData
                                                                        .elementAt(
                                                                            index)
                                                                        .id))),
                                                                child: Icon(Ionicons
                                                                    .refresh))); //TODO Add Refresh
                                                      })),
                                                      subtitle: Wrap(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 5,
                                                            ),
                                                            child: Icon(
                                                              LineIcons
                                                                  .calendarAlt,
                                                              size: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                              Jiffy(events
                                                                      .value
                                                                      .kotgEvents
                                                                      .eventData
                                                                      .elementAt(
                                                                          index)
                                                                      .eventAttributes
                                                                      .eventDate)
                                                                  .format(
                                                                      'dd MMM yyyy'),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5,
                                                                    left: 20),
                                                            child: Icon(
                                                              LineIcons
                                                                  .clockAlt,
                                                              size: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                              Jiffy('${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventDate} ${events.value.kotgEvents.eventData.elementAt(index).eventAttributes.eventTime}')
                                                                  .format(
                                                                      'h:mm a'),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5,
                                                                    left: 20),
                                                            child: Icon(
                                                              Ionicons.people,
                                                              size: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                              events
                                                                  .value
                                                                  .kotgEvents
                                                                  .eventData
                                                                  .elementAt(
                                                                      index)
                                                                  .eventAttributes
                                                                  .maxParticipants
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ],
                                                      ),
                                                      title: Text(
                                                          events
                                                              .value
                                                              .kotgEvents
                                                              .eventData
                                                              .elementAt(index)
                                                              .eventAttributes
                                                              .name,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    },
                    error: (error) {
                      return Column(
                        children: [
                          Text('Network Error'),
                          Expanded(
                            child: ListView.builder(
                                itemCount: 5,
                                controller: scrollController,
                                physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 70,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: ListTile(
                                                title: Skeleton(
                                                    height: 12,
                                                    width: 24,
                                                    style: SkeletonStyle.text),
                                                subtitle: Skeleton(
                                                    height: 12,
                                                    width: 15,
                                                    style: SkeletonStyle.text),
                                                trailing: Skeleton(
                                                  height: 30,
                                                  width: 65,
                                                  style: SkeletonStyle.text,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    },
                    loading: (loading) => EventsPageSkeletonWidget(
                        scrollController: scrollController));
              }),
            ),
          ),
        ],
      )),
    );
  }
}
