import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.notifications),
            ),
            title: Text('사용자$index님이 회원님의 글에 좋아요를 눌렀습니다.'),
            subtitle: Text('${index + 1}시간 전'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
