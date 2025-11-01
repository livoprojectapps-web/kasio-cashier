import 'dart:ui';
import 'package:flutter/material.dart';

// =====================
// Halaman 3
// =====================
class BusinessInfoPage extends StatefulWidget {
  const BusinessInfoPage({super.key});

  @override
  State<BusinessInfoPage> createState() => _BusinessInfoPageState();
}

class _BusinessInfoPageState extends State<BusinessInfoPage> {
  bool useCurrentLocation = false;
  String? selectedBusinessType;

  final List<String> businessTypes = [
    'Kopi / Kafe',
    'Restoran',
    'Toko Retail',
    'Barbershop',
    'Laundry',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C140F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C140F),
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text(
          "Informasi Usaha",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar step
            const Text(
              "Step 3 of 4",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.75,
                color: Colors.orange,
                backgroundColor: Colors.white10,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Lengkapi Informasi Usaha Anda",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),

            // Nama Pemilik
            _buildInputField(
              label: "Nama Pemilik",
              hint: "Contoh: Budi Santoso",
            ),

            // Nama Usaha
            _buildInputField(
              label: "Nama Usaha",
              hint: "Contoh: Kopi Kenangan",
            ),

            // Jenis Usaha Dropdown
            const SizedBox(height: 12),
            const Text(
              "Jenis Usaha",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C241E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xFF2C241E),
                  isExpanded: true,
                  value: selectedBusinessType,
                  hint: const Text(
                    "Pilih Jenis Usaha",
                    style: TextStyle(color: Colors.white54),
                  ),
                  items: businessTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedBusinessType = value);
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Lokasi toggle
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C241E),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.location_pin, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        "Gunakan Lokasi Saat Ini",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Switch(
                    activeColor: Colors.orange,
                    value: useCurrentLocation,
                    onChanged: (val) {
                      setState(() => useCurrentLocation = val);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Alamat
            _buildInputField(
              label: "Alamat",
              hint: "Masukkan alamat lengkap usaha",
            ),

            // Kota
            _buildInputField(label: "Kota", hint: "Masukkan kota"),

            // Provinsi
            _buildInputField(label: "Provinsi", hint: "Masukkan provinsi"),

            const SizedBox(height: 30),

            // Tombol lanjut
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: "Verify",
                    barrierColor: Colors.transparent,
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (_, __, ___) => const VerifyIdentityPage(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 6),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color(0xFF2C241E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================
// Halaman 4 (Overlay OTP)
// =====================
class VerifyIdentityPage extends StatefulWidget {
  const VerifyIdentityPage({super.key});

  @override
  State<VerifyIdentityPage> createState() => _VerifyIdentityPageState();
}

class _VerifyIdentityPageState extends State<VerifyIdentityPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.orange.shade600.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade900.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // agar blur terlihat
      body: Stack(
        children: [
          // Efek blur pada background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Overlay OTP
          Center(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade700,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.shade900.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Verify Your Identity",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please select where you'd like to receive your one-time password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      _buildOption(
                        icon: Icons.email_outlined,
                        title: "Email",
                        onTap: () {},
                      ),
                      _buildOption(
                        icon: Icons.chat_outlined,
                        title: "WhatsApp",
                        onTap: () {},
                      ),
                      _buildOption(
                        icon: Icons.alternate_email_outlined,
                        title: "Gmail",
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
