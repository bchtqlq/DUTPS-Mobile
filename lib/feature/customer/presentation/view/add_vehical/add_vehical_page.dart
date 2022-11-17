import 'package:dut_packing_system/base/presentation/base_app_bar.dart';
import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/feature/customer/presentation/controller/add_vehical/add_vehical_controller.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/extension/form_builder.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddVehicalPage extends BaseWidget<AddVehicalController> {
  const AddVehicalPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text('Thêm phương tiện'),
        ),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                child: FormBuilder(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      CommonTextField(
                        formKey: controller.formKey,
                        type: FormFieldType.licensePlate,
                        maxLength: 35,
                        controller: controller.licensePlateTextEditingController,
                        onTap: controller.hideErrorMessage,
                        onChanged: (_) {
                          controller.updateLoginButtonState();
                        },
                      ),
                      const SizedBox(height: 2),
                      CommonTextField(
                        formKey: controller.formKey,
                        type: FormFieldType.memo,
                        textInputAction: TextInputAction.newline,
                        maxLength: 500,
                        maxLines: 10,
                        height: 108,
                        controller: controller.memoTextEditingController,
                        onTap: controller.hideErrorMessage,
                        onChanged: (_) {
                          controller.updateLoginButtonState();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Danh sách phương tiện của bạn",
                        style: AppTextStyle.w500s15(ColorName.black000),
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: controller.toAdd,
                      child: Assets.images.addIcon.image(width: 30),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (controller.vehicals.isEmpty)
                Expanded(
                  child: Assets.images.emptyIcon.image(width: 150),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 25),
                    itemCount: controller.vehicals.length,
                    itemBuilder: (context, index) {
                      return vehicalItem(
                        title: controller.vehicals[index].licensePlate,
                        onEdit: () => controller.toUpdate(controller.vehicals[index]),
                        onDelete: () => controller.onDeleteVehical(controller.vehicals[index]),
                      );
                    },
                  ),
                ),
              Obx(
                () => CommonBottomError(text: controller.errorMessage.value),
              ),
              Obx(
                () => CommonBottomButton(
                  text: controller.pageState.value == VehicalPageState.add ? 'Thêm mới' : 'Cập nhật',
                  onPressed: () =>
                      controller.pageState.value == VehicalPageState.add ? controller.onAdd() : controller.onUpdate(),
                  pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                  fillColor: controller.isDisableButton.value ? ColorName.gray838 : ColorName.primaryColor,
                  state: controller.updateState,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget vehicalItem({
  String? title,
  Function()? onDelete,
  Function()? onEdit,
}) {
  return Container(
    alignment: Alignment.center,
    height: 50,
    width: double.infinity,
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
      ),
    ),
    child: Row(
      children: [
        const SizedBox(width: 16),
        Assets.images.goShipMoto.image(width: 25),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title ?? "",
            style: AppTextStyle.w400s15(ColorName.black000),
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onEdit,
          child: const Icon(
            Icons.edit_note_outlined,
            color: ColorName.primaryColor,
          ),
        ),
        const SizedBox(width: 5),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onDelete,
          child: const Icon(
            Icons.delete_forever,
            color: ColorName.primaryColor,
          ),
        ),
        const SizedBox(width: 16),
      ],
    ),
  );
}
