import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/components.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/home/page_provider.dart';
import 'package:kotgltd/features/tickets/widgets/ticket_page_skeleton.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_material/ticket_material.dart';
// import 'package:external_app_launcher/external_app_launcher.dart';

class TicketsPage extends ConsumerWidget {
  TicketsPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    Future<void> _refreshTickets(BuildContext context) async {
      return ref.refresh(eventsRepoProvider);
    }

    // void _showEventDestailsBottomSheet(
    //     {required String eventId,
    //     required String eventName,
    //     required String desciption,
    //     required String imageUrl,
    //     required String maxParticipants,
    //     required String price,
    //     required String dateTime,
    //     String link = 'http://www.kotg.club',
    //     required String prize,
    //     required String eventDate}) async {
    //   await Get.bottomSheet(Container(
    //     color: kotgBlack,
    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(
    //               left: 15,
    //               top: 18,
    //             ),
    //             child: Row(
    //               children: [
    //                 Text(
    //                   eventName,
    //                   style: GoogleFonts.sarala(
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 26.sp,
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //                 Spacer(),
    //                 IconButton(
    //                     onPressed: () => context.pop(),
    //                     icon: Icon(
    //                       Ionicons.close,
    //                     ))
    //               ],
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.all(10),
    //             height: 200,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(15)),
    //                 image: DecorationImage(
    //                     image: NetworkImage(imageUrl), fit: BoxFit.cover)),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Wrap(
    //               crossAxisAlignment: WrapCrossAlignment.center,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                     right: 5,
    //                   ),
    //                   child: Icon(
    //                     LineIcons.calendarAlt,
    //                   ),
    //                 ),
    //                 Text(Jiffy(eventDate).format('dd MMM yyyy'),
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.bold,
    //                     )),
    //                 Padding(
    //                   padding: const EdgeInsets.only(right: 5, left: 20),
    //                   child: Icon(
    //                     LineIcons.clockAlt,
    //                   ),
    //                 ),
    //                 Text(Jiffy(dateTime).format('h:mm a'),
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.bold,
    //                     )),
    //                 Padding(
    //                   padding: const EdgeInsets.only(right: 5, left: 20),
    //                   child: Icon(
    //                     Ionicons.people,
    //                   ),
    //                 ),
    //                 Text(maxParticipants,
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.bold,
    //                     )),
    //                 Padding(
    //                   padding: const EdgeInsets.only(right: 5, left: 20),
    //                   child: Icon(
    //                     Ionicons.ticket_outline,
    //                   ),
    //                 ),
    //                 Text('MWK ${price}',
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.bold,
    //                     )),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Wrap(
    //               crossAxisAlignment: WrapCrossAlignment.center,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                     right: 5,
    //                   ),
    //                   child: Icon(
    //                     LineIcons.trophy,
    //                   ),
    //                 ),
    //                 Text('MWK ${prize}',
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.bold,
    //                     )),
    //                 Padding(
    //                   padding: const EdgeInsets.only(right: 5, left: 20),
    //                   child: Icon(
    //                     LineIcons.link,
    //                   ),
    //                 ),
    //                 Text(link,
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.bold,
    //                     )),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: MarkdownBody(
    //               shrinkWrap: true,
    //               data: desciption,
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ));
    // }

    return LoaderOverlay(
        overlayOpacity: 0.8,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: kotgBlack,
                leading: GestureDetector(
                  child: Icon(Ionicons.chevron_back, color: kotgGreen),
                  onTap: () {
                    context.pop();
                  },
                ),
                title: Text(
                  'My Tickets',
                  style: GoogleFonts.sarala(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: kotgGreen,
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BottomSheetHandle(),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 15, top: 18, bottom: 5),
                  //   child: Text(
                  //     'My Tickets',
                  //     style: GoogleFonts.sarala(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 20.sp,
                  //       color: kotgGreen,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                  //   child: Text('Touch ticket to copy ticket reference',
                  //       style: GoogleFonts.sarala(
                  //           fontWeight: FontWeight.normal,
                  //           fontSize: 10.sp,
                  //           color: Colors.grey)),
                  // ),
                  Divider(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _refreshTickets(context),
                      child: Consumer(builder: (context, ref, _) {
                        final _eventsRepo = ref.watch(eventsRepoProvider);

                        final _page = ref.watch(pageProvider.state);
                        return FutureBuilder(
                            // Initialize FlutterFire:
                            future: _eventsRepo.userEvents(),
                            builder: (context, snapshot) {
                              // Check for errors
                              if (snapshot.hasError) {
                                return Padding(
                                    padding: EdgeInsets.only(
                                      left: 15.sp,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35.sp,
                                          ),
                                          // Container(
                                          //   width: 50.w,
                                          //   child: ElevatedButton.icon(
                                          //     style: OutlinedButton.styleFrom(
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 5.0),
                                          //       ),
                                          //       enableFeedback: true,
                                          //       primary: kotgBlack,
                                          //       backgroundColor: kotgGreen,
                                          //     ),
                                          //     icon:
                                          //         Icon(Ionicons.ticket_outline),
                                          //     label: Text(
                                          //       'Find events',
                                          //       style: TextStyle(
                                          //         fontWeight: FontWeight.bold,
                                          //       ),
                                          //     ),
                                          //     onPressed: () {
                                          //       context.pop();
                                          //       _page.state = 1;
                                          //     },
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 35, left: 35, bottom: 5),
                                            child: Text(
                                                'find our events, on the events tab.',
                                                style: GoogleFonts.sarala(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 10.sp,
                                                    color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                    ));
                              }
                              // Once complete, show your application
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                var tickets = snapshot.data as List;

                                if (tickets.isEmpty) {
                                  //print('project snapshot data is: ${projectSnap.data}');
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          top: 35.sp,
                                          left: 15.sp,
                                          bottom: 35.sp),
                                      child: Center(
                                        child: Container(
                                          width: 50.w,
                                          child: ElevatedButton.icon(
                                            style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enableFeedback: true,
                                              primary: kotgBlack,
                                              backgroundColor: kotgGreen,
                                            ),
                                            icon: Icon(Ionicons.ticket_outline),
                                            label: Text(
                                              'Find events',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () {
                                              _page.state = 1;
                                              context.pop();
                                            },
                                          ),
                                        ),
                                      ));
                                }

                                return ListView.builder(
                                    itemCount: tickets.length,
                                    controller: scrollController,
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Widget _buildLeft() {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    tickets[index]['event']
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  // Text(
                                                  //   Jiffy('${events[index]['event']['event_date']} ${events[index]['event']['event_time']}')
                                                  //       .format(
                                                  //           'MMM do yyyy, h:mm a'),
                                                  //   style: TextStyle(
                                                  //       fontSize: 12.sp,
                                                  //       color: Colors.black,
                                                  //       fontWeight:
                                                  //           FontWeight.bold),
                                                  // ),

                                                  // Text(
                                                  //   events[index]['user']
                                                  //       ['username'],
                                                  //   style: TextStyle(
                                                  //       fontSize: 18.sp,
                                                  //       color: Colors.black,
                                                  //       fontWeight:
                                                  //           FontWeight.bold), 
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(height: 12.sp),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    Jiffy('${tickets[index]['event']['event_date']} ${tickets[index]['event']['event_time']}')
                                                        .format(
                                                            'MMM do yyyy, h:mm a'),
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Wrap(
                                                  children: <Widget>[
                                                    tickets[index]['status'] ==
                                                            "approved"
                                                        ? Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kotgGreen,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Text(
                                                                '${tickets[index]['status']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          )
                                                        : Consumer(builder:
                                                            (context, ref, _) {
                                                            final _regRepo =
                                                                ref.watch(
                                                              userPayProvider(
                                                                  tickets[index]
                                                                      [
                                                                      'reference']),
                                                            );

                                                            return _regRepo.map(
                                                                data: (data) {
                                                                  return OutlinedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          onPrimary: Colors
                                                                              .white,
                                                                          primary:
                                                                              kotgPurple),
                                                                      onPressed:
                                                                          () {
                                                                        _eventsRepo.ticketPay(
                                                                            reference:
                                                                                tickets[index]['reference']);
                                                                        _refreshTickets(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'Pay',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          )));
                                                                },
                                                                loading:
                                                                    (loading) =>
                                                                        LoadingIndicator(
                                                                          indicatorType:
                                                                              Indicator.ballPulseSync,
                                                                          colors: [
                                                                            kotgPurple
                                                                          ],
                                                                          strokeWidth:
                                                                              0.5,
                                                                          backgroundColor:
                                                                              Colors.black,
                                                                          pathBackgroundColor:
                                                                              Colors.black,
                                                                        ),
                                                                error: (error) =>
                                                                    Text(
                                                                        'Error')); //TODO Add Refresh
                                                          }),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      Widget _buildRight() {
                                        return tickets[index]['status'] ==
                                                "approved"
                                            ? Container(
                                                color: kotgGreen,
                                                child: Lottie.asset(
                                                  'assets/images/check-green.json',
                                                  height: 110.sp,
                                                  repeat: false,
                                                ),
                                              )
                                            : Container(
                                                color: Colors.grey,
                                                child: Lottie.asset(
                                                  'assets/images/processing-animation.json',
                                                  height: 110.sp,
                                                  repeat: false,
                                                ),
                                              );
                                        // return Container(
                                        //   child: Center(
                                        //     child: GestureDetector(
                                        //         child: QrImage(
                                        //           data: events[index]['reference'],
                                        //           version: QrVersions.auto,
                                        //           size: 90.sp,
                                        //         ),
                                        //         onTap: () {
                                        //           Clipboard.setData(ClipboardData(
                                        //             text: events[index]
                                        //                 ['reference'],
                                        //           ));

                                        //           Fluttertoast.showToast(
                                        //               msg: 'Copied to Clipboard',
                                        //               toastLength:
                                        //                   Toast.LENGTH_SHORT,
                                        //               gravity: ToastGravity.TOP,
                                        //               timeInSecForIosWeb: 1,
                                        //               fontSize: 16.0.sp);
                                        //         }),
                                        //   ),
                                        // );
                                      }

                                      return FadeIn(
                                          delay: Duration(milliseconds: 500),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: TicketMaterial(
                                                height: 150,
                                                colorBackground: Colors.white,
                                                leftChild: _buildLeft(),
                                                rightChild: _buildRight(),
                                                tapHandler: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                    text: tickets[index]
                                                        ['reference'],
                                                  ));

                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Copied to Clipboard',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      timeInSecForIosWeb: 1,
                                                      fontSize: 16.0.sp);
                                                }),
                                          ));
                                    });
                              }
                              // Otherwise, show something whilst waiting for initialization to complete
                              return TicketPageSkeletonWidget(
                                  scrollController: scrollController);
                            });
                      }),
                    ),
                  ),
                ],
              )),
        ));
  }
}
