import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_practice/features/home/presentation/pages/home_page.dart';
import 'package:riverpod_practice/features/post/provider/post_provider.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);
    final myPosts = posts.where((post) => post.authorName == '나').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '나',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  '안녕하세요! 반갑습니다.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    context.push('/mypage/edit');
                  },
                  child: const Text('프로필 수정'),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '내가 쓴 글',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // My Posts List
          Expanded(
            child: myPosts.isEmpty
                ? const Center(child: Text('작성한 글이 없습니다.'))
                : ListView.builder(
                    itemCount: myPosts.length,
                    itemBuilder: (context, index) {
                      return PostItem(post: myPosts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
