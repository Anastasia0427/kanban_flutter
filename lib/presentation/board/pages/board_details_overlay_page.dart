import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/presentation/board/widgets/board_details_overlay.dart';

class BoardDetailsOverlayPage extends StatelessWidget {
  final BoardModel board;

  const BoardDetailsOverlayPage({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Utils.stringToColor(board.color),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: context.color.shadowColor!.withAlpha(50),
              offset: const Offset(-4, 0),
              blurRadius: 6,
            ),
          ],
        ),
        child: BoardDetailsOverlay(board: board),
      ),
    );
  }
}
