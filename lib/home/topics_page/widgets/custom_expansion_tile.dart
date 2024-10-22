import 'package:checklist_app/core/helper/extensions.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomTopExpansionTile extends StatefulWidget {
  const CustomTopExpansionTile({super.key, this.headerBuilder, this.children = const []});

  final Widget Function(BuildContext context, bool isExpanded)? headerBuilder;
  final List<Widget> children;

  @override
  State<CustomTopExpansionTile> createState() =>
      _CustomTopExpansionTileState();
}

class _CustomTopExpansionTileState extends State<CustomTopExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: context.screenWidth,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.primaryColor, width: .5),
              bottom: BorderSide(color: AppColors.primaryColor, width: .5))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            child: _isExpanded
                ? Padding(
              padding:
              const EdgeInsets.only(top: PaddingDimensions.medium),
              child: Column(children: widget.children),
            )
                : const SizedBox(),
          ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: widget.headerBuilder != null
                  ? widget.headerBuilder!(context, _isExpanded)
                  : null),
        ],
      ),
    );
  }
}