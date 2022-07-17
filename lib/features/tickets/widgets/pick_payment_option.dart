// import 'package:kotgltd/common/color.dart';
// import 'package:kotgltd/features/profile/providers/profile_providers.dart';
// import 'package:kotgltd/packages/dependencies.dart';

// class PaymentOptionPickerItem {
//   AssetImage image;
//   PaymentOption paymentOption;

//   PaymentOptionPickerItem({
//     required this.image,
//     required this.paymentOption,
//   });
// }

// class PickerWidget extends ConsumerWidget {
//   final List<PaymentOptionPickerItem> pickerItems;

//   const PickerWidget({
//     Key? key,
//     required this.pickerItems,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, ref) {
//     final _selectedIndex = ref.watch(selectedPaymentOptionProvider.state).state;

//     void updateSelectedIndex(int selected) {
//       ref.read(selectedPaymentOptionProvider.state).state = selected;
//     }

//     void updatePaymentOption(PaymentOption paymentOption) {
//       ref.read(paymentOptionProvider.state).state = paymentOption;
//     }

//     return ListView.builder(
//       itemBuilder: (context, index) {
//         PaymentOptionPickerItem pickerItem = pickerItems[index];
//         bool isItemSelected = index == _selectedIndex;
//         return Column(
//           children: [
//             InkWell(
//               onTap: () => updateSelectedIndex(index),
//               child: Container(
//                 width: 90.0,
//                 height: 90.0,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 alignment: Alignment.center, // where to position the child
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           width: 80.0,
//                           height: 80.0,
//                           child: Image(
//                             height: 80,
//                             width: 80,
//                             image: pickerItem.image,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Radio<PaymentOption>(
//                           value: pickerItem.paymentOption,
//                           activeColor: kotgPurple,
//                           groupValue: pickerItem.paymentOption,
//                           onChanged: (value) {
//                             updatePaymentOption(value as PaymentOption);
//                           }),
//                     ),
//                   ],
//                 ),
//               ),

//               // Container(
//               //   alignment: Alignment.center,
//               //   margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
//               //   decoration: BoxDecoration(
//               //     // color: Color(0xff04385f),
//               //     border: Border.all(color: kotgPurple),
//               //     borderRadius: BorderRadius.all(Radius.circular(12)),
//               //   ),
//               //   child: Padding(
//               //     padding: const EdgeInsets.all(8.0),
//               //     child: Row(
//               //       children: [
//               //         Container(
//               //           height: 24,
//               //           child: Image.asset('images/cod.png'),
//               //         ),
//               //         SizedBox(width: 4),
//               //         Expanded(
//               //           child: Text(
//               //             pickerItem.label,
//               //             style: TextStyle(
//               //               color: Color(0xff04385f),
//               //               fontFamily: 'UbuntuMedium',
//               //             ),
//               //           ),
//               //         ),
//               //         isItemSelected
//               //             ? Icon(
//               //                 Icons.check_circle,
//               //                 size: 16,
//               //                 color: Colors.green,
//               //               )
//               //             : Container(),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//             ),
//           ],
//         );
//       },
//       itemCount: pickerItems.length,
//     );
//   }
// }
