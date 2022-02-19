// import 'package:hive_flutter/adapters.dart';
// import 'package:kotgltd/model/user.dart';
// import 'package:kotgltd/model/account.dart';
// import 'package:kotgltd/model/tokenPair.dart';
// import 'package:kotgltd/model/wallet.dart';
// import 'package:kotgltd/Services/user_repository.dart';
// import 'package:kotgltd/Services/fetch_exception.dart';
// import 'package:kotgltd/Services/sms_parser.dart';

// import 'package:kotgltd/providers/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:telephony/telephony.dart';

// class AccountService extends ChangeNotifier {
//   final UserRepository _perrowApi;
//   final telephony = Telephony.instance;
//   final _smsParsers = SMSParsers();

//   AccountService(
//     this._perrowApi,
//   );

//   final tokens = Hive.box<TokenPair>('tokens');
//   final account = Hive.box<Account>('account');

//   Future shareAccount() async {
//     Account getAccount = Account(jwt: '',user: User(id: id, email: email, username: username));

//     try {
//       getAccount = account.getAt(0)!;
//     } catch (e) {
//       // _authStateNotifier.refresh();
//       print(e);
//     }
//     return Share.share(getAccount.id);
//   }

//   // Platform texts are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // Platform texts may fail, so we use a try/catch PlatformException.
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//   }

//   Future getVirtualCard() async {
//     List<SmsMessage> _texts = [];
//     List _validTexts = [];
//     if (await Permission.sms.request().isGranted) {
//       _texts = await telephony.getInboxSms(
//           columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE],
//           filter: SmsFilter.where(SmsColumn.ADDRESS).equals("MPAMBA"),
//           // .and(SmsColumn.BODY).like(RegExp(r'$cvv').toString()),
//           sortOrder: [
//             OrderBy(SmsColumn.DATE, sort: Sort.ASC),
//           ]);

//       _texts.forEach((element) {
//         print(_smsParsers.parsedNotification(element.body));
//       });
//     }

//     return _validTexts;
//   }

//   Future<Wallet> fetchWalletBalance() async {
//     Wallet? response;
//     try {
//       TokenPair gettoken = tokens.getAt(0)!;

//       response = await _perrowApi.getUserWallet(gettoken.token);
//     } on UnauthorisedException catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//     }
//     return response!;
//   }

//   // Future<Account> fetchAccount() async {
//   //   Account getAccount = Account(id: '', email: '', createdAt: '');
//   //   try {
//   //     getAccount = account.getAt(0)!;
//   //   } catch (e) {
//   //     // _authStateNotifier.refresh();
//   //     print(e);
//   //   }
//   //   return getAccount;
//   // }

//   Future transferAmount(
//       {required String recipientID, required int amount}) async {
//     var response;
//     try {
//       response = await _perrowApi.transfer(
//         amount: amount,
//         recipientID: recipientID,
//       );
//       print(response); //Show User
//     } catch (e) {
//       rethrow;
//     }
//     return response!;
//   }

//   Future<List> fetchTransactions() async {
//     List response = [];
//     try {
//       TokenPair? gettoken = tokens.getAt(0)!;
//       response = await _perrowApi.getUserTransactions(gettoken.token);
//       return response;
//     } catch (e) {}
//     return response;
//   }
// }
