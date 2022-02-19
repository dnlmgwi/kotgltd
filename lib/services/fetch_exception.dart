// class NetworkErrorException implements Exception {
//   final message = 'A Network problem';
// }

// class UserNotFoundException implements Exception {
//   UserNotFoundException(this._userID);
//   final int _userID;
//   String get message => 'No user find with this number $_userID';
// }

// class PostNotFoundException implements Exception {
//   PostNotFoundException(this._userID);
//   final int _userID;
//   String get message => 'No post fount of user with id:  $_userID';
// }

// class CommentNotFoundException implements Exception {
//   CommentNotFoundException(this._postID);
//   final int _postID;
//   String get message => 'No comment fount of post with id:  $_postID';
// }

// class AccountDuplicationFoundException implements Exception {
//   ///This Exception is thrown when there is an excisting account in the DB
//   late String _message;

//   AccountDuplicationFoundException(
//       [String message = 'Please, login Instead.']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class RegisteredCredentialsException implements Exception {
//   ///This Exception is thrown when there is an excisting account in the DB
//   late String _message;

//   RegisteredCredentialsException(
//       [String message = 'These Details are Registered, Login instead']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class InvalidUsernameException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the DB
//   late String _message;

//   InvalidUsernameException(
//       [String message = 'Please provide a valid Username']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class InvalidEmailException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the DB
//   late String _message;

//   InvalidEmailException(
//       [String message = 'Please provide a valid Email Address']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class UnauthorisedException implements Exception {
//   ///This Exception is thrown when there is an excisting account in the DB
//   late String _message;

//   UnauthorisedException(
//       [String message = 'Not authorised to perform this request']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class RecentTransException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the DB
//   late String _message;

//   RecentTransException([String message = 'You made a recent transaction: ']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class InvalidAmountException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the request
//   late String _message;

//   InvalidAmountException(
//       [String message = 'Please provide the amount key {amount: value}']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class InsufficientFundsException implements Exception {
//   ///This Exception is thrown when there is Insufficient Funds in the account
//   late String _message;

//   InsufficientFundsException([String message = 'Insufficient funds']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class PendingTransactionException implements Exception {
//   ///This Exception is thrown when the account has a pending transaction
//   late String _message;

//   PendingTransactionException(
//       [String message = 'Please await your pending transaction']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }

// class AccountNotFoundException implements Exception {
//   ///This Exception is thrown when the account cannot be Found in the DB
//   late String _message;

//   AccountNotFoundException([String message = 'Account Not Found']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }
