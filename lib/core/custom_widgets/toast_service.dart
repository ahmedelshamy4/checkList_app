import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ToastService {
  static final ToastService _instance = ToastService._internal();

  factory ToastService() {
    return _instance;
  }

  ToastService._internal();

  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  void showToast(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    if (_isVisible) {
      return; // Prevent multiple toasts from showing at the same time.
    }

    _overlayEntry = _createOverlayEntry(context, message);
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    // Automatically dismiss the toast after the specified duration.
    Future.delayed(duration, () {
      if (_isVisible) {
        _overlayEntry?.remove();
        _isVisible = false;
      }
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context, String message) {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingDimensions.large,
              vertical: PaddingDimensions.large,
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: PaddingDimensions.normal),
                Expanded(
                  child: Text(
                    message,
                    style: AppTextStyles.nunitoFont16Regular(
                      context,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
