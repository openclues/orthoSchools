part of 'like_cubit_cubit.dart';

sealed class LikeCubitState extends Equatable {
  const LikeCubitState();

  @override
  List<Object> get props => [];
}

final class LikeCubitInitial extends LikeCubitState {}



class LikeLoading extends LikeCubitState {
  final bool isLoading;
  const LikeLoading(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class LikeLoaded extends LikeCubitState {
  final bool isLiked;
  final int likesCount;
  const LikeLoaded({required this.isLiked,required this.likesCount});
  @override
  List<Object> get props => [isLiked];
}