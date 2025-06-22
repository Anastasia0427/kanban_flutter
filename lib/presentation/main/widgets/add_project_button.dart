import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: const CircleBorder(),
        elevation: 4,
        color: context.color.tertiaryBackground,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            // TODO: Открытие модального окна/страницы создания проекта
          },
          child: SizedBox(
            width: 72,
            height: 72,
            child: Icon(Icons.add, size: 42, color: context.color.primaryText),
          ),
        ),
      ),
    );
  }
}
