import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/features/tickets/widgets/ticket_data.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class TicketPage extends ConsumerWidget {
  TicketPage({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final String eventId;

  @override
  Widget build(BuildContext context, ref) {
    final _repo = ref.watch(eventsRepoProvider);

    Future<void> _refreshTicket() async {
      return ref.refresh(ticketProvider(int.parse(
        eventId,
      )));
    }

    return SafeArea(
      child: LoaderOverlay(
        overlayOpacity: 0.8,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: kotgBlack,
            leading: GestureDetector(
              child: Icon(Ionicons.chevron_back, color: kotgGreen),
              onTap: () {
                context.pop();
              },
            ),
            title: Text(
              'My Ticket',
              style: GoogleFonts.sarala(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: kotgGreen,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Consumer(builder: (context, watch, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _refreshTicket(),
                      child: Consumer(builder: (context, ref, _) {
                        final _events =
                            ref.watch(ticketProvider(int.parse(eventId)));
                        // final _payment = ref.read(walletProvider);

                        // print(_events);
                        return _events.map(
                            data: (ticket) {
                              if (ticket.value!.isEmpty) {
                                //print('project snapshot data is: ${projectSnap.data}');
                                return Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "We couldn't find your ticket, if you think this is wrong please report this error to us."),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 35.0,
                                        ),
                                        child: ElevatedButton(
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enableFeedback: true,
                                            primary: kotgBlack,
                                            backgroundColor: kotgGreen,
                                          ),
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text(
                                                "Back",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TicketWidget(
                                    width: 350,
                                    height: 500,
                                    isCornerRounded: true,
                                    padding: EdgeInsets.all(20),
                                    child: TicketData(
                                        firstName: ticket
                                            .value
                                            .first
                                            .eventAttributes
                                            .user!
                                            .eventUserData
                                            .eventUserAttributes
                                            .firstName!,
                                        lastName: ticket
                                            .value
                                            .first
                                            .eventAttributes
                                            .user!
                                            .eventUserData
                                            .eventUserAttributes
                                            .lastName!,
                                        game: ticket
                                            .value
                                            .first
                                            .eventAttributes
                                            .event
                                            .eventData
                                            .eventRegAttributes
                                            .game!
                                            .gameData
                                            .gameAttributes
                                            .name,
                                        reference: ticket.value.first
                                            .eventAttributes.reference,
                                        ticketId: ticket.value.first.id,
                                        eventName: ticket
                                            .value
                                            .first
                                            .eventAttributes
                                            .event
                                            .eventData
                                            .eventRegAttributes
                                            .name,
                                        status: ticket
                                            .value.first.eventAttributes.status,
                                        eventDate:
                                            '${ticket.value.first.eventAttributes.event.eventData.eventRegAttributes.eventDate} ${ticket.value.first.eventAttributes.event.eventData.eventRegAttributes.eventTime}',
                                        eventTime:
                                            '${ticket.value.first.eventAttributes.event.eventData.eventRegAttributes.eventDate} ${ticket.value.first.eventAttributes.event.eventData.eventRegAttributes.eventTime}'),
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  if (ticket
                                          .value.first.eventAttributes.status !=
                                      "approved")
                                    FadeIn(
                                      delay: Duration(milliseconds: 500),
                                      child: ElevatedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enableFeedback: true,
                                          primary: kotgBlack,
                                          backgroundColor: kotgGreen,
                                        ),
                                        onPressed: () {
                                          context.loaderOverlay.show();

                                          _repo
                                              .ticketPay(
                                                  reference: ticket
                                                      .value
                                                      .first
                                                      .eventAttributes
                                                      .reference)
                                              .then((value) {
                                            context.loaderOverlay.hide();
                                            print(value);
                                            context.push('/payment-approval');
                                          }).catchError((error, stackTrace) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        error.toString())));

                                            context.loaderOverlay.hide();
                                          });
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "Pay Now",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FadeIn(
                                    delay: Duration(milliseconds: 600),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enableFeedback: true,
                                        primary: kotgGreen,
                                      ),
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Dismiss",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            error: (error) {
                              return Column(
                                children: [
                                  Text('Network Error'),
                                ],
                              );
                            },
                            loading: (loading) =>
                                Center(child: CircularProgressIndicator()));
                      }),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
