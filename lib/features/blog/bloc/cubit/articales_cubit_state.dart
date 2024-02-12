part of 'articales_cubit_cubit.dart';

sealed class ArticalesCubitState extends Equatable {
  const ArticalesCubitState();

  @override
  List<Object> get props => [];
}

final class ArticalesCubitInitial extends ArticalesCubitState {}
final class ArticalesLoading extends ArticalesCubitState {}
final class ArticalesLoaded extends ArticalesCubitState {
  final PageModel<ArticlesModel> pageModel;

  const ArticalesLoaded({required this.pageModel});
  
}


//error
final class ArticalesError extends ArticalesCubitState {
  final String message;

  const ArticalesError({required this.message});
}