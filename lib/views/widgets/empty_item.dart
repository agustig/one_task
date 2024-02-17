import 'package:flutter/material.dart';

/// Menampilkan pesan ketika item task atau note kosong
class EmptyItem extends StatelessWidget {
  const EmptyItem({
    Key? key,
    required this.title,
    required this.subTitle,
    this.negativeHeight,
  }) : super(key: key);

  /// Judul pesan
  final String title;

  /// Sub judul pesan
  final String subTitle;

  /// Nilai tinggi halaman yang dipakai sliver appBar
  ///
  /// Kosongkan jika tidak menggunakan sliver appBar
  final double? negativeHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: negativeHeight != null
          ? MediaQuery.of(context).size.height - negativeHeight!
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
