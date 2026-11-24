import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/users.dart';

class UserWidget extends StatelessWidget {
  final Users users;

  const UserWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar dan Nama
            Row(
              children: [
                CircleAvatar(
                  child: Text('${users.id}'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      users.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('@${users.username}'),
                  ],
                ),
              ],
            ),

            const Divider(),

            // Data User
            Text('Email: ${users.email}'),
            Text('Phone: ${users.phone}'),
            Text('Website: ${users.website}'),
            Text('Company: ${users.company.name}'),
            Text('Address: ${users.address.street}, ${users.address.city}'),
          ],
        ),
      ),
    );
  }
}
