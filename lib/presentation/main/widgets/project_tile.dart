import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Доска 1',
                  style: GoogleFonts.jost(textStyle: context.text.headerTitle),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: context.color.invertedPrimaryText,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Center(
                        child: Text(
                          context.l10n.edit,
                          style: GoogleFonts.jost(
                            textStyle: context.text.smallTitle,
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuDivider(height: 1),
                    PopupMenuItem(
                      value: 'delete',
                      child: Center(
                        child: Text(
                          context.l10n.delete,
                          style: GoogleFonts.jost(
                            textStyle: context.text.deleteButtonLabel,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Описание......',
                style: GoogleFonts.jost(textStyle: context.text.smallTitle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
