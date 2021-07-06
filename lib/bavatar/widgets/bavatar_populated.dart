import 'dart:ui';

import 'package:bavatar/bavatar/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BavatarPopulated extends StatelessWidget {
  const BavatarPopulated({
    Key? key,
    required this.bavatarsList,
    this.onRefresh,
  }) : super(key: key);

  final BavatarsList bavatarsList;
  final ValueGetter<Future<void>>? onRefresh;

  List<Bavatar> get bavatars => bavatarsList.bavatars;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const widthCard = 120;
    final countRow = width ~/ widthCard;

    return GridView.builder(
      padding: const EdgeInsets.only(
        top: 60,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: countRow,
        mainAxisSpacing: 5
      ),
      itemCount: bavatars.length,
      itemBuilder: (BuildContext context, int i) {
        final item = bavatars[i];
        return _BavatarItem(bavatar: item);
      },
    );
  }
}

class _BavatarItem extends StatelessWidget {
  const _BavatarItem({
    Key? key,
    required this.bavatar,
  }) : super(key: key);

  final Bavatar bavatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.pink.withOpacity(0.09),
            child: CachedNetworkImage(
              imageUrl: bavatar.url,
              progressIndicatorBuilder: (context, url, _) =>
                  const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: Colors.white38,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
