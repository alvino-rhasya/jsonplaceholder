import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/todos.dart';

class TodoWidget extends StatefulWidget {
  final Todos todos;

  const TodoWidget({super.key, required this.todos});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.todos.completed;
  }

  @override
  void didUpdateWidget(covariant TodoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.todos.completed != widget.todos.completed) {
      _isCompleted = widget.todos.completed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _isCompleted ? const Color(0xFF10B981) : const Color(0xFFF59E0B);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          setState(() {
            _isCompleted = !_isCompleted;
          });
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1000),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: Text(
                _isCompleted
                    ? 'Todo #${widget.todos.id} ditandai selesai'
                    : 'Todo #${widget.todos.id} ditandai belum selesai',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Animated Checkbox Icon
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  _isCompleted
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: statusColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Title and Meta Badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todos.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: _isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: _isCompleted
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF0F172A),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _isCompleted ? 'Selesai' : 'Belum Selesai',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            'User #${widget.todos.userId}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
