import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerWidget extends StatefulWidget {
  final Function(String) onScan;
  final bool testMode; // ✅ Add this flag
  const QrScannerWidget({
    super.key,
    required this.onScan,
    this.testMode = false,
  });

  @override
  State<QrScannerWidget> createState() => _QrScannerWidgetState();
}

class _QrScannerWidgetState extends State<QrScannerWidget> {
  final MobileScannerController _controller = MobileScannerController();
  bool isScanned = false;

  @override
  void initState() {
    super.initState();

    // ✅ If test mode enabled, call onScan after a short delay
    if (widget.testMode) {
      Future.delayed(const Duration(seconds: 1), () {
        if (!isScanned) {
          isScanned = true;
          widget.onScan("JB-0023");
          print("✅ Test QR code triggered\n JB-8312");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.testMode) {
      return const Center(child: Text("🔧 Test Mode: QR auto-filled JB-8312"));
    }

    return MobileScanner(
      controller: _controller,
      onDetect: (capture) {
        if (isScanned) return;

        final barcode = capture.barcodes.first.rawValue;
        if (barcode != null && barcode.isNotEmpty) {
          isScanned = true;
          String jbNo = '';
          try {
            final uri = Uri.parse(barcode);
            jbNo = uri.queryParameters['jb_no'] ?? barcode;
          } catch (_) {
            jbNo = barcode.split('jb_no=').last;
          }
          _controller.stop();
          widget.onScan(jbNo);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
