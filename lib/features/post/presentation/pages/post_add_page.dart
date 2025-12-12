import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_practice/features/post/provider/post_provider.dart';

class PostAddPage extends ConsumerStatefulWidget {
  const PostAddPage({super.key});

  @override
  ConsumerState<PostAddPage> createState() => _PostAddPageState();
}

class _PostAddPageState extends ConsumerState<PostAddPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _selectedImageUrl;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onAddImage() {
    setState(() {
      // Mock image selection
      _selectedImageUrl = 'https://cdn.pixabay.com/photo/2023/08/26/17/49/flower-8215548_1280.jpg';
    });
  }

  void _onSubmit() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목과 내용을 입력해주세요.')),
      );
      return;
    }

    ref.read(postProvider.notifier).addPost(
          _titleController.text,
          _contentController.text,
          _selectedImageUrl ?? 'https://cdn.pixabay.com/photo/2023/08/26/17/49/flower-8215548_1280.jpg', // Default image if none selected
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 등록'),
        actions: [
          TextButton(
            onPressed: _onSubmit,
            child: const Text(
              '완료',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _onAddImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: _selectedImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(_selectedImageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _selectedImageUrl == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('사진을 선택해주세요', style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                hintText: '제목을 입력해주세요',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: '내용을 입력해주세요',
                border: InputBorder.none,
              ),
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
