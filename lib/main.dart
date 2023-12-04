// main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService(apiUrl: 'https://api-jobs-production.up.railway.app');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Usuarios de API'),
        ),
        body: FutureBuilder<List<UserModel>>(
          future: apiService.getUsers(offset: 0, limit: 10),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
