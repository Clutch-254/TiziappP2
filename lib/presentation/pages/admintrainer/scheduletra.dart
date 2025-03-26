import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClientAppointment {
  final String clientName;
  final String clientPhotoUrl;
  final DateTime startTime;
  final DateTime endTime;
  final String sessionType;
  final String location;
  final bool isConfirmed;

  ClientAppointment({
    required this.clientName,
    required this.clientPhotoUrl,
    required this.startTime,
    required this.endTime,
    required this.sessionType,
    required this.location,
    required this.isConfirmed,
  });
}

class Scheduletra extends StatefulWidget {
  const Scheduletra({super.key});

  @override
  State<Scheduletra> createState() => _ScheduletraState();
}

class _ScheduletraState extends State<Scheduletra> {
  // Grey color scheme
  final Color primaryGrey = const Color(0xFF616161);
  final Color lightGrey = const Color(0xFF9E9E9E);
  final Color veryLightGrey = const Color(0xFFE0E0E0);
  final Color backgroundGrey = const Color(0xFFF5F5F5);

  // Current date selection
  DateTime _selectedDate = DateTime.now();
  int _selectedViewIndex = 0; // 0: Day, 1: Week, 2: Month

  // List of views
  final List<String> _viewOptions = ['Day', 'Week', 'Month'];

  // Time slots for day view
  final List<String> _timeSlots = [
    '6:00 AM',
    '7:00 AM',
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM'
  ];

  // Days of the week for week view
  List<DateTime> _getDaysOfWeek() {
    DateTime startOfWeek =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    List<DateTime> days = [];
    for (int i = 0; i < 7; i++) {
      days.add(startOfWeek.add(Duration(days: i)));
    }
    return days;
  }

