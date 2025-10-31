import 'package:flutter/material.dart';

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
              "Step 1 of 4",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.25,
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
                  // TODO: lanjut ke step berikutnya
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
