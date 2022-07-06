import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fwitter/models/fweet/fweet_model.dart';
import 'package:fwitter/utils/network_base.dart';

part '_feed_network.dart';

final feedProvider =
    StateNotifierProvider<FeedNotifier, AsyncValue<List<FweetModel>>>(
  (ref) => FeedNotifier(ref),
);

class FeedNotifier extends StateNotifier<AsyncValue<List<FweetModel>>> {
  final StateNotifierProviderRef ref;

  FeedNotifier(this.ref) : super(const AsyncValue.loading()) {
    _fetchFeedData();
  }

  Future<void> _fetchFeedData() async {
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 1200));
      return await _FeedNetwork().getFeeds();
    });
  }

  Future<void> update() async {
    state = await AsyncValue.guard(() async {
      return await _FeedNetwork().getFeeds();
    });
  }
}
