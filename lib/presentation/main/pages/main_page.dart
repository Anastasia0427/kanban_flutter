import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
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
        shadowColor: Colors.black,
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = (constraints.maxWidth / 300).floor().clamp(
            1,
            4,
          );

          return Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              itemCount: 13,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 4 / 3,
              ),
              itemBuilder: (context, index) {
                if (index == 0) return const AddProjectButton();
                return const ProjectTile();
              },
            ),
          );
        },
      ),
    );
  }
}
