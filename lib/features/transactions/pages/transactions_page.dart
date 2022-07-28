import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/components.dart';
import 'package:kotgltd/features/home/page_provider.dart';
import 'package:kotgltd/features/transactions/providers/transactions_providers.dart';
import 'package:kotgltd/features/transactions/widgets/transactions_page_skeleton.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionsPage extends ConsumerWidget {
  TransactionsPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    Future<void> _refreshTickets() async {
      return ref.refresh(transactionRepoProvider);
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
                  'Transactions',
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
                      onRefresh: () => _refreshTickets(),
                      child: Consumer(builder: (context, ref, _) {
                        final _eventsRepo = ref.watch(transactionRepoProvider);

                        final _page = ref.watch(pageProvider.state);
                        return FutureBuilder(
                            // Initialize FlutterFire:
                            future: _eventsRepo.myTransactions(),
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
                                                snapshot.error.toString(),
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
                                var payment = snapshot.data as List;

                                if (payment.isEmpty) {
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
                                    itemCount: payment.length,
                                    controller: scrollController,
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // void _showTicketDialog(
                                      //     {required String reference}) async {
                                      //   await showDialog(
                                      //     context: context,
                                      //     builder: (context) => Consumer(
                                      //       builder: ((context, ref, child) {
                                      //         return LoaderOverlay(
                                      //           overlayOpacity: 0.8,
                                      //           child: AlertDialog(
                                      //             backgroundColor: kotgBlack,
                                      //             title: Text(
                                      //               'Attention Needed',
                                      //               style: GoogleFonts.sarala(
                                      //                 fontWeight:
                                      //                     FontWeight.w600,
                                      //                 fontSize: 20.sp,
                                      //                 color: Colors.grey,
                                      //               ),
                                      //             ),
                                      //             content:
                                      //                 SingleChildScrollView(
                                      //               child: Column(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .start,
                                      //                 crossAxisAlignment:
                                      //                     CrossAxisAlignment
                                      //                         .start,
                                      //                 children: [
                                      //                   Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                                 .only(
                                      //                             top: 5,
                                      //                             bottom: 15),
                                      //                     child: Text(
                                      //                         'There is a problem with this ticket, Contact support for help using the ticket reference.',
                                      //                         style: GoogleFonts.sarala(
                                      //                             fontWeight:
                                      //                                 FontWeight
                                      //                                     .normal,
                                      //                             fontSize:
                                      //                                 10.sp,
                                      //                             color: Colors
                                      //                                 .grey)),
                                      //                   ),
                                      //                   ListTile(
                                      //                     leading: Icon(Ionicons
                                      //                         .logo_discord),
                                      //                     title: Text(
                                      //                         'Our Channel'),
                                      //                     enableFeedback: true,
                                      //                     enabled: false,
                                      //                   ),
                                      //                   ListTile(
                                      //                     leading: Icon(Ionicons
                                      //                         .mail_unread_outline),
                                      //                     title:
                                      //                         Text('Email Us'),
                                      //                     enableFeedback: true,
                                      //                     enabled: false,
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //             actions: [
                                      //               ElevatedButton(
                                      //                   child: Text(
                                      //                       'Copy Reference'),
                                      //                   onPressed: () {
                                      //                     Clipboard.setData(
                                      //                         ClipboardData(
                                      //                       text: reference,
                                      //                     ));
                                      //                     Navigator.pop(
                                      //                         context);
                                      //                     Fluttertoast.showToast(
                                      //                         msg:
                                      //                             'Copied to Clipboard',
                                      //                         toastLength: Toast
                                      //                             .LENGTH_SHORT,
                                      //                         gravity:
                                      //                             ToastGravity
                                      //                                 .TOP,
                                      //                         timeInSecForIosWeb:
                                      //                             1,
                                      //                         fontSize:
                                      //                             10.0.sp);
                                      //                   }),
                                      //               OutlinedButton(
                                      //                 child: Text('Dismiss'),
                                      //                 style: ButtonStyle(),
                                      //                 onPressed: () =>
                                      //                     Navigator.pop(
                                      //                         context),
                                      //               )
                                      //             ],
                                      //           ),
                                      //         );
                                      //       }),
                                      //     ),
                                      //   );
                                      // }

                                      return FadeIn(
                                          delay: Duration(milliseconds: 500),
                                          child: Card(
                                            elevation: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: ListTile(
                                                  trailing: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'MWK',
                                                        style:
                                                            GoogleFonts.oxygen(
                                                                fontSize: 7.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        payment[index]['attributes']
                                                                            [
                                                                            'event']
                                                                        ['data']
                                                                    [
                                                                    'attributes']
                                                                ['price']
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.oxygen(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  leading: Icon(
                                                      Ionicons.receipt_outline),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          payment[index]
                                                                  ['attributes']
                                                              ['result_desc'],
                                                          style: GoogleFonts
                                                              .sarala(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: Colors
                                                                      .grey)),
                                                      Text(
                                                          timeago.format(DateTime
                                                              .parse(payment[
                                                                          index]
                                                                      [
                                                                      'attributes']
                                                                  [
                                                                  'createdAt'])),
                                                          style: GoogleFonts
                                                              .sarala(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey))
                                                    ],
                                                  ),
                                                  title: AutoSizeText(
                                                      payment[index]
                                                              ['attributes']
                                                          ['conversation_id'],
                                                      wrapWords: true,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: GoogleFonts.sarala(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10.sp,
                                                        color: Colors.white,
                                                      ))),
                                            ),
                                          ));
                                    });
                              }
                              // Otherwise, show something whilst waiting for initialization to complete
                              return TransactionPageSkeletonWidget(
                                scrollController: scrollController,
                              );
                            });
                      }),
                    ),
                  ),
                ],
              )),
        ));
  }
}
