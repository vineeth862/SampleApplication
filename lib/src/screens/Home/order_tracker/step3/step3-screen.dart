import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StepThreeScreen extends StatefulWidget {
  const StepThreeScreen({super.key});

  @override
  State<StepThreeScreen> createState() => _StepThreeScreen();
}

class _StepThreeScreen extends State<StepThreeScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  void _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _selectTime(TimeOfDay time) {
    setState(() {
      selectedTime = time;
    });
  }

  Widget _buildDateItem(DateTime date) {
    final bool isSelected = selectedDate!.year == date.year &&
        selectedDate!.month == date.month &&
        selectedDate!.day == date.day;

    return GestureDetector(
      onTap: () {
        _selectDate(date);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.black12,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('MMM d').format(date),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeRange(TimeOfDay start, TimeOfDay end) {
    final formattedStart = DateFormat('ha').format(DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      start.hour,
      start.minute,
    ));
    final formattedEnd = DateFormat('ha').format(DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      end.hour,
      end.minute,
    ));

    return '$formattedStart - $formattedEnd';
  }

  Widget _buildTimeItem(TimeOfDay start, TimeOfDay end) {
    //final bool isSelected =
    //     selectedTime!.hour == time.hour && selectedTime!.minute == time.minute;
    final bool isSelected = selectedTime == start;
    // String formattedTime = DateFormat('h:mm a').format(DateTime(
    //   DateTime.now().year,
    //   DateTime.now().month,
    //   DateTime.now().day,
    //   time.hour,
    //   time.minute,
    // ));
    return GestureDetector(
      onTap: () {
        _selectTime(start);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.black12,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          //'${time.hour}:00',
          _formatTimeRange(start, end),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> nextSixDates = List<DateTime>.generate(
      5,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    final List<TimeOfDay> availableTimes = List<TimeOfDay>.generate(
      12,
      (index) => TimeOfDay(hour: index + 6, minute: 0),
    ).where((time) {
      final currentTime = DateTime.now();
      final selectedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        time.hour,
        time.minute,
      );

      // Allow selecting a time that is two hours away from the current hour
      return selectedDateTime
          .isAfter(currentTime.add(const Duration(hours: 3)));
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Select Date',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final date in nextSixDates)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildDateItem(date),
                ),
            ],
          ),
        ),
        // ListTile(
        //   title: const Text('Selected Date:'),
        //   subtitle: Text(DateFormat('EEE, MMM d')
        //       .format(selectedDate ?? DateTime.now())),
        // ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Select Time',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       for (final time in availableTimes)
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: _buildTimeItem(time),
        //         ),
        //     ],
        //   ),
        // ),
        availableTimes.isEmpty
            ? const Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No available times to show.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            : SizedBox(
                height: 280,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 2.0,
                  padding: EdgeInsets.all(8.0),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 4.0,
                  children: List.generate(availableTimes.length, (index) {
                    final start = availableTimes[index];
                    final end = availableTimes[index].replacing(
                      hour: availableTimes[index].hour + 1,
                    );
                    return _buildTimeItem(start, end);
                  }),
                ),
              ),

        // ListTile(
        //   title: const Text('Selected Date:'),
        //   subtitle: Text(DateFormat('EEE, MMM d')
        //       .format(selectedDate ?? DateTime.now())),
        // ),
        // ListTile(
        //   title: const Text('Selected Time:'),
        //   subtitle: Text(selectedTime!.format(context)),
        //   // trailing: const Icon(Icons.access_time),
        //   // onTap: _showTimePicker,
        // ),

        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: ElevatedButton(
            onPressed: () {
              print('Selected Date: $selectedDate');
              print('Selected Time: $selectedTime');
            },
            child: const Text("Book Slot"),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the border radius value
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
