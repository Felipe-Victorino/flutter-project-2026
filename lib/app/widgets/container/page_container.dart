import 'package:flutter/cupertino.dart';

class PageContainer extends StatelessWidget {
  final List<Widget> children;

  const PageContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        crossAxisAlignment: .stretch,
        mainAxisAlignment: .start,
        children: children,
      ),
    );
  }
}
