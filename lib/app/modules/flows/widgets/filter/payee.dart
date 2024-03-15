import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';
import '../../../common/select/select_controller.dart';
import '../../../common/select/select_option.dart';
import '../../controllers/flows_controller.dart';

class Payee extends StatelessWidget {

  const Payee({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.flow_payee.tr,
        value: controller.query['payees'],
        allowClear: true,
        onClear: () {
          controller.query['payees'] = null;
          controller.update();
        },
        onFocus: () {
          Map<String, dynamic> query = { };
          if (controller.query['book'] != null) {
            query['bookId'] = controller.query['book']['value'];
          }
          Get.find<SelectController>().load('payees', params: query);
          Get.to(() => SelectOption(
            title: LocaleKeys.flow_payee.tr,
            value: controller.query['payees'],
            onSelect: (value) {
              controller.query['payees'] = value;
              controller.update();
              Get.back();
            },
          ));
        },
      );
    });
  }

}