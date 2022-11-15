import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class StaffController extends BaseController {
  String result = "";
  QRViewController? _qrCodecontroller;
  var isChecked = false.obs;

  var isCheckIn = true.obs;

  var isScan = false.obs;

  var confirmState = BaseState();

  @override
  void onClose() {
    super.onClose();
    _qrCodecontroller?.dispose();
  }

  void onQRViewCreated(QRViewController qrCodecontroller) {
    _qrCodecontroller = qrCodecontroller;
    _qrCodecontroller?.resumeCamera();
    _qrCodecontroller?.pauseCamera();
    _qrCodecontroller?.scannedDataStream.listen(
      (scanData) {
        result = scanData.code ?? "";
        if (result != "") {
          _qrCodecontroller?.pauseCamera();
          isChecked.value = true;
        }
      },
    );
  }

  void resumeScan() {
    _qrCodecontroller?.resumeCamera();
    isChecked.value = false;
  }

  void startScan(bool checkIn) {
    _qrCodecontroller?.resumeCamera();
    isChecked.value = false;
    isScan.value = true;
    isCheckIn.value = checkIn;
  }

  void pauseScan() {
    _qrCodecontroller?.pauseCamera();
    isChecked.value = false;
    isScan.value = false;
  }

  void confirmScan() {
    // confirmState.onLoading();
    // send to api
    _qrCodecontroller?.pauseCamera();
    isChecked.value = false;
    isScan.value = false;
  }
}
