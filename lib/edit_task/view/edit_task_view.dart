import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/edit_task/bloc/edit_task_bloc.dart';
import 'package:task_manager_app/edit_task/widgets/color_field.dart';
import 'package:task_manager_app/edit_task/widgets/name_filed.dart';
import 'package:task_manager_app/edit_task/widgets/pantone_value.dart';
import 'package:task_manager_app/edit_task/widgets/year_field.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditTaskBloc bloc) => bloc.state.status);
    final isNewTask = context.select(
      (EditTaskBloc bloc) => bloc.state.isNewTask,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTask ? 'Add Task' : 'Edit Task',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: context.read<EditTaskBloc>().formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://www.projoodle.com/landing/img/todo-list-wizard.png",
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                      errorWidget: (_, __, ___) => const Icon(Icons.error),
                      width: 75,
                      height: 150,
                    ),
                    Text(
                      'Add Task to your list',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.blueGrey),
                    ),
                  ],
                ),
                const NameField(),
                const ColorField(),
                const PantoneValue(),
                const YearField(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save changes',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () {
                if (context.read<EditTaskBloc>().checkValidation()) {
                  context.read<EditTaskBloc>().add(const EditTaskSubmitted());
                }
              },
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
    );
  }
}
