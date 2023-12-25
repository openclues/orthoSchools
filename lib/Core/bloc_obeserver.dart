import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    //print event
    print(event.toString() + " event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //print transition
    print(transition.toString() + " transition");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    //print error
    print(error.toString() + " error");
    // Custom logic for handling errors
  }
}
