import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/Home/models/order/order.dart' as order;

import '../../../core/Provider/selected_order_provider.dart';

class StepThreeScreen extends StatefulWidget {
  final screen = _StepThreeScreen();
  StepThreeScreen({super.key, required this.slotSelected});
  Function(DateTime date, TimeOfDay? time, String displaySlot) slotSelected;

  @override
  State<StepThreeScreen> createState() => _StepThreeScreen();
}

class _StepThreeScreen extends State<StepThreeScreen> {
  SelectedOrderState? selectedOrder;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    final selectedOrder =
        Provider.of<SelectedOrderState>(context, listen: false);

    order.Order orderObject = selectedOrder.getOrder;

    bool dateTimePresent = orderObject.booked?.bookedDate != null;

    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    //Future.delayed(Duration(seconds: 1));
    if (dateTimePresent) {
      String datePresent = orderObject.booked!.bookedDate.toString();
      String timePresent = orderObject.booked!.bookedSlot.toString();
      selectedDate = DateFormat("dd-MM-yyyy").parse(datePresent);
      var tempHour = timePresent.split("-")[0].trim();
      var tempMin = timePresent.split("-")[1].trim();
      selectedTime = TimeOfDay(
          hour: int.parse(tempHour.substring(0, tempHour.length - 2)),
          minute: int.parse(tempMin.substring(0, tempMin.length - 2)));
      //selectedTime = TimeOfDay(hour: 00, minute: 00);
      Future.delayed(Duration.zero, () {
        _selectDate(selectedDate!);
      });
      Future.delayed(Duration.zero, () {
        selectedTime = TimeOfDay(
            hour: int.parse(tempHour.substring(0, tempHour.length - 2)),
            minute: int.parse(tempMin.substring(0, tempMin.length - 2)));
        _selectTime(selectedTime!);
      });
    }
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
      selectedTime = null;
      widget.slotSelected(selectedDate!, selectedTime, "");
    });
  }

  void _selectTime(TimeOfDay time) {
    setState(() {
      selectedTime = time;

      final diasplaySlot =
          _formatTimeRange(time, TimeOfDay(hour: time.hour + 1, minute: 0));
      widget.slotSelected(selectedDate!, selectedTime!, diasplaySlot);
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
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.secondary,
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
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            //'${time.hour}:00',
            _formatTimeRange(start, end),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedOrder =
        Provider.of<SelectedOrderState>(context, listen: true);
    //order.Order orderObject = selectedOrder.getOrder;

    final List<DateTime> nextSixDates = List<DateTime>.generate(
      7,
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Select Date',
              style: Theme.of(context).textTheme.headlineMedium),
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Select Time',
              style: Theme.of(context).textTheme.headlineMedium),
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
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_sharp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'No available slots. Please check for the next day slots',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 3.0,
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 100.0),
        //   child: ElevatedButton(
        //     onPressed: () {
        //       print('Selected Date: $selectedDate');
        //       print('Selected Time: $selectedTime');
        //     },
        //     child: const Text("Book Slot"),
        //     style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //         borderRadius:
        //             BorderRadius.circular(10.0), // Set the border radius value
        //       ),
        //       backgroundColor: Theme.of(context).colorScheme.primary,
        //       padding: const EdgeInsets.symmetric(
        //         horizontal: 45.0,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
