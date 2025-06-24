import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/global_state/user_boards/user_boards_cubit.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:kanban_flutter/presentation/main/widgets/add_project_button.dart';
import 'package:kanban_flutter/presentation/main/widgets/project_tile.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 4,
        shadowColor: context.color.shadowColor,
        toolbarHeight: 80,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            context.l10n.myProjects,
            style: GoogleFonts.jost(textStyle: context.text.largeTitle),
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_outline, size: 42),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MainFailure) {
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
                      context.read<MainBloc>().add(MainFetchUserBoards());
                    },
                    icon: Icon(Icons.refresh, color: context.color.primaryText),
                  ),
                ],
              ),
            );
          }
          if (state is MainLoaded) {
            return BlocBuilder<UserBoardsCubit, UserBoardsState>(
              builder: (context, state) {
                if (state is! UserBoardsLoaded) {
                  return const SizedBox.shrink();
                }
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = (constraints.maxWidth / 300)
                        .floor()
                        .clamp(1, 4);

                    return Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: GridView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(24),
                        itemCount: state.boards.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 4 / 3,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) return const AddProjectButton();
                          return ProjectTile(board: state.boards[index - 1]);
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
