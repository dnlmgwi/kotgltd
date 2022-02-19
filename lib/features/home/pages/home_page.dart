import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/home/page_provider.dart';
// import 'package:kotgltd/features/reminder/providers/reminder_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context, ref) {
    final _user = ref.watch(currentUserProvider);
    final _page = ref.watch(pageProvider.state);
    // final _reminder = ref.watch(addRemiderProvider);

    Future<void> _refreshEvents(BuildContext context) async {
      return ref.refresh(eventsRepoProvider);
    }

    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.sp, top: 18.sp, bottom: 25.sp),
            child: Consumer(builder: (context, ref, _) {
              return FadeIn(
                delay: Duration(milliseconds: 500),
                child: _user.map(
                  loading: (loading) => CircularProgressIndicator(),
                  data: (data) => Text(
                    'Welcome, ${data.value!.username}',
                    style: GoogleFonts.sarala(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  error: (error) => Container(
                    height: 130.sp,
                    child: Center(
                      child: Text('Error'), //TODO Error Icon
                    ),
                  ),
                ),
              );
            }),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, top: 18, bottom: 5),
          //   child: Text(
          //     "What's new",
          //     style: GoogleFonts.sarala(
          //         fontWeight: FontWeight.w600,
          //         color: Colors.grey,
          //         fontSize: 20),
          //   ),
          // ),
          // Consumer(builder: (context, ref, _) {
          //   final _eventsRepo = ref.watch(eventsRepoProvider);

          //   return FutureBuilder(
          //       // Initialize FlutterFire:
          //       future: _eventsRepo.fetchEvents(),
          //       builder: (context, snapshot) {
          //         // Check for errors
          //         if (snapshot.hasError) {
          //           return Container(
          //             height: 200,
          //             child: Expanded(
          //               child: Swiper(
          //                 itemBuilder: (BuildContext context, int index) {
          //                   return Container(
          //                     height: 200,
          //                     child: Skeleton(
          //                         height: 12,
          //                         width: 24,
          //                         style: SkeletonStyle.text),
          //                     decoration: BoxDecoration(
          //                       color: kotgBlack,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(15)),
          //                     ),
          //                   );
          //                 },
          //                 pagination: SwiperPagination(
          //                   builder: SwiperPagination.dots,
          //                 ),
          //                 layout: SwiperLayout.TINDER,
          //                 itemCount: 3,
          //                 itemHeight: 200,
          //                 itemWidth: 550,
          //                 viewportFraction: 0.4,
          //                 autoplay: true,
          //                 autoplayDelay: 10000,
          //                 autoplayDisableOnInteraction: true,
          //                 scale: 0.8,
          //                 onTap: (int post) {},
          //               ),
          //             ),
          //           );
          //         }
          //         // Once complete, show your application
          //         if (snapshot.connectionState == ConnectionState.done) {
          //           var events = snapshot.data as List;

          //           if (events.isEmpty) {
          //             //print('project snapshot data is: ${projectSnap.data}');
          //             return Center(
          //               child: Text("We couldn't find anything new"),
          //             );
          //           }

          //           return Container(
          //             height: 200,
          //             child: Swiper(
          //               itemBuilder: (BuildContext context, int index) {
          //                 return Container(
          //                   height: 200,
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.end,
          //                     crossAxisAlignment: CrossAxisAlignment.end,
          //                     children: [
          //                       Container(
          //                         height: 70,
          //                         child: Card(
          //                           shape: RoundedRectangleBorder(
          //                             borderRadius: BorderRadius.circular(15.0),
          //                           ),
          //                           color: Colors.transparent,
          //                           child: ListTile(
          //                               title: Text(events[index]['name'])),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   decoration: BoxDecoration(
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(15)),
          //                       image: DecorationImage(
          //                           image: NetworkImage(
          //                               events[index]['image']['url']),
          //                           fit: BoxFit.cover)),
          //                 );
          //               },
          //               pagination: SwiperPagination(
          //                 builder: SwiperPagination.dots,
          //               ),
          //               layout: SwiperLayout.TINDER,
          //               itemCount: events.length,
          //               itemHeight: 200,
          //               itemWidth: 550,
          //               viewportFraction: 0.4,
          //               autoplay: true,
          //               autoplayDelay: 10000,
          //               autoplayDisableOnInteraction: true,
          //               scale: 0.8,
          //               onTap: (int post) {},
          //             ),
          //           );
          //         }
          //         // Otherwise, show something whilst waiting for initialization to complete
          //         return Container(
          //           height: 200,
          //           child: Swiper(
          //             itemBuilder: (BuildContext context, int index) {
          //               return Container(
          //                 height: 200,
          //                 child: Skeleton(
          //                     height: 12, width: 24, style: SkeletonStyle.text),
          //                 decoration: BoxDecoration(
          //                   color: kotgBlack,
          //                   borderRadius: BorderRadius.all(Radius.circular(15)),
          //                 ),
          //               );
          //             },
          //             pagination: SwiperPagination(
          //               builder: SwiperPagination.dots,
          //             ),
          //             layout: SwiperLayout.TINDER,
          //             itemCount: 3,
          //             itemHeight: 200,
          //             itemWidth: 550,
          //             viewportFraction: 0.4,
          //             autoplay: true,
          //             autoplayDelay: 10000,
          //             autoplayDisableOnInteraction: true,
          //             scale: 0.8,
          //             onTap: (int post) {},
          //           ),
          //         );
          //       });
          // }),
          Padding(
            padding: EdgeInsets.only(
              left: 15.sp,
              top: 18,
            ),
            child: Text(
              "Events Tickets",
              style: GoogleFonts.sarala(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 15.sp),
            ),
          ),
          RefreshIndicator(
            onRefresh: () => _refreshEvents(context),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Consumer(builder: (context, ref, _) {
                final _eventsRepo = ref.watch(eventsRepoProvider);

                return Center(
                  child: FutureBuilder(
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
                                          _page.state = 1;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }
                        // Once complete, show your application
                        if (snapshot.connectionState == ConnectionState.done) {
                          var events = snapshot.data as List;

                          if (events.isEmpty) {
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

                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                GestureDetector(
                                                    child: QrImage(
                                                      data: events[index]
                                                          ['reference'],
                                                      version: QrVersions.auto,
                                                      size: 80.sp,
                                                    ),
                                                    onTap: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                        text: events[index]
                                                            ['reference'],
                                                      ));

                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Copied to Clipboard',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity:
                                                              ToastGravity.TOP,
                                                          timeInSecForIosWeb: 1,
                                                          fontSize: 16.0.sp);
                                                    }),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.sp,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  Jiffy('${events[index]['event']['event_date']} ${events[index]['event']['event_time']}')
                                                      .format(
                                                          'MMM do yyyy, h:mm a'),
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),

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
                                                  events[index]['user']
                                                      ['username'],
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.grey),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    events[index]['status'] ==
                                                            "approved"
                                                        ? Text(
                                                            '${events[index]['status']}',
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color:
                                                                    kotgGreen),
                                                          )
                                                        : Text(
                                                            events[index]
                                                                ['status'],
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 12),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // OutlinedButton(
                                            //     style: ElevatedButton.styleFrom(
                                            //         onPrimary: Colors.white,
                                            //         primary: kotgPurple),
                                            //     onPressed: () async {
                                            //       _reminder.eventDetails(
                                            //         title:
                                            //             'King of The Grid Esports ${events[index]['event']['name']}',
                                            //         description: events[index]
                                            //             ['user']['username'],
                                            //         location: events[index]['event']
                                            //             ['name'],
                                            //         startDate: DateTime.parse(
                                            //             events[index]['event']
                                            //                 ['event_date']),
                                            //         endDate: DateTime.parse(
                                            //             events[index]['event']
                                            //                 ['event_date']),
                                            //       );
                                            //     },
                                            //     child: Text('Set Reminder',
                                            //         style: GoogleFonts.poppins(
                                            //           fontWeight: FontWeight.w600,
                                            //           fontSize: 15.sp,
                                            //         ))),
                                            IconButton(
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                    text: events[index]
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
                                                },
                                                icon: Icon(
                                                  Ionicons.share_outline,
                                                  color: kotgBlack,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                layout: SwiperLayout.STACK,
                                itemCount: events.length,
                                itemHeight: 250.sp,
                                itemWidth: 450.sp,
                                viewportFraction: 0.4,
                                autoplay: true,
                                autoplayDelay: 20000,
                                autoplayDisableOnInteraction: true,
                                scale: 0.5,
                                onTap: (int post) {},
                              ),
                            ),
                          );
                        }
                        // Otherwise, show something whilst waiting for initialization to complete
                        return Container(
                          height: 200.sp,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 200.sp,
                                child: Skeleton(
                                    height: 12, style: SkeletonStyle.text),
                                decoration: BoxDecoration(
                                  color: kotgBlack,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              );
                            },
                            pagination: SwiperPagination(
                              builder: SwiperPagination.dots,
                            ),
                            layout: SwiperLayout.TINDER,
                            itemCount: 3,
                            itemHeight: 200.sp,
                            itemWidth: 550.sp,
                            viewportFraction: 0.4,
                            autoplay: true,
                            autoplayDelay: 10000,
                            autoplayDisableOnInteraction: true,
                            scale: 0.8,
                            onTap: (int post) {},
                          ),
                        );
                      }),
                );
              }),
            ),
          ),
        ],
      ),
    ));
  }
}
