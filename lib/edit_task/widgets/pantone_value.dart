import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/edit_task/bloc/edit_task_bloc.dart';
import 'package:task_manager_app/edit_task/edit_task.dart';

class PantoneValue extends StatelessWidget {
  const PantoneValue({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return TextFormField(
      key: const Key('editTaskView_pantoneValue_textFormField'),
      initialValue: state.pantoneValue,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'You should enter your Pantone';
        }
        if (value.length < 4) {
          return 'Your Pantone shoudl be more than 3 charechter';
        }
        return null;
      },
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Pantone',
        hintText: 'pantone',
        icon: const Icon(Icons.color_lens),
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
        context.read<EditTaskBloc>().add(EditTaskPantoneValueChanged(value));
      },
    );
  }
}
