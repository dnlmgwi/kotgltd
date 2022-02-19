// class NotNumberException implements Exception {
//   final message = 'The entered value is not a number';
// }

// class NotInRangeException implements Exception {
//   final message = 'The entered value is not between 1 and 10';
// }

// class NullNumberException implements Exception {
//   final message = 'The entered value is null';
// }

// class TransIDNotFoundException implements Exception {
//   ///This Exception is thrown when the account cannot be Found in the DB
//   late String _message;

//   TransIDNotFoundException([String message = 'Invalid TransID']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class TransIDClaimedException implements Exception {
//   ///This Exception is thrown when the account cannot be Found in the DB
//   late String _message;

//   TransIDClaimedException(
//       [String message = 'TransID has already been claimed']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class IncorrectInputException implements Exception {
//   ///This Exception is thrown when there is an excisting account in the DB
//   late String _message;

//   IncorrectInputException([String message = 'Incorrect User id or Pin']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class InvalidInputException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the DB
//   late String _message;

//   InvalidInputException([String message = 'Please provide a valid Input']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class InvalidUserIDException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the DB
//   late String _message;

//   InvalidUserIDException(
//       [String message = 'Please provide the id key {id: uuid}']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class SelfTransferException implements Exception {
//   ///This Exception is thrown when the account has a pending transaction
//   late String _message;

//   SelfTransferException(
//       [String message =
//           'Please provided a different accounts to preform a transfer']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class NoPendingTransactionException implements Exception {
//   ///This Exception is thrown when there is an excisting account in the DB
//   late String _message;

//   NoPendingTransactionException([String message = 'Nothing to Mine']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class InvalidPasswordException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the DB
//   late String _message;

//   InvalidPasswordException(
//       [String message = 'Please provide a valid Password']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }
