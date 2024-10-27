import 'dart:convert';
import 'package:carbonix/pages/scanner/scan_details_modal.widget.dart';
import 'package:carbonix/pages/scanner/trip_summary_modal.widget.dart';
import 'package:carbonix/provider/auth.service.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/utils/api_paths.dart';
import 'package:carbonix/utils/network_service.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ScannerScreen extends StatefulWidget {
  final bool isEnding;
  final int? tripId;

  const ScannerScreen({Key? key, this.isEnding = false, this.tripId})
      : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _mobileScannerController =
      MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  NetworkService _networkService = NetworkService();

  bool _torchEnabled = false;

  @override
  void initState() {
    super.initState();

    _mobileScannerController.stop();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mobileScannerController.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.blue,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: Pressable(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.chevron_left,
                color: Colors.white, size: 30.0)),
        backgroundColor: Colors.transparent,
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: _mobileScannerController,
        onDetect: (capture) async {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            _mobileScannerController.stop();
            try {
              String stationIdBase64 =
                  jsonDecode(barcode.rawValue ?? '')['station_id'] ?? '';
              String stationType = jsonDecode(barcode.rawValue ?? '')['type'];
              String stationName = jsonDecode(barcode.rawValue ?? '')['name'];
              String stationId = utf8.decode(base64.decode(stationIdBase64));
              String uid = await AuthenticationService().getUid() ?? '';
              await _networkService.post(
                widget.isEnding ? APIPath.endJourney : APIPath.startJourney,
                widget.isEnding
                    ? {'trip_id': widget.tripId, 'station_id': stationId}
                    : {
                        'user_id': uid,
                        'type': stationType,
                        'start_station_id': stationId
                      },
                (result) async {
                  await showCupertinoModalBottomSheet(
                    context: context,
                    builder: (_) => Wrap(
                      children: [
                        widget.isEnding
                            ? TripSummaryModalWidget(
                                tripId: widget.tripId!,
                                creditsSaved: result['body']['credits'],
                                timeTaken: result['body']['time_taken'],
                                carbonSaved: result['body']['carbon_saved'],
                                startStation: result['body']['start_name'],
                                endStation: result['body']['end_name'])
                            : ScanDetailsModalWidget(
                                stationId: stationId,
                                stationType: stationType,
                                journeyId: result['body']['id'],
                                stationName: stationName,
                              )
                      ],
                    ),
                  );
                },
                (e) {
                  print(e);
                },
                () {},
              );
            } catch (e) {
              print(e);
            }
            _mobileScannerController.start();
            break;
          }
        },
        overlay: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              // decoration: BoxDecoration(
              //   // color: Colors.white.withOpacity(0.45),
              //   // border: Border.all(color: ThemeColors.darkGreen, width: 10.0),
              //   borderRadius: const BorderRadius.all(
              //     Radius.circular(20.0),
              //   ),
              // ),
              child: CustomPaint(painter: MyPainter()),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pressable(
                  onPressed: () {
                    _mobileScannerController.toggleTorch();
                    setState(() {
                      _torchEnabled = !_torchEnabled;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: !_torchEnabled ? ThemeColors.text : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(500.0),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _torchEnabled
                            ? Icons.flashlight_off
                            : Icons.flashlight_on,
                        color: _torchEnabled ? ThemeColors.text : Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    double r = 30; //<-- corner radius

    Paint blackPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.5;

    Paint redPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.5;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );

    Path topRightArc = Path()
      ..moveTo(w - r, 0)
      ..arcToPoint(Offset(w, r), radius: Radius.circular(r));
    Path topLeftArc = Path()
      ..moveTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: Radius.circular(r));

    Path bottomLeftArc = Path()
      ..moveTo(r, h)
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    Path bottomRightArc = Path()
      ..moveTo(w, h - r)
      ..arcToPoint(Offset(w - r, h), radius: Radius.circular(r));

    canvas.drawRRect(fullRect, blackPaint);
    canvas.drawPath(topRightArc, redPaint);
    canvas.drawPath(topLeftArc, redPaint);
    canvas.drawPath(bottomLeftArc, redPaint);
    canvas.drawPath(bottomRightArc, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
