import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final Color backgroundColor;

  const Profile({
    Key? key,
    this.onDateSelected,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late DateTime _selectedDate;
  late List<DateTime> _weekDays;
  late PageController _pageController;
  int _selectedIconIndex = -1; // Track the selected icon index

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _pageController = PageController(initialPage: 0);
    _generateWeekDays(DateTime.now());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _generateWeekDays(DateTime date) {
    // Find the start of the week (Monday)
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    _weekDays = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }

  void _navigateToWeek(int direction) {
    setState(() {
      DateTime newDate = _selectedDate.add(Duration(days: 7 * direction));
      _selectedDate = newDate;
      _generateWeekDays(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "Images/Juma.png",
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // Add "Max Achebi" above the image
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3 - 40),
                    child: Text(
                      "Max Achebi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                // Add four icons beneath the image
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3 + 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIconButton(0, Icons.fastfood), // Food icon
                        SizedBox(width: 40), // Increased space between icons
                        _buildIconButton(1, Icons.access_time), // Clock/watch icon
                        SizedBox(width: 40), // Increased space between icons
                        _buildIconButton(2, Icons.contacts), // Phonebook icon
                        SizedBox(width: 40), // Increased space between icons
                        _buildIconButton(3, Icons.bar_chart), // Bar graph icon
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                  color: widget.backgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Month and year header with navigation
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.chevron_left, color: Colors.grey),
                              onPressed: () => _navigateToWeek(-1),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                            Text(
                              DateFormat('MMMM yyyy').format(_weekDays[0]),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey, // Grey color for calendar text
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right, color: Colors.grey),
                              onPressed: () => _navigateToWeek(1),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),

                      // Days of the week
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _weekDays.map((day) {
                          bool isToday = _isToday(day);
                          bool isSelected = _isSameDay(day, _selectedDate);

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDate = day;
                                  if (widget.onDateSelected != null) {
                                    widget.onDateSelected!(day);
                                  }
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Day name (Mon, Tue, etc.)
                                  Text(
                                    DateFormat('E').format(day).substring(0, 3),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.grey // Grey color for selected day
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 6),

                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? Colors.grey // Grey color for selected day
                                          : isToday
                                              ? Colors.grey.withOpacity(0.1)
                                              : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        day.day.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isToday || isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.white
                                              : isToday
                                                  ? Colors.grey
                                                  : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an icon button
  Widget _buildIconButton(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIconIndex = index; // Update the selected icon index
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _selectedIconIndex == index ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          border: _selectedIconIndex == index
              ? Border.all(color: Colors.grey, width: 2)
              : null,
        ),
        child: Icon(
          icon,
          size: 30,
          color: _selectedIconIndex == index ? Colors.grey : Colors.grey[600],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

// Example of how to use the Profile widget in an app
class CalendarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Profile(
              backgroundColor: Colors.grey[100]!,
              onDateSelected: (date) {
                print(
                    'Selected date: ${DateFormat('yyyy-MM-dd').format(date)}');
                // Handle date selection here
              },
            ),
            // Other utilities
            Expanded(
              child: Center(
                child: Text(
                    '4 icons: nutrition follow-up, workout routines with or without trainer, pictures and progress, and analytics'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}