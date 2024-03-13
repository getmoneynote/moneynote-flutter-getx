import 'package:get/get.dart';
import '/app/modules/accounts/controllers/accounts_controller.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';

class AccountDetailController extends BaseController {

  int id;
  LoadDataStatus status = LoadDataStatus.initial;
  Map<String, dynamic> item = {};
  LoadDataStatus deleteStatus = LoadDataStatus.initial;

  AccountDetailController(this.id);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() async {
    try {
      status = LoadDataStatus.progress;
      update();
      item = await BaseRepository.get('accounts', id);
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

  void delete() async {
    try {
      deleteStatus = LoadDataStatus.progress;
      update();
      final result = await BaseRepository.toggle('accounts', id);
      if (result) {
        deleteStatus = LoadDataStatus.success;
        Get.back();
        Get.find<AccountsController>().reload();
      } else {
        deleteStatus = LoadDataStatus.failure;
      }
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

}