import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_services.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp();
	runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
	const TaskManagerApp({super.key});

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider<AuthService>(
			create: (_) => AuthService(),
			child: Consumer<AuthService>(
				builder: (context, auth, _) {
					return MaterialApp(
						debugShowCheckedModeBanner: false,
						title: 'Task Manager',
						theme: ThemeData(primarySwatch: Colors.indigo),
						home: auth.currentUser == null ? const LoginPage() : const HomePage(),
					);
				},
			),
		);
	}
}