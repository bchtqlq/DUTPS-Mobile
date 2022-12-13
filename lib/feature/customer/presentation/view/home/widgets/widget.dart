import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'widget.g.dart';

@swidget
Widget tabItem({required Function() onPressed, required String title, bool isSelect = false}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelect ? ColorName.primaryColor : ColorName.whiteFff,
        border: Border.all(width: 1.0, color: ColorName.primaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          title,
          style: AppTextStyle.w600s15(isSelect ? ColorName.whiteFff : ColorName.primaryColor),
        ),
      ),
    ),
  );
}
