part of '../fweet_feed_screen.dart';

class _EmojiReactionsBottomSheet extends ConsumerWidget {
  final FweetModel fweet;
  const _EmojiReactionsBottomSheet(
    this.fweet, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// the user's reaction to the post,
    /// which is stored locally in the hive box
    final fweetUserReactions = ref.watch(statByFweetIdProvider(fweet.id));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16).copyWith(bottom: 6),
          child: Text(
            'Реакция на фвит #${fweet.id} пользователя @${fweet.creator.nickname}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Wrap(
          children: fweet.emojis
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: fweetUserReactions == entry.id
                        ? AppColors.primary.withOpacity(0.4)
                        : Colors.transparent,
                    child: IconButton(
                      icon: Text(
                        entry.emoji,
                        style: const TextStyle(fontSize: 25),
                      ),
                      splashRadius: 24,
                      onPressed: () {
                        /// if the user did not leave a reaction earlier - add entry to the database
                        ///
                        /// if user left a reaction to another emoji - remove the old emoji and add a new one
                        ///
                        /// if user tap on the same emoji - remove it from the database
                        fweetUserReactions == null ||
                                fweetUserReactions != entry.id
                            ? ref
                                .read(statProvider.notifier)
                                .reactionOnFweetById(
                                  fweet.id,
                                  emojiId: entry.id,
                                )
                            : ref
                                .read(statProvider.notifier)
                                .deleteReactionByFweetId(fweet.id);

                        ref.refresh(statProvider);
                      },
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