  // Sample appointments
  final List<ClientAppointment> _appointments = [
    ClientAppointment(
      clientName: 'James Otuke',
      clientPhotoUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      startTime: DateTime.now().add(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      sessionType: 'Strength Training',
      location: 'Main Gym',
      isConfirmed: true,
    ),
    ClientAppointment(
      clientName: 'Sarah Kiatu',
      clientPhotoUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      startTime: DateTime.now().add(const Duration(hours: 3)),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      sessionType: 'Flexibility',
      location: 'Studio Room',
      isConfirmed: true,
    ),
    ClientAppointment(
      clientName: 'Michael Mwangi',
      clientPhotoUrl: 'https://randomuser.me/api/portraits/men/55.jpg',
      startTime: DateTime.now().add(const Duration(hours: 5)),
      endTime: DateTime.now().add(const Duration(hours: 6)),
      sessionType: 'Muscle Building',
      location: 'Weight Room',
      isConfirmed: false,
    ),
    ClientAppointment(
      clientName: 'Lisa Ngeje',
      clientPhotoUrl: 'https://randomuser.me/api/portraits/women/67.jpg',
      startTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 3)),
      sessionType: 'Cardio',
      location: 'Track Field',
      isConfirmed: true,
    ),
    ClientAppointment(
      clientName: 'David Tole',
      clientPhotoUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
      startTime: DateTime.now().add(const Duration(days: 1, hours: 4)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 5)),
      sessionType: 'Sports Performance',
      location: 'Main Gym',
      isConfirmed: true,
    ),
    ClientAppointment(
      clientName: 'Jennifer Mutembei',
      clientPhotoUrl: 'https://randomuser.me/api/portraits/women/28.jpg',
      startTime: DateTime.now().add(const Duration(days: 2, hours: 1)),
      endTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
      sessionType: 'Weight Loss',
      location: 'Cardio Room',
      isConfirmed: false,
    ),
  ];

  // Get appointments for a specific date
  List<ClientAppointment> _getAppointmentsForDate(DateTime date) {
    return _appointments.where((appointment) {
      return appointment.startTime.year == date.year &&
          appointment.startTime.month == date.month &&
          appointment.startTime.day == date.day;
    }).toList();
  }

  // Get appointments for a specific time slot
  List<ClientAppointment> _getAppointmentsForTimeSlot(
      String timeSlot, DateTime date) {
    final format = DateFormat('h:mm a');
    final time = format.parse(timeSlot);

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    return _appointments.where((appointment) {
      return appointment.startTime.year == dateTime.year &&
          appointment.startTime.month == dateTime.month &&
          appointment.startTime.day == dateTime.day &&
          appointment.startTime.hour == dateTime.hour;
    }).toList();
  }

  // Change the selected date
  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  // Change the view (Day/Week/Month)
  void _changeView(int index) {
    setState(() {
      _selectedViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Schedule'),
        backgroundColor: primaryGrey,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter schedule feature'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Schedule settings feature'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: backgroundGrey,
        child: Column(
          children: [
            // Calendar header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: veryLightGrey),
                ),
              ),
              child: Column(
                children: [
                  // Date selection and navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => _changeDate(-1),
                        color: primaryGrey,
                      ),
                      Column(
                        children: [
                          Text(
                            _selectedViewIndex == 0
                                ? DateFormat('EEEE, MMMM d, y')
                                    .format(_selectedDate)
                                : _selectedViewIndex == 1
                                    ? 'Week of ${DateFormat('MMMM d').format(_getDaysOfWeek().first)}'
                                    : DateFormat('MMMM y')
                                        .format(_selectedDate),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryGrey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Today: ${DateFormat('MMM d').format(DateTime.now())}',
                            style: TextStyle(
                              fontSize: 14,
                              color: lightGrey,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () => _changeDate(1),
                        color: primaryGrey,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // View selection (Day/Week/Month)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _viewOptions.length,
                      (index) => _buildViewOption(index),
                    ),
                  ),
                ],
              ),
            ),

            // Calendar content
            Expanded(
              child: _selectedViewIndex == 0
                  ? _buildDayView()
                  : _selectedViewIndex == 1
                      ? _buildWeekView()
                      : _buildMonthView(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryGrey,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add new appointment feature'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Build view option button
  Widget _buildViewOption(int index) {
    final bool isSelected = index == _selectedViewIndex;
    return GestureDetector(
      onTap: () => _changeView(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? primaryGrey : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _viewOptions[index],
          style: TextStyle(
            color: isSelected ? Colors.white : primaryGrey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Build day view
  Widget _buildDayView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _timeSlots.length,
      itemBuilder: (context, index) {
        final timeSlot = _timeSlots[index];
        final appointments =
            _getAppointmentsForTimeSlot(timeSlot, _selectedDate);

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time slot
                SizedBox(
                  width: 80,
                  child: Text(
                    timeSlot,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryGrey,
                    ),
                  ),
                ),

                // Vertical line
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: 1,
                  height: appointments.isEmpty ? 60 : null,
                  color: veryLightGrey,
                ),

                // Appointments for this time slot
                Expanded(
                  child: appointments.isEmpty
                      ? const SizedBox(height: 60)
                      : Column(
                          children: appointments
                              .map((appointment) =>
                                  _buildAppointmentCard(appointment))
                              .toList(),
                        ),
                ),
              ],
            ),

            // Horizontal divider
            Divider(
              color: veryLightGrey,
              height: 16,
              thickness: 1,
            ),
          ],
        );
      },
    );
  }

  // Build week view
  Widget _buildWeekView() {
    final daysOfWeek = _getDaysOfWeek();

    return Column(
      children: [
        // Week days header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: veryLightGrey),
            ),
          ),
          child: Row(
            children: daysOfWeek.map((day) {
              final isToday = day.day == DateTime.now().day &&
                  day.month == DateTime.now().month &&
                  day.year == DateTime.now().year;

              return Expanded(
                child: Column(
                  children: [
                    Text(
                      DateFormat('E').format(day),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday ? primaryGrey : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: isToday ? Colors.white : primaryGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        // Week view content
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: daysOfWeek.length,
            itemBuilder: (context, index) {
              final day = daysOfWeek[index];
              final appointments = _getAppointmentsForDate(day);

              if (appointments.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, MMMM d').format(day),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryGrey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...appointments
                            .map((appointment) => _buildAppointmentCard(
                                appointment,
                                showDate: false))
                            .toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Build month view
  Widget _buildMonthView() {
    // Get first day of month
    final firstDay = DateTime(_selectedDate.year, _selectedDate.month, 1);
    // Get last day of month
    final lastDay = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    // Get days in month
    final daysInMonth = lastDay.day;
    // Get weekday of first day (1 = Monday, 7 = Sunday)
    final firstWeekday = firstDay.weekday;

    return Column(
      children: [
        // Month grid header (weekdays)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: veryLightGrey),
            ),
          ),
          child: Row(
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryGrey,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Month grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: daysInMonth + firstWeekday - 1,
            itemBuilder: (context, index) {
              // Empty cells before first day
              if (index < firstWeekday - 1) {
                return Container();
              }

              final day = index - firstWeekday + 2;
              final date =
                  DateTime(_selectedDate.year, _selectedDate.month, day);
              final isToday = date.day == DateTime.now().day &&
                  date.month == DateTime.now().month &&
                  date.year == DateTime.now().year;
              final appointments = _getAppointmentsForDate(date);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                    _selectedViewIndex = 0; // Switch to day view
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color:
                        isToday ? primaryGrey.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isToday ? primaryGrey : veryLightGrey,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isToday ? primaryGrey : lightGrey,
                        ),
                      ),
                      if (appointments.isNotEmpty)
                        Expanded(
                          child: Center(
                            child: Text(
                              '${appointments.length} appt',
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryGrey,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Build appointment card
  Widget _buildAppointmentCard(ClientAppointment appointment,
      {bool showDate = true}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Client photo
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(appointment.clientPhotoUrl),
                ),
                const SizedBox(width: 12),

                // Client name and session type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.clientName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        appointment.sessionType,
                        style: TextStyle(
                          color: lightGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Confirmation status
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: appointment.isConfirmed
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    appointment.isConfirmed ? 'Confirmed' : 'Pending',
                    style: TextStyle(
                      color: appointment.isConfirmed
                          ? Colors.green
                          : Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Time and location
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: lightGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  '${DateFormat('h:mm a').format(appointment.startTime)} - ${DateFormat('h:mm a').format(appointment.endTime)}',
                  style: TextStyle(
                    color: lightGrey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: lightGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  appointment.location,
                  style: TextStyle(
                    color: lightGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            if (showDate) ...[
              const SizedBox(height: 8),
              Text(
                DateFormat('EEEE, MMMM d').format(appointment.startTime),
                style: TextStyle(
                  color: primaryGrey,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
