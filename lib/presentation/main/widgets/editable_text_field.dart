import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/widgets/overflowed_animated_text.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';

class EditableTextField extends StatefulWidget {
  final bool isEditing;
  final bool isHovered;
  final String value;
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onEdit;
  final void Function(bool) onHoverChange;
  final TextStyle textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final Function(String)? onChanged;

  const EditableTextField({
    super.key,
    required this.isEditing,
    required this.isHovered,
    required this.value,
    required this.controller,
    required this.onSave,
    required this.onEdit,
    required this.onHoverChange,
    required this.textStyle,
    this.inputFormatters,
    this.errorText,
    this.onChanged,
  });

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool _isIconHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHoverChange(true),
      onExit: (_) => widget.onHoverChange(false),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: widget.isEditing
                ? TextField(
                    onChanged: widget.onChanged,
                    controller: widget.controller,
                    style: widget.textStyle,
                    inputFormatters: widget.inputFormatters,
                    decoration: InputDecoration(
                      errorText: widget.errorText,
                      errorStyle: GoogleFonts.jost(
                        textStyle: context.text.textFieldError,
                      ),
                    ),
                  )
                : AnimatedOverflowedText(
                    text: widget.value,
                    style: widget.textStyle,
                  ),
          ),
          const SizedBox(width: 8),
          MouseRegion(
            onEnter: (_) => setState(() => _isIconHovered = true),
            onExit: (_) => setState(() => _isIconHovered = false),
            child: GestureDetector(
              onTap: widget.isEditing ? widget.onSave : widget.onEdit,
              child: Opacity(
                opacity: widget.isHovered || widget.isEditing ? 1 : 0,
                child: Icon(
                  widget.isEditing ? Icons.check : Icons.edit_outlined,
                  size: 28,
                  color: _isIconHovered
                      ? context.color.primaryText
                      : context.color.inactiveIconButton,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
