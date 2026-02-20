import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        leading: Container(width: 50, height: 50, color: Colors.white),
        title: Container(width: double.infinity, height: 10, color: Colors.white),
        subtitle: Container(width: double.infinity, height: 10, color: Colors.white),
        trailing: Container(width: 20, height: 20, color: Colors.white),
      ),
    );
  }
}
