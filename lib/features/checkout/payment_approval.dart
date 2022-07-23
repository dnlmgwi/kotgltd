import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PaymentApprovalPage extends ConsumerWidget {
  PaymentApprovalPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: LoaderOverlay(
        overlayOpacity: 0.8,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: kotgBlack,
            leading: IconButton(
              icon: Icon(Ionicons.chevron_back, color: kotgGreen),
              onPressed: () {
                context.pop();
              },
            ),
            title: Text(
              'Payment Approval',
              style: GoogleFonts.sarala(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: kotgGreen,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "You will recieve a prompt to enter your pin, the payment will only be approved after entering your pin.",
                      style: GoogleFonts.sarala(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        bottom: 35.0,
                      ),
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enableFeedback: true,
                          primary: kotgBlack,
                          backgroundColor: kotgGreen,
                        ),
                        onPressed: () {
                          context.pop();
                          context.go('/dashboard');
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Done",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
