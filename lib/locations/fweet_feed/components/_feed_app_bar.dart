part of '../fweet_feed_screen.dart';

class _FweetFeedAppBar extends ConsumerWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: Center(
        child: IconButton(
          splashRadius: 30,
          icon: const FaIcon(
            FontAwesomeIcons.circleQuestion,
            color: AppColors.secondary,
          ),
          onPressed: () => _showHelpDialog(context),
        ),
      ),
      title: Image.asset(
        'assets/images/logo.png',
        height: 40,
      ),
      centerTitle: true,
      actions: [
        ref.watch(statProvider).maybeWhen(
              orElse: () => const SizedBox.shrink(),
              data: (statBox) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Stack(
                    children: [
                      IconButton(
                        splashRadius: 30,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              content: Text(
                                'Всего вы лайкнули постов: ${statBox.keys.length}'
                                '\n\n\n'
                                'id постов (statBox.keys): ${statBox.keys.join(', ')}'
                                '\n\n'
                                'id emoji (statBox.values): ${statBox.values.join(', ')}',
                              ),
                            ),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.heart,
                          color: AppColors.secondary,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 2,
                        child: Text(
                          statBox.keys.length.toString(),
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    const content = '''
    1. Фвиты подгружаются из мокового api.
    2. По клику на фвит всплывает bottom sheet с эмодзи.
    3. Если кликнули на эмодзи, то у конкретного твита добавляется выбранный смайлик (в bottom sheet'e и в Card).
    Он сохраняется в базу (hive). У фвита инкрементируется счетчик лайков.
    4. Если ранее был выбран эмодзи и выбрали другой - убирается старый эмодзи, отображается выбранный. 
    5. При повторном тапе на ранее активный эмодзи - декремент счетчика фвита и удаление из базы.
    6. После перезагрузки приложения данные не пропадают.
    7. В аппбаре выводится счетчик (сверху справа), показывающий, сколько фвитов имеют эмодзи.
    ''';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Помощь'),
          content: const SingleChildScrollView(
            child: Text(content),
          ),
          contentPadding: const EdgeInsets.all(20).copyWith(bottom: 0),
          actions: [
            ElevatedButton(
              child: const Text('Закрыть'),
              onPressed: () => context.router.pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 55);
}
