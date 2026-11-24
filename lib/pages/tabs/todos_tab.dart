import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/todos.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/todo_widget.dart';

class TodosTab extends StatelessWidget {
  const TodosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Todos>(
      title: 'Todos',
      onFetch: ApiService.fetchTodos,
      searchFilter: (todo, query) {
        return todo.title.toLowerCase().contains(query.toLowerCase());
      },
      itemBuilder: (context, todo, index) {
        return TodoWidget(todos: todo);
      },
    );
  }
}
