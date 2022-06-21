class NoProfileException implements Exception {
  ///This Exception is thrown when there is an invalid Input Entered in the DB
  late String _message;

  NoProfileException([String message = 'No Profile Found']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

class NoConnectionException implements Exception {
  ///This Exception is thrown when there is an invalid Input Entered in the DB
  late String _message;

  NoConnectionException([String message = 'No Connection Found']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

class AuthError implements Exception {
  ///This Exception is thrown when there is an invalid Input Entered in the DB
  late String _message;

  AuthError([String message = 'Details Have Been Registered']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

// class NetworkErrorException implements Exception {
//   final message = 'A Network problem';
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

// class InvalidIdException implements Exception {
//   ///This Exception is thrown when there is an invalid Input Entered in the DB
//   late String _message;

//   InvalidIdException([String message = 'Please provide a valid ID']) {
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }
