import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                    context.read<TaskBloc>().add(ToggleTask(index));
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<TaskBloc>().add(DeleteTask(index));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(controller: _controller),
          actions: [
            TextButton(
              onPressed: () {
                context.read<TaskBloc>().add(AddTask(_controller.text));
                _controller.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }
}
