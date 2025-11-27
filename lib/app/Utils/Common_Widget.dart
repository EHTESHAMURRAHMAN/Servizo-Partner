import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Widget backButton() {
  return InkWell(
    onTap: () => Get.back(),
    child: const Icon(Icons.arrow_back_ios),
  );
}

Widget heading(String title, String title2) {
  return Text(
    '${title.tr} ${title2.tr}',
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  );
}

class CustomerCard extends StatelessWidget {
  final String name;
  final String amountDue;
  final String note;
  final VoidCallback onDelete;
  final Color amountColor;

  const CustomerCard({
    super.key,
    required this.name,
    required this.amountDue,
    required this.note,
    required this.onDelete,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Get.theme.canvasColor,
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff850000),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      amountDue,
                      style: TextStyle(
                        color: amountColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(note, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void customSnackBar({
  int? positin,
  required int type,
  required String status,
  required String message,
}) {
  Get.snackbar(
    status,
    message,
    icon: Icon(
      type == 1 ? Icons.check_circle : Icons.cancel,
      color: Colors.white,
    ),
    snackPosition: positin == 1 ? SnackPosition.BOTTOM : SnackPosition.TOP,
    backgroundColor: type == 1 ? Color(0xff016D48) : Colors.red.shade900,
    borderRadius: 20,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    colorText: Colors.white,
    duration: Duration(seconds: 3),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeInToLinear,
  );
}

Widget noData() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(75),
          child: Lottie.asset(
            'assets/animations/nodata.json',
            repeat: false,
            height: 150,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'No Data',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
