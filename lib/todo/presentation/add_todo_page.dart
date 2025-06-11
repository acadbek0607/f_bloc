import 'package:f_bloc/todo/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final todoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: todoTitleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                /*BlocProvider.of<TodoCubit>(
                  context,
                ).addTodo(
                  todoTitleController.text.trim(),
                );*/
                context.read<TodoCubit>().addTodo(
                  todoTitleController.text.trim(),
                );
                Navigator.of(context).pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
