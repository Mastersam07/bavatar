// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:ui';

import 'package:bavatar/bavatar/widgets/widgets.dart';
import 'package:bavatar_repository/bavatar_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bavatar/bavatar/bavatar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

part '_bavatar_bg.dart';
part '_bavatar_title.dart';
part '_bavatar_ui.dart';

class BavatarPage extends StatelessWidget {
  const BavatarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BavatarCubit(
        context.read<BavatarRepository>(),
      ),
      child: const BavatarView(),
    );
  }
}

class BavatarView extends StatefulWidget {
  const BavatarView({Key? key}) : super(key: key);

  @override
  _BavatarViewState createState() => _BavatarViewState();
}

class _BavatarViewState extends State<BavatarView> {
  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff0c0e17),
      child: Stack(
        children: const [
          _BavatarBg(key: Key('_BavatarBg')),
          _BavatarUI(key: Key('_BavatarUI')),
          _BavatarTitle(key: Key('_BavatarTitle')),
        ],
      ),
    );
  }

  void load() async {
    await context.read<BavatarCubit>().fetchBavatars();
  }
}
