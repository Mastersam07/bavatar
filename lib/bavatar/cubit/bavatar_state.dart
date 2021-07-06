part of 'bavatar_cubit.dart';

enum BavatarStatus { initial, loading, success, failure }

extension BavatarStatusX on BavatarStatus {
  bool get isInitial => this == BavatarStatus.initial;
  bool get isLoading => this == BavatarStatus.loading;
  bool get isSuccess => this == BavatarStatus.success;
  bool get isFailure => this == BavatarStatus.failure;
}

@JsonSerializable()
class BavatarState extends Equatable {
  const BavatarState({
    this.status = BavatarStatus.initial,
    BavatarsList? bavatarsList,
  }) : bavatarsList = bavatarsList ?? BavatarsList.empty;

  factory BavatarState.fromJson(Map<String, dynamic> json) =>
      _$BavatarStateFromJson(json);

  final BavatarStatus status;
  final BavatarsList bavatarsList;

  Map<String, dynamic> toJson() => _$BavatarStateToJson(this);

  @override
  List<Object?> get props => [status, bavatarsList];

  BavatarState copyWith({
    BavatarStatus? status,
    BavatarsList? bavatarsList,
  }) {
    return BavatarState(
      status: status ?? this.status,
      bavatarsList: bavatarsList ?? this.bavatarsList,
    );
  }
}
