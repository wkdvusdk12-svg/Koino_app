import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/features/post/domain/models/post_model.dart';
import 'package:uuid/uuid.dart';

class PostNotifier extends Notifier<List<Post>> {
  @override
  List<Post> build() {
    return [
      Post(
        id: '1',
        title: '오늘의 말씀',
        content: '"내게 능력 주시는 자 안에서\n내가 모든 것을 할 수 있느니라”\n빌립보서 4:13',
        imageUrl: 'https://cdn.pixabay.com/photo/2022/11/05/19/56/bachalpsee-7572681_1280.jpg',
        authorName: '크리스천1',
        authorAvatar: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0_XPfyUZJugz5lXkm0DUtAkpjRw367tcFig&s',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Post(
        id: '2',
        title: '감사한 하루',
        content: '오늘 하루도 무사히 보낼 수 있음에 감사합니다. 작은 일에도 감사하는 마음을 가지려 노력했습니다.',
        imageUrl: 'https://cdn.pixabay.com/photo/2016/11/14/04/45/elephant-1822636_1280.jpg',
        authorName: '믿음이',
        authorAvatar: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Post(
        id: '3',
        title: '기도 제목 나눔',
        content: '가족의 건강을 위해 함께 기도해주세요. 특히 환절기라 부모님 건강이 걱정됩니다.',
        imageUrl: 'https://cdn.pixabay.com/photo/2017/08/06/23/22/people-2596013_1280.jpg',
        authorName: '소망이',
        authorAvatar: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Post(
        id: '4',
        title: '주일 예배 후기',
        content: '오늘 목사님 설교 말씀이 너무 좋았습니다. 사랑과 용서에 대해 다시 한번 생각해보게 되었습니다.',
        imageUrl: 'https://cdn.pixabay.com/photo/2016/11/21/15/38/beach-1846009_1280.jpg',
        authorName: '사랑이',
        authorAvatar: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Post(
        id: '5',
        title: '묵상 노트',
        content: '시편 23편을 묵상하며... 여호와는 나의 목자시니 내게 부족함이 없으리로다.',
        imageUrl: 'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg',
        authorName: '은혜',
        authorAvatar: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  void addPost(String title, String content, String imageUrl) {
    final newPost = Post(
      id: const Uuid().v4(),
      title: title,
      content: content,
      imageUrl: imageUrl,
      authorName: '나', // Mock current user
      authorAvatar: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      createdAt: DateTime.now(),
    );
    state = [newPost, ...state];
  }

  Post? getPost(String id) {
    try {
      return state.firstWhere((post) => post.id == id);
    } catch (e) {
      return null;
    }
  }
}

final postProvider = NotifierProvider<PostNotifier, List<Post>>(() {
  return PostNotifier();
});
