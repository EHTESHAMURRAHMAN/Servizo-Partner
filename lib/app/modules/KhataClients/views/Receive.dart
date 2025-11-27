import 'package:flutter/material.dart';

class ReceiveAmountPage extends StatefulWidget {
  const ReceiveAmountPage({super.key});

  @override
  State<ReceiveAmountPage> createState() => _ReceiveAmountPageState();
}

class _ReceiveAmountPageState extends State<ReceiveAmountPage> {
  String note = "";
  DateTime selectedDate = DateTime(2025, 9, 10);

  final TextEditingController noteController = TextEditingController();
  final TextEditingController amount = TextEditingController();

  void _onAddNote(String val) {
    setState(() {
      note = val;
    });
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formattedDate() {
    return "${_monthName(selectedDate.month)} ${selectedDate.day}, ${selectedDate.year}";
  }

  String _monthName(int number) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[number - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        elevation: 0.3,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                'F',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Faizan Bhai",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  "₹500",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.security, color: Colors.grey[600], size: 30),
            SizedBox(width: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    "SECURED",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.5,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(Icons.lock, size: 16, color: Colors.blueAccent),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          TextFormField(
            controller: amount,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: '0.0',
              fillColor: Colors.transparent,
              prefixText: '₹',
              prefixStyle: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
          ),

          SizedBox(height: 14),
          Divider(thickness: 1, height: 1, color: Colors.grey[300]),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: InkWell(
              onTap: _pickDate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      _formattedDate(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Only Add Images Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: OutlinedButton.icon(
              icon: Icon(Icons.add_a_photo, color: Colors.green),
              label: Text("Add Images", style: TextStyle(color: Colors.green)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
            ),
          ),
          // Optional Note Input
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: noteController,
                    onChanged: _onAddNote,
                    decoration: InputDecoration(
                      hintText: "Add Note (Optional)",
                      prefixIcon: Icon(Icons.note_add),
                      suffixIcon: Icon(Icons.mic_none),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: Icon(Icons.check, color: Colors.white, size: 28),
                    onPressed: () {
                      // Submit functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
