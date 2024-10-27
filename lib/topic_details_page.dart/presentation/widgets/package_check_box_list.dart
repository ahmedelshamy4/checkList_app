import 'package:flutter/material.dart';

class PackageCheckboxList extends StatefulWidget {
  final List<String> packageNames;
  final List<bool> selectedPackages;
  final Function(int, bool) onPackageChecked;

  const PackageCheckboxList({
    super.key,
    required this.packageNames,
    required this.selectedPackages,
    required this.onPackageChecked,
  });

  @override
  State<PackageCheckboxList> createState() => _PackageCheckboxListState();
}

class _PackageCheckboxListState extends State<PackageCheckboxList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.packageNames.length, (index) {
        // return CheckboxListTile(
        //   title: Text(packageNames[index]),
        //   value: selectedPackages[index],
        //   onChanged: (isChecked) {
        //     onPackageChecked(index, isChecked ?? false);
        //   },
        // );
        return Row(
          children: [
            Text(widget.packageNames[index]),
            IconButton(
                onPressed: () {
                  widget.packageNames.removeAt(index);
                  setState(() {});
                },
                icon: Icon(Icons.close)),
          ],
        );
      }),
    );
  }
}
