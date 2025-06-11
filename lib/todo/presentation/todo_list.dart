import 'package:f_bloc/todo/cubit/todo_cubit.dart';
import 'package:f_bloc/todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: ListTile(title: Text(todo.name)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-todo'),
        tooltip: "Add Todo",
        child: Icon(Icons.add),
      ),
    );
  }
}
