import 'package:flutter/material.dart';

class CsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CsAppBar({
    required this.title,
    this.actions,
    this.leading,
    this.preferredSize = const Size.fromHeight(65),
    this.elevation = 8,
    super.key,
  });

  @override
  final Size preferredSize;

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: elevation,
      backgroundColor: theme.appBarTheme.backgroundColor,
      toolbarHeight: 65,
      actionsIconTheme: theme.appBarTheme.iconTheme,
      centerTitle: true,
      title: FittedBox(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      actions: actions,
      leading: leading,
    );
  }
}