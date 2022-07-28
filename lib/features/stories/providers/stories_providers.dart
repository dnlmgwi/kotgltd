import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kotgltd/features/stories/services/stories_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';

final storiesRepoProvider = Provider(
  (ref) => StoriesRepository(),
);

final postsProvider = FutureProvider<List>((ref) async {
  final client = ref.watch(storiesRepoProvider);
  return client.fetchPosts();
});

final postProvider = FutureProvider.family.autoDispose((ref, String postId) async {
  final client = ref.watch(storiesRepoProvider);
  return client.fetchPost(id: postId);
});
