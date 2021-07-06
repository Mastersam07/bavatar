import 'package:bavatar_repository/bavatar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bavatar/bavatar/bavatar.dart';
import 'package:bavatar/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required BavatarRepository bavatarRepository,
  })   : _bavatarRepository = bavatarRepository,
        super(key: key);

  final BavatarRepository _bavatarRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _bavatarRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const BavatarPage(),
      ),
    );
  }
}
