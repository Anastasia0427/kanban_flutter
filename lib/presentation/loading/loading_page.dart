import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/presentation/auth/widgets/background_pattern.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPattern(),
          Center(
            child: CircularProgressIndicator(color: context.color.primaryText),
          ),
        ],
      ),
    );
  }
}
