import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/navigation/router.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/presentation/board/bloc/board_bloc.dart';
import 'package:kanban_flutter/presentation/board/pages/board_details_overlay_page.dart';
import 'package:kanban_flutter/presentation/board/widgets/add_column_dialog.dart';
import 'package:kanban_flutter/presentation/board/widgets/add_task_dialog.dart';
import 'package:kanban_flutter/presentation/board/widgets/board_column.dart';

class BoardPage extends StatefulWidget {
  final BoardModel board;

  const BoardPage({super.key, required this.board});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<BoardBloc>().add(
          BoardFetchColumns(boardId: widget.board.boardId!),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.board.name,
          style: GoogleFonts.jost(
            textStyle: context.text.largeTitle!.copyWith(
              color: Utils.stringToColor(widget.board.color),
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: router.pop,
          icon: Icon(
            Icons.arrow_back,
            color: Utils.stringToColor(widget.board.color),
            size: 32,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AddColumnDialog(board: widget.board),
                    );
                  },
                  child: Center(
                    child: Text(
                      context.l10n.addColumn,
                      style: GoogleFonts.jost(
                        textStyle: context.text.smallTitle,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddTaskDialog(),
                    );
                  },
                  child: Center(
                    child: Text(
                      context.l10n.addTask,
                      style: GoogleFonts.jost(
                        textStyle: context.text.smallTitle,
                      ),
                    ),
                  ),
                ),
              ],
              child: Material(
                color: context.color.tertiaryBackground,
                shape: const CircleBorder(),
                elevation: 4,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: Utils.stringToColor(widget.board.color),
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _openBoardOverlay(context, widget.board),
            icon: Transform.rotate(
              angle: 90 * 3.1415926535 / 180,
              child: Icon(
                Icons.remove_circle_outline,
                color: Utils.stringToColor(widget.board.color),
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<BoardBloc, BoardState>(
        builder: (context, state) {
          if (state is BoardLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: context.color.primaryText,
              ),
            );
          }
          if (state is BoardFailure) {
            return Center(
              child: Column(
                children: [
                  Text(
                    context.l10n.errorOccured,
                    style: GoogleFonts.jost(
                      textStyle: context.text.mediumTitle,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<BoardBloc>().add(
                        BoardFetchColumns(boardId: widget.board.boardId!),
                      );
                    },
                    icon: Icon(Icons.refresh, color: context.color.primaryText),
                  ),
                ],
              ),
            );
          }
          if (state is BoardLoaded) {
            return Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final totalColumnWidth = state.columns.length * (400 + 16);
                  final centerContent = totalColumnWidth < constraints.maxWidth;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 24,
                      left: 12,
                      right: 12,
                    ),
                    controller: _scrollController,
                    child: Container(
                      width: centerContent ? constraints.maxWidth : null,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: centerContent
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: List.generate(
                          state.columns.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: BoardColumn(column: state.columns[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _openBoardOverlay(BuildContext context, BoardModel board) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => BoardDetailsOverlayPage(board: board),
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1.0, 0.0); // справа
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
