import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';

class Amount extends StatelessWidget {

  final FlowFormController controller;

  const Amount({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.form['categories'].map<Widget>((e) {
        return Column(
          children: [
            MyFormText(
              required: true,
              label: "${e['categoryName']} - ${LocaleKeys.flow_amount.tr}",
              value: e['amount'],
              onChange: (value) {
                //context.read<FlowFormBloc>().add(CategoryAmountChanged(e['categoryId'], value));
              },
            ),
            if (controller.needConvert) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyFormText(
                      required: true,
                      label: "${e['categoryName']} - ${controller.convertCode}",
                      value: e['convertedAmount'],
                      onChange: (value) {
                        // context.read<FlowFormBloc>().add(CategoryConvertedAmountChanged(e['categoryId'], value));
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () { },
                    icon: const Icon(Icons.calculate)
                  )
                ],
              )
            ],
          ],
        );
      }).toList(),
    );
  }

}