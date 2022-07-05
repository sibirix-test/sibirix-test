import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fwitter/models/fweet/fweet_model.dart';
import 'package:fwitter/utils/network_base.dart';

part '_feed_network.dart';

final feedProvider = FutureProvider(
  (ref) async => await _FeedNetwork().getFeeds(),
);
