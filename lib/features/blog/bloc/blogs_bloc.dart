import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  BlogsBloc() : super(BlogsInitial()) {
    on<BlogsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
