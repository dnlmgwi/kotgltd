// import 'package:cool_alert/cool_alert.dart';
// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
// import 'package:dispose/Model/account.dart';
// import 'package:dispose/Model/wallet.dart';
// import 'package:dispose/Services/account_services.dart';
// import 'package:dispose/View/mePage.dart';
// import 'package:dispose/View/wallet/widgets/loadingBalanceWidget.dart';
// import 'package:dispose/View/wallet/widgets/loadingTransactionWidget.dart';
// import 'package:dispose/View/wallet/widgets/transactionHistoryListWidget.dart';
// import 'package:dispose/View/wallet/widgets/transferWidget.dart';
// import 'package:dispose/packages.dart';
// import 'package:dispose/providers/auth_providers.dart';
// import 'package:dispose/providers/emailpassword_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shimmer/shimmer.dart';

// class WalletPage extends StatelessWidget {
//   const WalletPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final _account = context.read(authProvider);

//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: size.width,
//           height: size.height,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, top: 18, bottom: 20),
//                 child: Text(
//                   'Balance',
//                   style: GoogleFonts.sarala(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 26,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               Consumer(builder: (context, watch, _) {
//                 final _account = watch(accountProvider);
//                 return FutureBuilder(
//                     // Initialize FlutterFire:
//                     future: _account.fetchWalletBalance(),
//                     builder: (context, snapshot) {
//                       // Check for errors
//                       if (snapshot.hasError) {
//                         return Container(
//                           height: 130,
//                           child: Center(
//                             child: Text('Error'), //TODO Error Icon
//                           ),
//                         );
//                       }
//                       // Once complete, show your application
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         return Container(
//                           height: 120,
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '${(snapshot.data as Wallet).balance.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
//                                   style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 50,
//                                       color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(4)),
//                             color: Colors.grey[100],
//                           ),
//                         );
//                       }
//                       // Otherwise, show something whilst waiting for initialization to complete
//                       return Container(
//                         height: 120,
//                         child: Center(child: LoadingBalanceWidget()),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(4)),
//                           color: Colors.grey[100],
//                         ),
//                       );
//                     });
//               }),
//               Divider(),
//               Consumer(
//                 builder: (context, watch, _) {
//                   // final _amount = watch(amountProvider).state;
//                   // final _recipeint = watch(recipeintProvider).state;
//                   final _account = watch(accountProvider);

//                   return Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           CoolAlert.show(
//                             context: context,
//                             type: CoolAlertType.custom,
//                             widget: Container(
//                               child: QrImage(
//                                 data: _account.account.get(0)!.id,
//                                 version: QrVersions.auto,
//                                 size: 230.0,
//                               ),
//                             ),
//                             title: 'Your Unique ID',
//                           );
//                         },
//                         icon: Icon(Ionicons.qr_code_outline),
//                         enableFeedback: true,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           showModalBottomSheet(
//                               context: context,
//                               builder: (BuildContext context) =>
//                                   TransferWidget());
//                         },
//                         icon: Icon(Ionicons.cash_outline),
//                         enableFeedback: true,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _account.shareAccount();
//                         },
//                         icon: Icon(Ionicons.share_outline),
//                         enableFeedback: true,
//                       )
//                     ],
//                   );
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, top: 18, bottom: 20),
//                 child: Text(
//                   'Transactions',
//                   style: GoogleFonts.sarala(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               Consumer(builder: (context, watch, _) {
//                 final _account = watch(accountProvider);
//                 return FutureBuilder(
//                   future: _account.fetchTransactions(),
//                   builder: (context, snapshot) {
//                     // Check for errors
//                     if (snapshot.hasError) {
//                       return Center(
//                         child: Container(
//                           child: Text('Error'),
//                         ),
//                       );
//                     }
//                     // Once complete, show your application
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       var data = snapshot.data as List;

//                       if (data.isEmpty) {
//                         return Center(
//                           child: Container(
//                             child: Text('Error'),
//                           ),
//                         );
//                       }
//                       return Padding(
//                         padding: const EdgeInsets.only(left: 10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: MediaQuery.of(context).size.height / 2,
//                               child: ListView.builder(
//                                 itemCount: data.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return TransactionHistoryListWidget(
//                                       data: data, index: index);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     // Otherwise, show something whilst waiting for initialization to complete
//                     return LoadingTransactionWidget();
//                   },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
