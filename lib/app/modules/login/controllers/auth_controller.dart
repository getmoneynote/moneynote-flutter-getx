import 'package:moneynote/app/core/utils/ApiUrl.dart';
import 'package:moneynote/app/modules/login/data/login_repository.dart';

import '/app/core/utils/token.dart';
import '/app/core/base/base_controller.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, loading }

class AuthController extends BaseController {

  AuthStatus status = AuthStatus.uninitialized;
  Map<String, dynamic> initState = const { };

  void onLoggedIn(String token) async {
    await Token.save(token);
    status = AuthStatus.authenticated;
    update();
  }

  void onLoggedOut() async {
    await Token.delete();
    status = AuthStatus.unauthenticated;
    initState = const { };
    update();
  }

  void onAppStarted() async {
    final String token = await Token.get();
    final String apiUrl = await ApiUrl.get();
    if (apiUrl.isNotEmpty && token.isNotEmpty) {
      try {
        initState = await LoginRepository.getInitState();
        status = AuthStatus.authenticated;
      } catch (_) {
        status = AuthStatus.unauthenticated;
      }
    } else {
      status = AuthStatus.unauthenticated;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    onAppStarted();
  }

}