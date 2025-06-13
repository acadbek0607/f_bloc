import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlockObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('${bloc.runtimeType} Created! ${bloc.state}');
  }
}
