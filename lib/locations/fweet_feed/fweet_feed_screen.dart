import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fwitter/models/fweet/fweet_model.dart';
import 'package:fwitter/provider/feed_provider/feed_provider.dart';
import 'package:fwitter/provider/stat_providers/stat_providers.dart';
import 'package:fwitter/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

part 'components/_fweet_card.dart';
part 'components/_emoji_reactions_bottom_sheet.dart';
part 'components/_feed_app_bar.dart';

class FweetFeedScreen extends ConsumerWidget {
  const FweetFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _FweetFeedAppBar(),
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
                          child: _FweetCard(
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
}
