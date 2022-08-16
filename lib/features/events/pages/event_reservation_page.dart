import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EventReservationPage extends ConsumerWidget {
  EventReservationPage({
    Key? key,
    required this.eventId,
    required this.game,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final String eventId, game;

  @override
  Widget build(BuildContext context, ref) {
    final _ign = ref.watch(ignProvider.state).state;
    final _tc = ref.watch(tcEventsProvider.state).state;
    final _eventsRepo = ref.watch(eventsRepoProvider);
    final _profileRepo = ref.watch(profileRepoProvider);

    void updateTermsAndConditions(bool tc) {
      ref.read(tcEventsProvider.state).state = tc;
    }

    void updateIGN(String ign) {
      ref.read(ignProvider.state).state = ign;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kotgBlack,
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back, color: kotgGreen),
          onPressed: () {
            // if (_formKey.currentState!.validate()) {
            context.pop();
            // }
          },
        ),
        title: Text(
          'Event Reservation',
          style: GoogleFonts.sarala(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: kotgGreen,
          ),
        ),
      ),
      body: LoaderOverlay(
        overlayOpacity: 0.8,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Consumer(builder: (context, watch, _) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 15),
                        child: RichText(
                          text: TextSpan(
                            text: 'Your ',
                            style: GoogleFonts.oxygen(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                  text: game,
                                  style: GoogleFonts.oxygen(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp,
                                      color: kotgGreen)),
                              TextSpan(
                                text: ', IGN is ',
                                style: GoogleFonts.oxygen(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                  text: _ign,
                                  style: GoogleFonts.oxygen(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp,
                                      color: kotgGreen)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.sp),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: kotgGreen, width: 2)),
                          filled: false,
                          labelText: 'Enter IGN',
                          labelStyle: GoogleFonts.oxygen(
                              color: kotgGreen,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),

                        maxLines: 1,
                        onChanged: (String ign) => updateIGN(ign),
                        showCursor: true,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid IGN';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 15),
                        child: Text(
                            'By accepting the Terms & Conditions and continuing, your spot will be reserved until the registration fee is paid.',
                            style: GoogleFonts.sarala(
                                fontWeight: FontWeight.normal,
                                fontSize: 10.sp,
                                color: Colors.grey)),
                      ),
                      CheckboxListTile(
                          activeColor: kotgBlack,
                          checkColor: kotgGreen,
                          selected: false,
                          title: Text('I Accept the terms and conditions'),
                          tileColor: kotgBlack,
                          value: _tc,
                          onChanged: (value) {
                            updateTermsAndConditions(value!);
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enableFeedback: true,
                          primary: kotgBlack,
                          backgroundColor: kotgGreen,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            if (_tc) {
                              _eventsRepo
                                  .registerEvent(
                                eventID: eventId,
                                ign: _ign,
                              )
                                  .then((ticket) {
                                Navigator.pop(context);
                                context.loaderOverlay.hide();

                                //TODO Update Ticket with IGN

                                context.push('/events/ticket/${eventId}');

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please Accept Terms And Conditions"),
                                      backgroundColor: Colors.red));
                            }
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enableFeedback: true,
                          primary: kotgBlack,
                          // backgroundColor: kotgGreen,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Back",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kotgGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

    // void _showEventRegDialog({
    //   required String eventId,
    // }) async {
    //   await showDialog(
    //     context: context,
    //     builder: (context) => Consumer(
    //       builder: ((context, ref, child) {
    //         final _tc = ref.watch(tcEventsProvider.state).state;

    //         return LoaderOverlay(
    //           overlayOpacity: 0.8,
    //           child: AlertDialog(
    //             backgroundColor: kotgBlack,
    //             title: Text(
    //               'Event Reservation',
    //               style: GoogleFonts.sarala(
    //                 fontWeight: FontWeight.w600,
    //                 fontSize: 20.sp,
    //                 color: Colors.grey,
    //               ),
    //             ),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 5, bottom: 15),
    //                     child: Text(
    //                         'By selecting confirm your spot will be reserved, until you pay the registration fee.',
    //                         style: GoogleFonts.sarala(
    //                             fontWeight: FontWeight.normal,
    //                             fontSize: 10.sp,
    //                             color: Colors.grey)),
    //                   ),
    //                   // BottomSheetHandle(),
    //                   CheckboxListTile(
    //                       activeColor: kotgBlack,
    //                       checkColor: kotgGreen,
    //                       selected: false,
    //                       title: Text('I Accept the terms and conditions'),
    //                       tileColor: kotgBlack,
    //                       value: _tc,
    //                       onChanged: (value) {
    //                         updateTermsAndConditions(context, value!);
    //                       }),
    //                 ],
    //               ),
    //             ),
    //             actions: [
    //               ElevatedButton(
    //                   child: Text('Confirm'),
    //                   onPressed: () {
    //                     context.loaderOverlay.show();
    //                     if (_tc) {
    //                       _eventsRepo
    //                           .registerEvent(
    //                         eventID: eventId,
    //                       )
    //                           .then((ticket) {
    //                         Navigator.pop(context);
    //                         context.loaderOverlay.hide();

    //                         context.push('/events/ticket/${eventId}');

    //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                             content: Text("Sucessfully Reserved")));

    //                         ref.refresh(registeredEventsProvider(
    //                           int.parse(
    //                             eventId,
    //                           ),
    //                         ));
    //                       }).onError(
    //                         (error, stackTrace) {
    //                           context.push('/profile');
    //                           ScaffoldMessenger.of(context).showSnackBar(
    //                               SnackBar(
    //                                   content: Text(error.toString()),
    //                                   backgroundColor: Colors.red));

    //                           context.loaderOverlay.hide();
    //                         },
    //                       );
    //                     } else {
    //                       context.loaderOverlay.hide();
    //                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                           content:
    //                               Text("Please Accept Terms And Conditions"),
    //                           backgroundColor: Colors.red));
    //                     }
    //                   }),
    //               OutlinedButton(
    //                 child: Text('Dismiss'),
    //                 style: ButtonStyle(),
    //                 onPressed: () => Navigator.pop(context),
    //               )
    //             ],
    //           ),
    //         );
    //       }),
    //     ),
    //   );
    // }
