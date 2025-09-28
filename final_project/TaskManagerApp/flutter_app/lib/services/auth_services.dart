import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
	final FirebaseAuth _auth = FirebaseAuth.instance;

	User? get currentUser => _auth.currentUser;

	AuthService() {
		_auth.userChanges().listen((_) => notifyListeners());
	}

	Future<String?> signIn(String email, String password) async {
		try {
			await _auth.signInWithEmailAndPassword(email: email, password: password);
			return null;
		} on FirebaseAuthException catch (e) {
			return e.message;
		} catch (e) {
			return e.toString();
		}
	}

	Future<String?> signUp(String email, String password) async {
		try {
			await _auth.createUserWithEmailAndPassword(email: email, password: password);
			return null;
		} on FirebaseAuthException catch (e) {
			return e.message;
		} catch (e) {
			return e.toString();
		}
	}

	Future<void> signOut() async {
		await _auth.signOut();
	}
}