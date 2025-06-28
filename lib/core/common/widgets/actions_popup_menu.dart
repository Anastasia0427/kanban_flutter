import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';

class ActionsPopupMenu extends StatelessWidget {
  final VoidCallback? firstAction;
  final VoidCallback? secondAction;
  final String firstActionLabel;
  final String secondActionLabel;
  final TextStyle firstActionLabelStyle;
  final TextStyle secondActionLabelStyle;

  const ActionsPopupMenu({
    super.key,
    this.firstAction,
    this.secondAction,
    required this.firstActionLabel,
    required this.secondActionLabel,
    required this.firstActionLabelStyle,
    required this.secondActionLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: context.color.invertedPrimaryText),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: firstAction,
          child: Center(
            child: Text(firstActionLabel, style: firstActionLabelStyle),
          ),
        ),
        const PopupMenuDivider(height: 1),
        PopupMenuItem(
          onTap: secondAction,
          child: Center(
            child: Text(secondActionLabel, style: secondActionLabelStyle),
          ),
        ),
      ],
    );
  }
}
