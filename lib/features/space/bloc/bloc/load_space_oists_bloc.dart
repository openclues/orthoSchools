import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/space/data/space_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'load_space_oists_event.dart';
part 'load_space_oists_state.dart';

class LoadSpaceOistsBloc
    extends Bloc<LoadSpaceOistsEvent, LoadSpaceOistsState> {
  SpaceRepo spaceRepo = SpaceRepo();
  LoadSpaceOistsBloc() : super(LoadSpaceOistsInitial()) {
    on<LoadSpaceOistsEvent>((event, emit) {});
    on<LoadSpaceOists>((event, emit) async {
      var response = await spaceRepo.getSpacePosts(event.spaceId.toString(),
          filter: event.filter);
      if (response.statusCode == 200) {}
    });
  }
}
