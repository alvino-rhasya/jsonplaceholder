import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsonplaceholder/model/users.dart';

class UserWidget extends StatefulWidget {
  final Users users;

  const UserWidget({super.key, required this.users});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  bool _isBookmarked = false;

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final users = widget.users;

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header: Avatar with Online Dot, Name with Verified, Subtitle with ID, and Bookmark
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFF1E1B4B), // Deep navy
                      child: Text(
                        _getInitials(users.name),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981), // Online green
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              users.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.verified_rounded,
                            size: 18,
                            color: Color(0xFF2563EB),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '@${users.username}',
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              'ID: #${users.id.toString().padLeft(3, '0')}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF334155),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    color: _isBookmarked ? const Color(0xFF1E1B4B) : const Color(0xFF64748B),
                  ),
                  onPressed: () {
                    setState(() {
                      _isBookmarked = !_isBookmarked;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 2. Company Container Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        users.company.name.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: Color(0xFF0284C7), // Teal/Cyan branding
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        users.company.bs,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '“${users.company.catchPhrase}”',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12.5,
                      color: Color(0xFF475569),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. Contact Rows with Clean Icon Badges & Trailing Actions
            _buildContactRow(
              context: context,
              icon: Icons.mail_outline_rounded,
              iconColor: const Color(0xFF2563EB),
              badgeBg: const Color(0xFFEFF6FF),
              label: 'SUREL PERUSAHAAN',
              value: users.email,
              trailing: IconButton(
                icon: const Icon(Icons.copy_rounded, size: 16, color: Color(0xFF94A3B8)),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: users.email));
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email ${users.email} berhasil disalin!'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            _buildContactRow(
              context: context,
              icon: Icons.phone_outlined,
              iconColor: const Color(0xFF0284C7),
              badgeBg: const Color(0xFFF0F9FF),
              label: 'TELEPON KERJA',
              value: users.phone,
              trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 12),
            _buildContactRow(
              context: context,
              icon: Icons.language_rounded,
              iconColor: const Color(0xFF6366F1),
              badgeBg: const Color(0xFFEEF2FF),
              label: 'SITUS WEB',
              value: users.website,
              isLink: true,
              trailing: const Icon(Icons.open_in_new_rounded, size: 16, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 12),
            _buildContactRow(
              context: context,
              icon: Icons.location_on_outlined,
              iconColor: const Color(0xFFE11D48),
              badgeBg: const Color(0xFFFFF1F2),
              label: 'ALAMAT KANTOR',
              value: '${users.address.suite}, ${users.address.street}, ${users.address.city}',
              extra: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Kode Pos: ${users.address.zipcode}',
                      style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Geo: ${users.address.geo.lat}, ${users.address.geo.lng}',
                      style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 4. Map Preview Card
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFFEDE9FE), Color(0xFFDDD6FE), Color(0xFFC7D2FE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        color: Color(0xFF6366F1),
                        size: 26,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 15,
                              color: Color(0xFFE11D48),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${users.address.city} District',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => _showMapDetails(context, users),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            child: Row(
                              children: [
                                Text(
                                  'Buka Peta',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4338CA),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(Icons.north_east_rounded, size: 14, color: Color(0xFF4338CA)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // 5. Action Buttons (Hubungi + Lihat Profil)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Membuka obrolan dengan ${users.name}...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: Colors.white),
                    label: const Text(
                      'Hubungi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1B4B), // Deep navy
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showUserDetail(context, users),
                    icon: const Icon(Icons.person_outline_rounded, size: 16, color: Color(0xFF1E293B)),
                    label: const Text(
                      'Lihat Profil',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F5F9), // Soft slate
                      foregroundColor: const Color(0xFF1E293B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color badgeBg,
    required String label,
    required String value,
    bool isLink = false,
    Widget? trailing,
    Widget? extra,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: badgeBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: isLink ? const Color(0xFF4F46E5) : const Color(0xFF1E293B),
                ),
              ),
              ?extra,
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }

  void _showMapDetails(BuildContext context, Users users) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFFE11D48)),
            const SizedBox(width: 8),
            Text('${users.address.city} District', style: const TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alamat: ${users.address.suite}, ${users.address.street}'),
            Text('Kota: ${users.address.city}'),
            Text('Kode Pos: ${users.address.zipcode}'),
            const SizedBox(height: 10),
            Text('Latitude: ${users.address.geo.lat}'),
            Text('Longitude: ${users.address.geo.lng}'),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showUserDetail(BuildContext context, Users users) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: const Color(0xFF1E1B4B),
                        child: Text(
                          _getInitials(users.name),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    users.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified_rounded, size: 18, color: Color(0xFF2563EB)),
                              ],
                            ),
                            Text(
                              '@${users.username} • ID: #${users.id.toString().padLeft(3, '0')}',
                              style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text('INFORMASI PERUSAHAAN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                  const SizedBox(height: 8),
                  Text('Nama Perusahaan: ${users.company.name}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text('Slogan: "${users.company.catchPhrase}"', style: const TextStyle(fontStyle: FontStyle.italic)),
                  Text('Bidang Bisnis: ${users.company.bs}'),
                  const Divider(height: 32),
                  const Text('INFORMASI KONTAK & LOKASI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                  const SizedBox(height: 8),
                  Text('Email: ${users.email}'),
                  Text('Telepon: ${users.phone}'),
                  Text('Website: ${users.website}'),
                  Text('Alamat: ${users.address.suite}, ${users.address.street}, ${users.address.city}'),
                  Text('Kode Pos: ${users.address.zipcode}'),
                  Text('Geo Koordinat: ${users.address.geo.lat}, ${users.address.geo.lng}'),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF1E1B4B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
