import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/global_bloc/global_event.dart';
import 'package:studenthub/blocs/global_bloc/global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {}
}
