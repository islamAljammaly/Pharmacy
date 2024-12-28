import 'package:flutter/material.dart';

import '../../modle/medicine.dart';

class BuildMedicineItem extends StatelessWidget {
  final BuildContext context;
  final Medicine medicine;
  const BuildMedicineItem({super.key, required this.context, required this.medicine});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade100,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.network(
                medicine.image!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(medicine.name!),
              Text('${medicine.price} \$'),
            ],
          ),
        ],
      ),
    );
  }
}