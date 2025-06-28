import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';

class TaskTile extends StatelessWidget {
  final String taskName;

  const TaskTile({super.key, required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16), // увеличенный padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: 150, // 👈 увеличенная высота плитки
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskName,
              style: GoogleFonts.jost(textStyle: context.text.smallTitle),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Дедлайн: ",
                  style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                ),
                Text(
                  "07.07.2025",
                  style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
