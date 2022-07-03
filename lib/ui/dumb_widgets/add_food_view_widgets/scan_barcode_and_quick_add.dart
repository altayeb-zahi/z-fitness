import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';

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
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: screenHeightPercentage(context, percentage: 0.2),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
            child: Container(
          color: backgroundColorLight,
          child: GestureDetector(
            onTap: onScanBarcode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  UniconsLine.qrcode_scan,
                  color: primaryColorLight,
                  size: 60,
                ),
                verticalSpaceSmall,
                Text(
                  'Scan a Barcode',
                  style: theme.textTheme.headline4,
                )
              ],
            ),
          ),
        )),
        horizontalSpaceSmall,
        Expanded(
            child: Container(
          color: secondaryColorLight,
          child: GestureDetector(
            onTap: onQuickAdd,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  UniconsLine.fire,
                  color: primaryColorLight,
                  size: 60,
                ),
                verticalSpaceSmall,
                Text(
                  'Quick Add',
                  style: theme.textTheme.headline4,
                )
              ],
            ),
          ),
        )),
      ]),
    );
  }
}
