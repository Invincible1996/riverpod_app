import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ToDoList extends ConsumerWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Card(
            child: ListTile(
              title: Text(todo.description),
              trailing: IconButton(
                onPressed: () {
                  ref.read(todoListProvider.notifier).removeTodo(todo.id);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('New Todo'),
              content: Form(
                key: ref.watch(todoListProvider.notifier).formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                  controller:
                      ref.read(todoListProvider.notifier).textController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (ref
                        .read(todoListProvider.notifier)
                        .formKey
                        .currentState!
                        .validate()) {
                      return;
                    }
                    Navigator.of(context).pop();
                    ref.read(todoListProvider.notifier).addTodo(
                          Todo(
                            id: const Uuid().v4(),
                            description: ref
                                .read(
                                  todoListProvider.notifier,
                                )
                                .textController
                                .text,
                            completed: false,
                          ),
                        );
                  },
                  child: const Text('add'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// @immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

// use riverpod to manage state
final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  var textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TodoListNotifier() : super([]);

  addTodo(Todo todo) {
    state = [...state, todo];
    // add success clear text
    textController.clear();
  }

  removeTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo
    ];
  }
}
