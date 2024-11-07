import 'package:flutter/material.dart';

class AlignTextCounter extends StatefulWidget {
  @override
  _AlignTextCounterState createState() => _AlignTextCounterState();
}

class _AlignTextCounterState extends State<AlignTextCounter> {
  final TextEditingController _textController = TextEditingController();

  @override
  initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final maxLength = 10;
    final currentLength = _textController.value.text.length;

    return Align(
      alignment: Alignment.bottomRight, // 위치를 조절할 수 있습니다.
      child: Text(
        '$currentLength / $maxLength',
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            fontSize: 12),
      ),
    );
  }
}
