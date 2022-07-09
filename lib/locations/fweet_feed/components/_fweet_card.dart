part of '../fweet_feed_screen.dart';

class _FweetCard extends ConsumerWidget {
  final FweetModel fweet;
  const _FweetCard(this.fweet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// emojis that come with a post from the api
    final networkFweetReactions = fweet.emojis.map((v) => v.count).reduce(
          (sum, v) => sum + v,
        );

    /// has the user reacted to the post before
    final isUserReactOnFweet =
        ref.watch(statByFweetIdProvider(fweet.id)) != null;

    /// the emoji that the user selected
    final userReaction = isUserReactOnFweet
        ? fweet.emojis
            .firstWhere(
                (v) => v.id == ref.watch(statByFweetIdProvider(fweet.id)))
            .emoji
        : null;

    /// full fweet reactions statistics
    final emojisCount = networkFweetReactions + (isUserReactOnFweet ? 1 : 0);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      shadowColor: AppColors.primary.withOpacity(0.1),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12).copyWith(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
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
                      const SizedBox(width: 6),
                      Text(
                        '@' + fweet.creator.nickname,
                        style: Theme.of(context).textTheme.caption,
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
                      TextButton.icon(
                        icon: isUserReactOnFweet
                            ? SizedBox(
                                width: 25,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      right: 2,
                                      child: Text(
                                        userReaction!,
                                        style: const TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color:
                                          AppColors.primary.withOpacity(0.95),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              )
                            : const FaIcon(
                                FontAwesomeIcons.heart,
                                color: AppColors.secondary,
                                size: 18,
                              ),
                        label: Text(
                          emojisCount.toString(),
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (ctx) => _EmojiReactionsBottomSheet(fweet),
                        ),
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
