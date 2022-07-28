import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketData extends StatelessWidget {
  const TicketData(
      {Key? key,
      required this.ticketId,
      required this.eventName,
      required this.status,
      required this.eventDate,
      required this.eventTime,
      required this.game,
      required this.reference,
      required this.firstName,
      required this.lastName})
      : super(key: key);

  final String ticketId,
      eventName,
      status,
      eventTime,
      eventDate,
      game,
      reference,
      firstName,
      lastName;

  @override
  Widget build(BuildContext context) {
    void _showTicketDialog({required String reference}) async {
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
                            'There is a problem with this ticket, Contact support for help using the ticket reference.',
                            style: GoogleFonts.sarala(
                                fontWeight: FontWeight.normal,
                                fontSize: 10.sp,
                                color: Colors.grey)),
                      ),
                      ListTile(
                        leading: Icon(Ionicons.logo_discord),
                        title: Text('Our Channel'),
                        enableFeedback: true,
                        enabled: false,
                      ),
                      ListTile(
                        leading: Icon(Ionicons.mail_unread_outline),
                        title: Text('Email Us'),
                        enableFeedback: true,
                        enabled: false,
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      child: Text('Copy Reference'),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                          text: reference,
                        ));
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: 'Copied to Clipboard',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            fontSize: 10.0.sp);
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

    Widget _buildStatus() {
      switch (status) {
        case "approved":
          return Container(
            width: 120.0,
            height: 25.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 1.0, color: Colors.green),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(color: Colors.green),
              ),
            ),
          );
        case "received":
          return Container(
            width: 120.0,
            height: 25.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 1.0, color: Colors.orange),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(color: Colors.orange),
              ),
            ),
          );
        case "processing":
          return Container(
            width: 120.0,
            height: 25.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 1.0, color: Colors.grey),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );

        default:
          return Container(
            width: 120.0,
            height: 25.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 1.0, color: Colors.red),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatus(),
            if (status == "rejected")
              IconButton(
                  onPressed: () => _showTicketDialog(reference: reference),
                  tooltip: 'More Info',
                  icon: Icon(
                    LineIcons.questionCircle,
                    color: Colors.black,
                  ))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            eventName,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget(
                'Name',
                '${firstName} ${lastName}',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child: ticketDetailsWidget('Ticket Ref', reference,
                    'Event Date', Jiffy(eventDate).format('dd MMM yyyy')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 53.0),
                child: ticketDetailsWidget(
                  'Game',
                  game,
                  'Event Time',
                  Jiffy(eventTime).format('h:mm a'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
            child: Container(
              width: 160.sp,
              height: 160.sp,
              child: QrImage(
                data: reference,
                version: QrVersions.auto,
                size: 230.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    [String secondTitle = "", String secondDesc = ""]) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
