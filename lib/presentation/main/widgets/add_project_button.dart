import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.color.primaryText!.withAlpha(100),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
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
                child: Icon(
                  Icons.add,
                  size: 42,
                  color: context.color.primaryText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
