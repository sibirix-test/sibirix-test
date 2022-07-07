part of 'feed_provider.dart';

class _FeedNetwork extends NetworkBase {
  Future<List<FweetModel>> getFeeds() async {
    final ans = await dio.get('/fweets');

    return (ans.data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .map((v) => FweetModel.fromJson(v))
        .toList();
  }
}
