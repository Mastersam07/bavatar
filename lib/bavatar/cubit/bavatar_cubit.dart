import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:bavatar/bavatar/models/bavatars_list.dart';
import 'package:bavatar_repository/bavatar_repository.dart'
    show BavatarRepository;

part 'bavatar_cubit.g.dart';
part 'bavatar_state.dart';

class BavatarCubit extends Cubit<BavatarState> {
  BavatarCubit(this._bavatarRepository) : super(const BavatarState());

  final BavatarRepository _bavatarRepository;

  Future<void> fetchBavatars() async {
    emit(state.copyWith(status: BavatarStatus.loading));

    try {
      final bavatarsList = BavatarsList.fromRepository(
        await _bavatarRepository.getBavatars(),
      );

      emit(
        state.copyWith(
          status: BavatarStatus.success,
          bavatarsList: bavatarsList,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: BavatarStatus.failure));
    }
  }

  Future<void> refreshBavatars() async {
    if (!state.status.isSuccess) return;
    if (state.bavatarsList == BavatarsList.empty) return;

    try {
      final bavatarsList = BavatarsList.fromRepository(
        await _bavatarRepository.getBavatars(),
      );

      emit(
        state.copyWith(
          status: BavatarStatus.success,
          bavatarsList: bavatarsList,
        ),
      );
    } on Exception {
      emit(state);
    }
  }

  @override
  BavatarState fromJson(Map<String, dynamic> json) =>
      BavatarState.fromJson(json);

  @override
  Map<String, dynamic> toJson(BavatarState state) => state.toJson();
}
