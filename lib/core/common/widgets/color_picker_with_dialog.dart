import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWithDialog extends StatefulWidget {
  final Color pickerColor;
  final List<Color> availableColors;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerWithDialog({
    super.key,
    required this.pickerColor,
    required this.availableColors,
    required this.onColorChanged,
  });

  @override
  State<ColorPickerWithDialog> createState() => _ColorPickerWithDialogState();
}

class _ColorPickerWithDialogState extends State<ColorPickerWithDialog> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.pickerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentColor,
        boxShadow: [
          BoxShadow(
            color: _currentColor.withAlpha(220),
            offset: const Offset(1, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: _currentColor,
                    availableColors: widget.availableColors,
                    onColorChanged: (color) {
                      setState(() {
                        _currentColor = color;
                      });
                      widget.onColorChanged(color);
                      Navigator.of(context).pop();
                    },
                    layoutBuilder: (context, colors, child) {
                      return SizedBox(
                        width: 200,
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          children: [for (final color in colors) child(color)],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          customBorder: const CircleBorder(),
          child: const SizedBox(width: 56, height: 56),
        ),
      ),
    );
  }
}
