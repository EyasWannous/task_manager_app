import 'package:flutter/material.dart';
import 'package:tasks_api/tasks_api.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    required this.task,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Task task;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;
    // print(pickedDateTime);

    return Dismissible(
      key: Key('taskListTile_dismissible_${task.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          task.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: captionColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          task.pantoneValue,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: CircleAvatar(
          // backgroundColor: Color(),
          backgroundColor: Theme.of(context).splashColor,
        ),
        trailing: Text(
          task.year.toString(),
        ),
        // leading: Checkbox(
        //   shape: const ContinuousRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(8)),
        //   ),
        //   value: task.isCompleted,
        //   onChanged: onToggleCompleted == null
        //       ? null
        //       : (value) => onToggleCompleted!(value!),
        // ),
        // trailing: onTap == null
        //     ? null
        //     : pickedDateTime != null
        //         ? Text(
        //             "${DateFormat('yyyy-MM-dd HH:mm').format(pickedDateTime!)}",
        //             style: Theme.of(context)
        //                 .textTheme
        //                 .bodyMedium!
        //                 .copyWith(color: Colors.pink.shade300),
        //           )
        //         : const Icon(Icons.chevron_right),
      ),
    );
  }
}
