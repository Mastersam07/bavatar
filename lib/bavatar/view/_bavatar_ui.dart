part of 'bavatar_page.dart';

class _BavatarUI extends StatelessWidget {
  const _BavatarUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0c0e17),
            Colors.transparent,
          ],
          stops: [0.0, 0.4], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: BlocConsumer<BavatarCubit, BavatarState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case BavatarStatus.initial:
              return const BavatarEmpty();
            case BavatarStatus.loading:
              return const BavatarLoading();
            case BavatarStatus.success:
              return BavatarPopulated(
                bavatarsList: state.bavatarsList,
                onRefresh: () => context.read<BavatarCubit>().refreshBavatars(),
              );
            case BavatarStatus.failure:
            default:
              return const BavatarError();
          }
        },
      ),
    );
  }
}
