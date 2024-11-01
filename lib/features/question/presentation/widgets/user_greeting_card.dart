import 'package:flutter/material.dart';

class UserGreetingCard extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const UserGreetingCard({
    Key? key,
    required this.userName,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(avatarUrl),
          // You can use AssetImage('assets/images/avatar.png') for a local image
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              userName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            // Additional greeting message can be added here if needed
          ],
        ),
      ],
    );
  }
}
