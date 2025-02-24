import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/model/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  AddTask(this.title);
}

class ToggleTask extends TaskEvent {
  final int index;
  ToggleTask(this.index);
}

class DeleteTask extends TaskEvent {
  final int index;
  DeleteTask(this.index);
}

// State
class TaskState {
  final List<Task> tasks;
  TaskState(this.tasks);
}

// BLoC
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState([])) {
    on<LoadTasks>(_loadTasks);
    on<AddTask>(_addTask);
    on<ToggleTask>(_toggleTask);
    on<DeleteTask>(_deleteTask);
  }

  Future<void> _loadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      final prefs = await SharedPreferences.getInstance();
      final String? tasksString = prefs.getString('tasks');

      if (tasksString != null) {
        List<dynamic> jsonData = jsonDecode(tasksString);
        List<Task> loadedTasks =
            jsonData.map((json) => Task.fromJson(json)).toList();
        emit(TaskState(loadedTasks));
      }
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      final updatedTasks = List<Task>.from(state.tasks)
        ..add(Task(title: event.title));
      print(state.tasks.toList());
      await _saveTasks(updatedTasks);
      emit(TaskState(updatedTasks));
    } catch (e, stackTrace) {
      print('Error adding task: $e\n$stackTrace');
    }
  }

  Future<void> _toggleTask(ToggleTask event, Emitter<TaskState> emit) async {
    try {
      final updatedTasks = List<Task>.from(state.tasks);
      updatedTasks[event.index].isCompleted =
          !updatedTasks[event.index].isCompleted;
      await _saveTasks(updatedTasks);
      emit(TaskState(updatedTasks));
    } catch (e, stackTrace) {
      print('Error toggling task: $e\n$stackTrace');
    }
  }

  Future<void> _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      final updatedTasks = List<Task>.from(state.tasks)..removeAt(event.index);
      await _saveTasks(updatedTasks);
      emit(TaskState(updatedTasks));
    } catch (e, stackTrace) {
      print('Error deleting task: $e\n$stackTrace');
    }
  }

  Future<void> _saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'tasks', jsonEncode(tasks.map((t) => t.toJson()).toList()));
    } catch (e, stackTrace) {
      print('Error saving tasks: $e\n$stackTrace');
    }
  }
}
