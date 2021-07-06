import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BavatarLoading extends StatelessWidget {
  const BavatarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
