import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/events/providers/events_providers.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PaymentPage extends ConsumerWidget {
  PaymentPage({
    Key? key,
    required this.ticketRef,
    required this.eventName,
    required this.price,
  }) : super(
          key: key,
        );

  final _formKey = GlobalKey<FormState>();

  final String ticketRef;
  final String eventName;
  final String price;

  @override
  Widget build(BuildContext context, ref) {
    final _repo = ref.watch(eventsRepoProvider);

    final _phoneNumber = ref.watch(paymentPhoneNumberProvider.state).state;
    final _paymentOption = ref.watch(paymentOptionProvider.state).state;

    void updatePhoneNumber(PhoneNumber phoneNumber) {
      print(phoneNumber);
      ref.watch(paymentPhoneNumberProvider.state).state = phoneNumber;
    }

    void updatePaymentOption(PaymentOption paymentOption) {
      ref.read(paymentOptionProvider.state).state = paymentOption;
    }

    return Scaffold(
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
          'Payment',
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
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Consumer(builder: (context, watch, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Order Details',
                                style: GoogleFonts.oxygen(
                                    fontSize: 12.sp,
                                    color: kotgGreen,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                eventName,
                                style: GoogleFonts.oxygen(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Ticket Reference: ${ticketRef}",
                                style: GoogleFonts.oxygen(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Total',
                                style: GoogleFonts.oxygen(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    'MWK',
                                    style: GoogleFonts.oxygen(
                                        fontSize: 7.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    price,
                                    style: GoogleFonts.oxygen(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          // Red border with the width is equal to 5
                          border: Border.all(width: 0.5, color: kotgGreen),
                        )),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Divider(),
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Payment Details',
                            style: GoogleFonts.oxygen(
                                fontSize: 12.sp,
                                color: kotgGreen,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // ListTile(
                        //   title: Text(
                        //     'Fullname',
                        //     style: GoogleFonts.oxygen(
                        //         fontSize: 12.sp, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Form(
                            key: _formKey,
                            child: PhoneFormField(
                              autovalidateMode: AutovalidateMode.always,
                              autofillHints: [
                                AutofillHints.telephoneNumber
                              ], // default to null
                              enabled: true, // default
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide:
                                        BorderSide(color: kotgGreen, width: 2)),
                                contentPadding: EdgeInsets.all(10.sp),
                                labelText: 'Phone Number',
                                labelStyle: GoogleFonts.oxygen(
                                    color: kotgGreen,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              onChanged: (phone) => updatePhoneNumber(phone!),
                              defaultCountry: IsoCode.MW,
                              showFlagInInput: true,
                              validator: PhoneValidator.validMobile(),
                              enableInteractiveSelection: true,
                              // initialValue: phoneNumber,
                              countrySelectorNavigator:
                                  CountrySelectorNavigator.bottomSheet(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Text(
                          'Select Payment Method',
                          style: GoogleFonts.oxygen(
                              fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Wrap(
                            runSpacing: 10.sp,
                            spacing: 15.sp,
                            runAlignment: WrapAlignment.spaceAround,
                            children: [
                              Container(
                                width: 90.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                alignment: Alignment
                                    .center, // where to position the child
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 80.0,
                                          height: 80.0,
                                          child: Image(
                                            height: 80,
                                            width: 80,
                                            image: AssetImage(
                                              'assets/images/tnm.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Radio<PaymentOption>(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          value: PaymentOption.Mpamba,
                                          activeColor: kotgPurple,
                                          groupValue: _paymentOption,
                                          onChanged: (value) {
                                            updatePaymentOption(
                                                value as PaymentOption);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 90.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                alignment: Alignment
                                    .center, // where to position the child
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 150.0,
                                          height: 150.0,
                                          child: Image(
                                            height: 150,
                                            width: 150,
                                            image: AssetImage(
                                              'assets/images/Airtel-money.jpg',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Coming Soon',
                                        style: GoogleFonts.oxygen(
                                            fontSize: 8.sp,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Radio<PaymentOption>(
                                      //     materialTapTargetSize:
                                      //         MaterialTapTargetSize.padded,
                                      //     value: PaymentOption.AirtelMoney,
                                      //     activeColor: kotgPurple,
                                      //     groupValue: _paymentOption,
                                      //     onChanged: (value) {
                                      //       updatePaymentOption(
                                      //           value as PaymentOption);
                                      //     }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Total',
                    //       style: GoogleFonts.oxygen(
                    //           fontSize: 14.sp, fontWeight: FontWeight.bold),
                    //     ),
                    //     Spacer(),
                    //     Text(
                    //       'MWK',
                    //       style: GoogleFonts.oxygen(
                    //           fontSize: 7.sp, fontWeight: FontWeight.bold),
                    //     ),
                    //     Text(
                    //       "200",
                    //       style: GoogleFonts.oxygen(
                    //           fontSize: 17.sp, fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enableFeedback: true,
                            primary: kotgBlack,
                            backgroundColor: kotgGreen),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            _repo
                                .ticketPay(
                                    reference: ticketRef,
                                    phoneNumber: _phoneNumber)
                                .then((value) {
                              context.push('/payment-approval');
                              context.loaderOverlay.hide();
                            }).onError((error, stackTrace) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(error.toString()),
                              ));
                              context.loaderOverlay.hide();
                            });
                          }
                        },
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Pay",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ))
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
