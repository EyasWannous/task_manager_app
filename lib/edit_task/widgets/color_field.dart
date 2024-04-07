import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/edit_task/bloc/edit_task_bloc.dart';
import 'package:task_manager_app/edit_task/edit_task.dart';

class ColorField extends StatelessWidget {
  const ColorField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return TextFormField(
      key: const Key('editTaskView_color_textFormField'),
      initialValue: state.color,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'You should enter your Color';
        }
        if (value.length < 4) {
          return 'Your Color shoudl be more than 3 charechter';
        }
        if (value[0] != '#') {
          return 'You should start with #';
        }
        return null;
      },
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Color',
        hintText: 'color',
        icon: const Icon(Icons.colorize),
      ),
      maxLength: 350,
      autocorrect: true,
      minLines: 1,
      maxLines: 8,
      inputFormatters: [
        LengthLimitingTextInputFormatter(350),
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskColorChanged(value));
      },
    );
  }
}
