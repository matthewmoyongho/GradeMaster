import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

import 'models/models.dart';

class SignUpWithEmailAndPasswordError implements Exception {
  final String message;
  const SignUpWithEmailAndPasswordError(
      [this.message = 'An unknown error occurred. Please try again!']);

  factory SignUpWithEmailAndPasswordError.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordError(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordError(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordError(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordError(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordError(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordError();
    }
  }
}

class LogInWithEmailAndPasswordError implements Exception {
  final String message;
  const LogInWithEmailAndPasswordError(
      [this.message = 'An unknown error occurred. Please try again']);
  factory LogInWithEmailAndPasswordError.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordError(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordError(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordError(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordError(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordError();
    }
  }
}

class LogInWithGoogleError implements Exception {
  final String errorMessage;
  const LogInWithGoogleError(
      [this.errorMessage = 'An unknown exception occurred']);
  factory LogInWithGoogleError.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleError(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleError(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleError(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleError(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleError(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleError(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleError(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleError(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleError();
    }
  }
}

class LogOutError implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final CacheClient _cacheClient;

  AuthenticationRepository({
    GoogleSignIn? googleSignIn,
    CacheClient? cacheClient,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _cacheClient = cacheClient ?? CacheClient(),
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  bool isWeb = kIsWeb;

  //
  //@visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final User user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cacheClient.write(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return _cacheClient.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<firebase_auth.User?> signUp(String email, String password) async {
    firebase_auth.User? fbUser;
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      fbUser = result.user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordError.fromCode(e.code);
    } catch (_) {
      throw SignUpWithEmailAndPasswordError();
    }
    return fbUser;
  }

  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordError.fromCode(e.code);
    } catch (_) {
      throw LogInWithEmailAndPasswordError();
    }
  }

  Future<firebase_auth.User?> googleLogin() async {
    firebase_auth.User? userDetail;
    try {
      late final firebase_auth.AuthCredential authCredential;
      if (kIsWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredentials =
            await _firebaseAuth.signInWithPopup(googleProvider);
        authCredential = userCredentials.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        authCredential = firebase_auth.GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      }
      final user = await _firebaseAuth.signInWithCredential(authCredential);
      userDetail = user.user!;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleError.fromCode(e.code);
    } catch (_) {
      throw LogInWithGoogleError();
    }
    return userDetail;
  }

  Future<void> logOut() async {
    try {
      Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutError();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw 'An unknown error occurred! Please check email and try again';
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email, photoUrl: photoURL);
  }
}
