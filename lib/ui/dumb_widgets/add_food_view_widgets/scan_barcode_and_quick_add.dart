import 'package:flutter/material.dart';

import '../../shared/ui_helpers.dart';


class BarcodeScannerAndQuickAdd extends StatelessWidget {
  final void Function() onScanBarcode;
  final void Function() onQuickAdd;


  const BarcodeScannerAndQuickAdd({
    Key? key,
    required this.onScanBarcode,
    required this.onQuickAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      
      height: screenHeightPercentage(context, percentage: 0.2),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
            child: Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: onScanBarcode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.purple[900],
                  size: 60,
                ),
                const Text('Scan a Barcode')
              ],
            ),
          ),
        )),
        horizontalSpaceSmall,
        Expanded(
            child: Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: onQuickAdd,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_task_sharp,
                  color: Colors.purple[900],
                  size: 60,
                ),
                const Text('Quick Add')
              ],
            ),
          ),
        )),
      ]),
    );
  }
}
