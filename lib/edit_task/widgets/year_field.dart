import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/edit_task/bloc/edit_task_bloc.dart';
import 'package:task_manager_app/edit_task/edit_task.dart';

class YearField extends StatelessWidget {
  const YearField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return TextFormField(
      key: const Key('editTaskView_year_textFormField'),
      initialValue: state.year.toString(),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'You should enter your Year';
        }
        if (value.length < 4) {
          return 'Your Year shoudl be more than 3 charechter';
        }
        return null;
      },
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Yaer',
        hintText: 'year',
        icon: const Icon(Icons.calendar_month),
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
        var parsedValue = int.tryParse(value);
        if (parsedValue != null) {
          context.read<EditTaskBloc>().add(EditTaskYearChanged(parsedValue));
        }
      },
    );
  }
}
