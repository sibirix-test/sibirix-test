import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fwitter/models/fweet/fweet_model.dart';
import 'package:fwitter/provider/stat_providers/stat_providers.dart';
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
      await ref.read(statProvider.future);
      return await _FeedNetwork().getFeeds();
    });
  }
}
