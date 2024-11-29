import 'package:engineer/screens/components/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan a QR code to see details'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // เมื่อสแกน QR Code ได้
      final mcid = scanData.code;

      // นำ mcid ไปยังหน้า CustomList
      if (mcid != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomList(
              lineID: '1001', // ตั้งค่าเป็นค่าเริ่มต้นหรือตามที่ต้องการ
              lineName:
                  'Default Line Name', // ตั้งค่าเป็นค่าเริ่มต้นหรือตามที่ต้องการ
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
