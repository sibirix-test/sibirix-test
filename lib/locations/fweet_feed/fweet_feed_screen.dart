import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fwitter/models/fweet/fweet_model.dart';
import 'package:fwitter/provider/feed_provider/feed_provider.dart';
import 'package:fwitter/utils/app_colors.dart';
import 'package:intl/intl.dart';

class FweetFeedScreen extends ConsumerWidget {
  const FweetFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context, height: 50),
      body: ref.watch(feedProvider).maybeWhen(
            orElse: () => ListView(
              children: List.generate(
                10,
                (_) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CardLoading(
                    height: 100,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                ),
              ),
            ),
            data: (feed) => AnimationLimiter(
              child: ListView.builder(
                itemCount: feed.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FweetCard(
                            feed[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
    );
  }

  PreferredSize _buildAppBar(
    BuildContext context, {
    required double height,
  }) =>
      PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: [
            Container(
              color: AppColors.secondary,
              child: const Center(
                child: Text(
                  "...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 100.0,
              child: Container(
                decoration: const ShapeDecoration(
                  color: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                ),
                // Background
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    child: Icon(FontAwesomeIcons.house),
                    radius: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class FweetCard extends ConsumerWidget {
  final FweetModel fweet;
  const FweetCard(this.fweet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      shadowColor: AppColors.primary.withOpacity(0.1),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24).copyWith(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              // TODO Add CachedImageNetwork with error builder
              backgroundImage: NetworkImage(
                fweet.creator.avatar ?? '',
              ),
              radius: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(fweet.creator.name),
                      Text(
                        '@' + fweet.creator.nickname,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(fweet.text),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat.MMMMd('ru_RU').format(fweet.createdAt),
                      ),
                      const SizedBox(width: 16),
                      ...fweet.emojis
                          // .where((element) => element.count != 0)
                          .map(
                        (v) => IconButton(
                          icon: Text(v.emoji),
                          // icon: const FaIcon(FontAwesomeIcons.heart),
                          iconSize: 18,
                          splashRadius: 24,
                          onPressed: () {
                            ref
                                .read(feedProvider.notifier)
                                .likePost(fweet.emojis.first.id);
                          },
                        ),
                      ),
                      Text(
                        fweet.emojis
                            .map((v) => v.count)
                            .reduce((sum, v) => sum + v)
                            .toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
