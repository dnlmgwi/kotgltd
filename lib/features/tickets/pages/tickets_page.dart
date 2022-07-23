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
import 'package:line_icons/line_icon.dart';
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

    return LoaderOverlay(
        overlayOpacity: 0.8,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: kotgBlack,
                leading: IconButton(
                  icon: Icon(Ionicons.chevron_back, color: kotgGreen),
                  onPressed: () {
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
                                      void _showTicketDialog(
                                          {required String reference}) async {
                                        await showDialog(
                                          context: context,
                                          builder: (context) => Consumer(
                                            builder: ((context, ref, child) {
                                              return LoaderOverlay(
                                                overlayOpacity: 0.8,
                                                child: AlertDialog(
                                                  backgroundColor: kotgBlack,
                                                  title: Text(
                                                    'Attention Needed',
                                                    style: GoogleFonts.sarala(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  bottom: 15),
                                                          child: Text(
                                                              'There is a problem with this ticket, Contact support for help using the ticket reference.',
                                                              style: GoogleFonts.sarala(
                                                                  fontWeight: 
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey)),
                                                        ),
                                                        ListTile(
                                                          leading: Icon(Ionicons
                                                              .logo_discord),
                                                          title: Text(
                                                              'Our Channel'),
                                                          enableFeedback: true,
                                                          enabled: false,
                                                        ),
                                                        ListTile(
                                                          leading: Icon(Ionicons
                                                              .mail_unread_outline),
                                                          title:
                                                              Text('Email Us'),
                                                          enableFeedback: true,
                                                          enabled: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                        child: Text(
                                                            'Copy Reference'),
                                                        onPressed: () {
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                            text: reference,
                                                          ));
                                                          Navigator.pop(
                                                              context);
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Copied to Clipboard',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              fontSize:
                                                                  10.0.sp);
                                                        }),
                                                    OutlinedButton(
                                                      child: Text('Dismiss'),
                                                      style: ButtonStyle(),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        );
                                      }

                                      Widget _buildLeft() {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Wrap(
                                                          children: <Widget>[
                                                            if (tickets[index][
                                                                    'status'] ==
                                                                "approved")
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        kotgGreen,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  // child: Text(
                                                                  //   '${tickets[index]['status']}',
                                                                  //   style: TextStyle(
                                                                  //       fontSize: 10.sp,
                                                                  //       color: Colors
                                                                  //           .black),
                                                                  // ),
                                                                ),
                                                              ),
                                                            if (tickets[index][
                                                                    'status'] ==
                                                                "processing")
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  // child: Text(
                                                                  //   '${tickets[index]['status']}',
                                                                  //   style: TextStyle(
                                                                  //       fontSize: 10.sp,
                                                                  //       color: Colors
                                                                  //           .black),
                                                                  // ),
                                                                ),
                                                              ),
                                                            if (tickets[index][
                                                                    'status'] ==
                                                                "rejected")
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  // child: Text(
                                                                  //   '${tickets[index]['status']}',
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 10.sp,
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          tickets[index]
                                                              ['event']['name'],
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        if (tickets[index]
                                                                ['status'] ==
                                                            "rejected")
                                                          IconButton(
                                                              onPressed: () =>
                                                                  _showTicketDialog(
                                                                      reference:
                                                                          tickets[index]
                                                                              [
                                                                              'reference']),
                                                              tooltip:
                                                                  'More Info',
                                                              icon: Icon(
                                                                LineIcons
                                                                    .questionCircle,
                                                                color: Colors
                                                                    .black,
                                                              ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: LineIcon.calendar(
                                                        color: Colors.grey,
                                                        size: 10.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      Jiffy('${tickets[index]['event']['event_date']} ${tickets[index]['event']['event_time']}')
                                                          .format(
                                                              'MMM do yyyy, h:mm a'),
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            color: Colors.grey),
                                                      ),
                                                      child: Text(
                                                        'Ticket Ref: ' +
                                                            tickets[index]
                                                                ['reference'],
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey),
                                                      ),
                                                      onPressed: () {
                                                        Clipboard.setData(
                                                            ClipboardData(
                                                          text: tickets[index]
                                                              ['reference'],
                                                        ));

                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Copied to Clipboard',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .TOP,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            fontSize: 10.0.sp);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      Widget _buildRight() {
                                        switch (tickets[index]['status']) {
                                          case "approved":
                                            return Container(
                                              color: kotgGreen,
                                              child: Lottie.asset(
                                                'assets/images/check-green.json',
                                                height: 110.sp,
                                                repeat: false,
                                              ),
                                            );
                                          case "processing":
                                            return Container(
                                                color: Colors.grey,
                                                child: Lottie.asset(
                                                  'assets/images/processing-animation.json',
                                                  height: 110.sp,
                                                  repeat: false,
                                                ));

                                          default:
                                            return Container(
                                                color: Colors.red,
                                                child: Lottie.asset(
                                                  'assets/images/cancel-animation.json',
                                                  width: 50.sp,
                                                  repeat: false,
                                                ));
                                        }
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
