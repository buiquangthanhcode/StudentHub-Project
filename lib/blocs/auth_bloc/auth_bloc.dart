import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/services/authen/authen.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class AuthBloc extends Bloc<AuthenEvent, AuthenState> {
  AuthBloc()
      : super(
          const AuthenState(),
        ) {
    on<LoginEvent>(_onLogin);
  }

  final AuthService _authenService = AuthService();

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthenState> emit) async {
    EasyLoading.show(status: 'Loading...');
    ResponseAPI result = await _authenService.login(
      event.requestLogin,
    );
    if (result.statusCode! < 300) {
      // change state here to update UI
      event.onSuscess!(); // Call onSuccessCallBack
    } else {
      SnackBarService.showSnackBar(
          content: handleFormatMessage(result.data!.errorDetails), status: StatusSnackBar.error);
    }
    EasyLoading.dismiss();
  }
}
