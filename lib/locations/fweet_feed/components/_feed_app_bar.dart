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
          onPressed: () {},
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
              data: (v) => Padding(
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
                                'Всего вы лайнули постов: ${v.keys.length}',
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
                          v.keys.length.toString(),
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

  @override
  Size get preferredSize => const Size(double.infinity, 55);
}
