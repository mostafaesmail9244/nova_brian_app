import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:nova_brian_app/core/constants/firebase_constnats.dart';
import 'package:nova_brian_app/features/auth/data/models/login/login_request_model.dart';
import 'package:nova_brian_app/features/auth/data/models/sign_up/sign_up_request_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Either<String, UserCredential>> signIn(
      {required LoginRequestBody body}) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: body.email, password: body.password);
      return right(user);
    } on FirebaseAuthException catch (e) {
      String? message;

      if (e.code == 'invalid-email') {
        message = 'Not user found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Email or password is incorrect';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests, please try again later';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password';
      } else if (e.code == 'CONFIGURATION_NOT_FOUND') {
        message = 'Not user found for that email';
      } else if (e.code == 'user-not-found') {
        message = 'Not user found for that email';
      }
      Logger().e('firebase code ${e.code}');
      Logger().e('firebase error ${e..message}');

      return Left(message ?? e.code);
    }
  }

  Future<Either<String, UserCredential>> signUp(
      {required SignupRequestBody body}) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: body.email, password: body.password);
      Map<String, String> userMap = {
        "id": user.user!.uid,
        "name": body.name,
        "email": body.email,
      };
      CollectionReference userColl = FirebaseFirestore.instance
          .collection(FireBaseConstants.usersCollection);
      await userColl.doc(user.user!.uid).set(userMap);
      return right(user);
    } on FirebaseAuthException catch (e) {
      String? message;

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests, please try again later';
      }
      Logger().e('firebase error code ${e.code}');
      Logger().e('firebase error massage ${e.message}');
      return Left(message ?? e.code);
    }
  }

  Future<Either<String, String>> forgetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return right("Password Reset Email Sent");
    } on FirebaseAuthException catch (e) {
      Logger().e('Firebase error code ${e.code} : ${e.message}');

      // Handle specific Firebase error codes
      switch (e.code) {
        case 'invalid-email':
          return left("The email address is not valid.");
        case 'user-not-found':
          return left("No user found for that email.");
        case 'too-many-requests':
          return left("Too many requests. Try again later.");
        default:
          return left("An unexpected error occurred. Please try again.");
      }
    } catch (e) {
      Logger().e('Unknown error: $e');
      return left("An unknown error occurred.");
    }
  }
}
