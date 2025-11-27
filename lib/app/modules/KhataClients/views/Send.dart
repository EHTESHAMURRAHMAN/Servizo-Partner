import 'package:flutter/material.dart';

class SendAmountPage extends StatefulWidget {
  const SendAmountPage({super.key});

  @override
  State<SendAmountPage> createState() => _SendAmountPageState();
}

class _SendAmountPageState extends State<SendAmountPage> {
  String amount = "300";
  String note = "";
  DateTime selectedDate = DateTime(2025, 9, 10);

  final TextEditingController noteController = TextEditingController();

  void _onKeyTap(String key) {
    setState(() {
      if (key == "⌫") {
        if (amount.isNotEmpty) amount = amount.substring(0, amount.length - 1);
      } else if (key == "=") {
        // For demo, just keep amount unchanged
      } else {
        if (!(key == '.' && amount.contains('.'))) {
          amount += key;
        }
      }
    });
  }

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

          // Amount Entry
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₹',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 3),
              Text(
                amount.isEmpty ? "0" : amount,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Divider(thickness: 1, height: 1, color: Colors.grey[300]),

          // Date Picker
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

          // Add Images & Create Bills Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.add_a_photo, color: Colors.green),
                    label: Text(
                      "Add Images",
                      style: TextStyle(color: Colors.green),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 28),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                "Create Bills",
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'NEW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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

          // Custom Keypad
          Spacer(),
          _buildKeypad(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildKeypad() {
    const keys = [
      ["1", "2", "3", "⌫"],
      ["4", "5", "6", "×"],
      ["7", "8", "9", "−"],
      [".", "0", "=", "+"],
    ];
    final keyColors = {
      "⌫": Colors.red.shade100,
      "=": Colors.green.shade100,
      "+": Colors.green.shade100,
      "−": Colors.green.shade100,
      "×": Colors.green.shade100,
    };
    final textColors = {
      "⌫": Colors.red.shade400,
      "=": Colors.green.shade800,
      "+": Colors.green.shade800,
      "−": Colors.green.shade800,
      "×": Colors.green.shade800,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0, left: 10, right: 10),
      child: Column(
        children:
            keys.map((row) {
              return Row(
                children:
                    row.map((key) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color:
                                keyColors.containsKey(key)
                                    ? keyColors[key]
                                    : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () => _onKeyTap(key),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 52,
                                alignment: Alignment.center,
                                child:
                                    key == "⌫"
                                        ? Icon(
                                          Icons.backspace,
                                          color: textColors[key],
                                        )
                                        : Text(
                                          key,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                textColors[key] ?? Colors.black,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              );
            }).toList(),
      ),
    );
  }
}
