part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
  
  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}


final class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel>? categories;
  CategoriesLoaded({
    this.categories,
  });
}

final class CategoriesError extends CategoriesState {
  final String? message;
  CategoriesError({
    this.message,
  });
}