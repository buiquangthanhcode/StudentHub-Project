import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_event.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_state.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_type.dart';
import 'package:studenthub/services/local_services.dart';
import 'package:studenthub/utils/logger.dart';

class NavigatorStatusBloc extends Bloc<NavigatorStatusEvent, NavigatorStatusState> {
  NavigatorStatusBloc()
      : super(
          const NavigatorStatusState(
            navigatorType: NavigatorType.splash,
          ),
        ) {
    on<UpdateNavigatorStatusEvent>(_onUpdateNavigator);
    // _navigatorTypeSubscription = status.listen(
    //   (status) => add(UpdateNavigatorStatusEvent(status)),
    // );
  }

  // final LocalStorageService _tokenService = LocalStorageService();
  // late StreamSubscription<NavigatorType> _navigatorTypeSubscription;
  // final _controller = StreamController<NavigatorType>();

  _onUpdateNavigator(
    UpdateNavigatorStatusEvent event,
    Emitter<NavigatorStatusState> emit,
  ) {
    switch (event.navigatorType) {
      case NavigatorType.splash:
        return emit(
          state.update(
            navigatorType: NavigatorType.splash,
          ),
        );

      case NavigatorType.home:
        return emit(state.update(
          navigatorType: NavigatorType.home,
        ));
      case NavigatorType.unauthenticated:
        return emit(state.update(
          navigatorType: NavigatorType.unauthenticated,
        ));
      case NavigatorType.intro:
        return emit(state.update(
          navigatorType: NavigatorType.intro,
        ));
      default:
        return null;
    }
  }

  // Stream<NavigatorType> get status async* {
  //   String? token = await _tokenService.getAccessToken() ?? '';
  //   bool? isFirstInstall = await _tokenService.getFirstInstall();

  //   try {
  //     if (isFirstInstall == null) {
  //       yield NavigatorType.intro;
  //       await _tokenService.setFirstInstall(isFirstInstall: false);
  //     } else {
  //       if (!isFirstInstall) {
  //         if (token == '') {
  //           yield NavigatorType.unauthenticated;
  //         }
  //       } else {
  //         yield NavigatorType.intro;
  //       }
  //     }
  //   } catch (e) {
  //     logger.e("navigator_status_bloc.dart >> status: $e");
  //     yield NavigatorType.unauthenticated;
  //   }
  //   yield* _controller.stream;
  // }

  @override
  Future<void> close() {
    // _navigatorTypeSubscription.cancel();
    return super.close();
  }
}
