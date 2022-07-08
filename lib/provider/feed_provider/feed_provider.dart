import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fwitter/models/fweet/fweet_model.dart';
import 'package:fwitter/provider/stat_providers/stat_providers.dart';
import 'package:fwitter/utils/network_base.dart';

part '_feed_network.dart';

final feedProvider = FutureProvider<List<FweetModel>>((ref) async {
  await ref.read(statProvider.future);
  return await _FeedNetwork().getFeeds();
});
