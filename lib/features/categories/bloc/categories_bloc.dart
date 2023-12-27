import 'dart:convert';

import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/categories/data/categories_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesRepo categoriesRepo = CategoriesRepo();
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) {});
    on<LoadCategoriesData>((event, emit) async {
      emit(CategoriesLoading());
      var response = await categoriesRepo.getCategories();
      List<CategoryModel> categories = [];
      if (response.statusCode == 200) {
        for (var category in jsonDecode(response.body)) {
          categories.add(CategoryModel.fromJson(category));
        }
        emit(CategoriesLoaded(categories: categories));
      } else {
        emit(CategoriesError(message: 'Error loading categories'));
      }
    });
  }
}
