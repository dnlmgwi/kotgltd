import 'package:animate_do/animate_do.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/home/page_provider.dart';
import 'package:kotgltd/features/tickets/widgets/ticket_page_skeleton.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_material/ticket_material.dart';
// import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TicketsPage extends ConsumerWidget {
  TicketsPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final _controller = FlipCardController();

  @override
  Widget build(BuildContext context, ref) {
    Future<void> _refreshTickets(BuildContext context) async {
      return ref.refresh(usereventsProvider);
    }

    void _showEventDestailsBottomSheet(
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
      await Get.bottomSheet(Container(
        color: kotgBlack,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 18,
                ),
                child: Row(
                  children: [
                    Text(
                      eventName,
                      style: GoogleFonts.sarala(
                        fontWeight: FontWeight.w600,
                        fontSize: 26.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Ionicons.close,
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover)),
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
      ));
    }

    return LoaderOverlay(
        overlayOpacity: 0.8,
        child: SafeArea(
          child: Scaffold(
              body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 15),
                child: Text(
                  'My Tickets',
                  style: GoogleFonts.sarala(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: kotgGreen,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Text(
                    'Touch ticket for more details, touch again to copy ticket reference',
                    style: GoogleFonts.sarala(
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                        color: Colors.grey)),
              ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 35.sp,
                                      ),
                                      Container(
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
                                            Get.back();
                                            _page.state = 1;
                                          },
                                        ),
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
                                      top: 35.sp, left: 15.sp, bottom: 35.sp),
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
                                itemBuilder: (BuildContext context, int index) {
                                  Widget _buildLeft() {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                tickets[index]['event']['name'],
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
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
                                                MainAxisAlignment.spaceBetween,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: <Widget>[
                                                tickets[index]['status'] ==
                                                        "approved"
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            color: kotgGreen,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text(
                                                            '${tickets[index]['status']}',
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text(
                                                            '${tickets[index]['status']}',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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

                                  Widget _buildQRLeft() {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        QrImage(
                                          data: tickets[index]['reference'],
                                          version: QrVersions.auto,
                                          size: 100.sp,
                                        )
                                      ],
                                    );
                                  }

                                  return FadeIn(
                                      delay: Duration(milliseconds: 500),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: FlipCard(
                                          controller: _controller,
                                          fill: Fill
                                              .fillBack, // Fill the back side of the card to make in the same size as the front.
                                          direction: FlipDirection
                                              .HORIZONTAL, // default
                                          front: TicketMaterial(
                                              height: 150,
                                              colorBackground: Colors.white,
                                              leftChild: _buildLeft(),
                                              rightChild: _buildRight(),
                                              tapHandler: () {
                                                _controller.toggleCard();
                                              }),
                                          back: TicketMaterial(
                                              height: 150,
                                              colorBackground: Colors.white,
                                              leftChild: _buildQRLeft(),
                                              rightChild: _buildRight(),
                                              tapHandler: () {
                                                Clipboard.setData(ClipboardData(
                                                  text: tickets[index]
                                                      ['reference'],
                                                ));

                                                Fluttertoast.showToast(
                                                    msg: 'Copied to Clipboard',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    timeInSecForIosWeb: 1,
                                                    fontSize: 10.0.sp);

                                                _controller.toggleCard();
                                              }),
                                        ),
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
