import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromFirebaseAuthException(FirebaseException exception) {
    switch (exception.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return ServerFailure("Email already used");

      case "account-exists-with-different-credential":
        return ServerFailure("Email already used");

      case "email-already-in-use":
        return ServerFailure("Email already used");

      case "invalid-email":
        return ServerFailure("The Email address is not valid");
      case "ERROR_WRONG_PASSWORD":
        return ServerFailure("Wrong Password");
      case "user-not-found":
        return ServerFailure("No user corresponding to the given email");
      case "wrong-password":
        return ServerFailure("Wrong password");
      case "weak-password":
        return ServerFailure("The password provided is too weak");
      default:
        return ServerFailure("Failed , Please try again");
    }
  }
}