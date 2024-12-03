import 'package:engineer/screens/components/custom_list.dart';  
import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

//ยังไม่ complete สามารถ scanได้แล้วแต่ข่อมูลยังไม่มา
class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;
  String? scannedMcID;

  @override
  void reassemble() {
    super.reassemble();
    // if (controller != null) {
    //   controller!.pauseCamera();
    //   controller!.resumeCamera();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: Column(
        children: <Widget>[
          // Expanded(
          //   flex: 5,
          //   child: QRView(
          //     key: qrKey,
          //     onQRViewCreated: _onQRViewCreated,
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Center(
              child: scannedMcID == null
                  ? Text('Scan a QR code to see details')
                  : Text('Scanned MCID: $scannedMcID'),
            ),
          ),
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       scannedMcID = scanData.code; // รับค่าของ QR code
  //     });

  //     // นำ mcid ไปยังหน้า CustomList เมื่อสแกน QR Code
  //     if (scannedMcID != null) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => CustomList(
  //             // ส่ง mcid ไปที่ CustomList
  //             lineID: '1001', // ตัวอย่าง lineID
  //             lineName: 'Line 1', // ตัวอย่าง lineName
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
}
