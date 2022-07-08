import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// statistics on a specific fweet
final statByFweetIdProvider = StateProvider.family<int?, String>(
  (ref, fweetId) => ref.watch(statProvider).maybeWhen(
        orElse: () => null,
        data: (v) => v.get(fweetId),
      ),
);

/// provider-wrapper over the database with all user reactions
final statProvider = StateNotifierProvider<StatNotifier, AsyncValue<Box<int>>>(
  (ref) => StatNotifier(ref),
);

/// notifier with hive box control functions
class StatNotifier extends StateNotifier<AsyncValue<Box<int>>> {
  final StateNotifierProviderRef ref;

  StatNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initHiveBox();
  }

  Future<void> _initHiveBox() async {
    state = await AsyncValue.guard(() async => await Hive.openBox<int>('stat'));
  }

  Future<void> reactionOnFweetById(
    String fweetId, {
    required int emojiId,
  }) async {
    state.whenData((box) => box.put(fweetId, emojiId));
  }

  Future<void> deleteReactionByFweetId(String fweetId) async =>
      state.whenData((box) => box.delete(fweetId));
}
