part of '../fweet_feed_screen.dart';

class _EmojiReactionsBottomSheet extends ConsumerWidget {
  final FweetModel fweet;
  const _EmojiReactionsBottomSheet(
    this.fweet, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fweetUserReactions = ref.watch(statByFweetIdProvider(fweet.id));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Реакция на фвит #${fweet.id} пользователя @${fweet.creator.nickname}',
            style: Theme.of(context).textTheme.button,
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
                        fweetUserReactions == null ||
                                fweetUserReactions != entry.id
                            ? ref.read(statProvider.notifier).fweetReaction(
                                fweetId: fweet.id, emojiId: entry.id)
                            : ref
                                .read(statProvider.notifier)
                                .deleteReaction(fweetId: fweet.id);

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
