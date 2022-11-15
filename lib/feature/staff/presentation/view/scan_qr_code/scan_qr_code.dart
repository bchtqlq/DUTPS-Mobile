import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/feature/staff/presentation/view/staff_page.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

extension ScanQRCode on StaffPage {
  Widget scanQRCode() {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                // Configure the overlay to look nice
                borderRadius: 10,
                borderWidth: 5,
                borderColor: Colors.white,
              ),
              onQRViewCreated: controller.onQRViewCreated,
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: controller.pauseScan,
              child: Assets.images.closeIcon.image(width: 60, color: ColorName.whiteFff),
            ),
          ),
        ],
      ),
    );
  }
}
