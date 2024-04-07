import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/edit_task/bloc/edit_task_bloc.dart';

class MyField extends StatelessWidget {
  const MyField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.iconData,
    required this.editTaskEvent,
    required this.textEditingController,
  });

  final String hintText;
  final String labelText;
  final IconData iconData;
  final Function editTaskEvent;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return TextFormField(
      key: Key('editTaskView_${hintText}_textFormField'),
      initialValue: state.color,
      controller: textEditingController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: labelText,
        hintText: hintText,
        icon: Icon(iconData),
      ),
      maxLength: 350,
      autocorrect: true,
      minLines: 1,
      maxLines: 8,
      inputFormatters: [
        LengthLimitingTextInputFormatter(350),
        FilteringTextInputFormatter.singleLineFormatter
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(editTaskEvent(value));
      },
    );
  }
}
