import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlockObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('${bloc.runtimeType} Created! ${bloc.state}');
  }

  oncCange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(
      '${bloc.runtimeType} Changed! ${change.currentState} -> ${change.nextState}',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(
      '${bloc.runtimeType} Transitioned! ${transition.currentState} -> ${transition.nextState}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} Error! $error');
  }
}
