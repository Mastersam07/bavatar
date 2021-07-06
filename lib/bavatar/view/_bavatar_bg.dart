part of 'bavatar_page.dart';

class _BavatarBg extends StatelessWidget {
  const _BavatarBg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.07,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: ExactAssetImage(
            'assets/noise_bg.jpeg',
          ),
        )),
      ),
    );
  }
}
