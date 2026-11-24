import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/users.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/user_widget.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  String _selectedFilter = 'semua'; // 'semua', 'aktif', 'bisnis'

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Filter Bar Matching Mockup
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(
                      id: 'semua',
                      label: 'Semua',
                      icon: Icons.check_rounded,
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      id: 'aktif',
                      label: 'Aktif (8)',
                      dotColor: const Color(0xFF0EA5E9),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      id: 'bisnis',
                      label: 'Tim Bisnis',
                      icon: Icons.apartment_rounded,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Icon(
                        Icons.bookmark_outline_rounded,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E1B4B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'MENAMPILKAN DAFTAR KONTAK TERPILIH',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E1B4B),
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // List View
        Expanded(
          child: AsyncDataView<Users>(
            title: 'Users',
            onFetch: () async {
              final users = await ApiService.fetchUsers();
              if (_selectedFilter == 'aktif') {
                return users.where((u) => u.id <= 8).toList();
              } else if (_selectedFilter == 'bisnis') {
                return users.where((u) => u.company.name.isNotEmpty).toList();
              }
              return users;
            },
            searchFilter: (user, query) {
              final q = query.toLowerCase();
              return user.name.toLowerCase().contains(q) ||
                  user.username.toLowerCase().contains(q) ||
                  user.email.toLowerCase().contains(q) ||
                  user.company.name.toLowerCase().contains(q);
            },
            itemBuilder: (context, user, index) {
              return UserWidget(users: user);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String id,
    required String label,
    IconData? icon,
    Color? dotColor,
  }) {
    final isSelected = _selectedFilter == id;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        setState(() {
          _selectedFilter = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1B4B) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E1B4B) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dotColor != null) ...[
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
            ] else if (icon != null) ...[
              Icon(icon, size: 14, color: isSelected ? Colors.white : const Color(0xFF64748B)),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
