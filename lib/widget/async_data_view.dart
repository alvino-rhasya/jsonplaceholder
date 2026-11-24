import 'package:flutter/material.dart';

class AsyncDataView<T> extends StatefulWidget {
  final String title;
  final Future<List<T>> Function() onFetch;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool Function(T item, String query)? searchFilter;

  const AsyncDataView({
    super.key,
    required this.title,
    required this.onFetch,
    required this.itemBuilder,
    this.searchFilter,
  });

  @override
  State<AsyncDataView<T>> createState() => _AsyncDataViewState<T>();
}

class _AsyncDataViewState<T> extends State<AsyncDataView<T>> {
  late Future<List<T>> _future;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _future = widget.onFetch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _future = widget.onFetch();
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        // 1. Loading Skeleton State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 850),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 90,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 220,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        // 2. Error State
        if (snapshot.hasError) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Card(
                margin: const EdgeInsets.all(24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.cloud_off_rounded,
                          size: 42,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Gagal Memuat ${widget.title}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 22),
                      FilledButton.icon(
                        onPressed: _handleRefresh,
                        icon: const Icon(Icons.refresh_rounded, size: 18),
                        label: const Text('Coba Lagi'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // 3. Data Processing & Filter
        final allItems = snapshot.data ?? [];
        final items = widget.searchFilter == null || _searchQuery.isEmpty
            ? allItems
            : allItems
                .where((item) => widget.searchFilter!(item, _searchQuery))
                .toList();

        // 4. Success State (Responsive + Pull to Refresh)
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 850;

            return RefreshIndicator(
              color: const Color(0xFF6366F1),
              onRefresh: _handleRefresh,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 850 : double.infinity,
                  ),
                  child: Column(
                    children: [
                      // Header Search & Counter Pill
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.02),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Cari ${widget.title}...',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      size: 20,
                                      color: Color(0xFF6366F1),
                                    ),
                                    suffixIcon: _searchQuery.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.clear_rounded, size: 16),
                                            onPressed: () {
                                              setState(() {
                                                _searchController.clear();
                                                _searchQuery = '';
                                              });
                                            },
                                          )
                                        : null,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _searchQuery = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF6366F1).withValues(alpha: 0.1),
                                    const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF6366F1).withValues(alpha: 0.25),
                                ),
                              ),
                              child: Text(
                                '${items.length} item',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6366F1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Subheader Bar matching Mockup (Total: [Title] [Count] & Tarik ke bawah untuk refresh)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: ${widget.title} ${items.length}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Tarik ke bawah untuk refresh',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // List Content or Empty State
                      Expanded(
                        child: items.isEmpty
                            ? ListView(
                                children: [
                                  SizedBox(
                                    height: constraints.maxHeight * 0.55,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.search_off_rounded,
                                              size: 48,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          Text(
                                            _searchQuery.isNotEmpty
                                                ? 'Tidak ada hasil untuk "$_searchQuery"'
                                                : 'Data ${widget.title} kosong',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return widget.itemBuilder(context, items[index], index);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
