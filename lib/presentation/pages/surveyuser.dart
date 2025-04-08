
import 'package:flutter/material.dart';

class Surveyuser extends StatefulWidget {
  const Surveyuser({super.key});

  @override
  State<Surveyuser> createState() => _SurveyuserState();
}

class _SurveyuserState extends State<Surveyuser> {
  // Current page index for the survey
  int _currentPage = 0;
  final PageController _pageController = PageController();
  
  // Survey data storage
  Map<String, dynamic> _surveyData = {
    'fitnessGoals': [],
    'weight': '',
    'height': '',
    'bodyFatPercentage': '',
    'playsSports': false,
    'sportsTypes': [],
    'otherSports': '',
    'workoutFrequency': '',
    'dietPreference': '',
    'wantPremiumAI': false,
    'wantsPersonalization': true,
  };
  
  // Options for fitness goals (multi-select)
  final List<String> _fitnessGoals = [
    'Weight Loss',
    'Muscle Gain',
    'Improve Strength',
    'Improve Endurance',
    'Improve Flexibility',
    'Maintain Current Fitness',
    'Prepare for Event/Competition',
    'Rehabilitation',
    'Overall Wellness',
  ];
  
  // Sports types (shown if user plays sports)
  final List<String> _sportsTypes = [
    'Running/Jogging',
    'Cycling',
    'Swimming',
    'Basketball',
    'Football/Soccer',
    'Tennis',
    'Volleyball',
    'CrossFit',
    'Yoga',
    'Pilates',
    'Dancing',
    'Martial Arts',
    'Weightlifting',
    'Rock Climbing',
    'Hiking',
    'Other',
  ];
  
  // Workout frequency options
  final List<String> _workoutFrequencies = [
    'Less than once a week',
    '1-2 times per week',
    '3-4 times per week',
    '5+ times per week',
    'Every day',
  ];
  
  // Diet preference options
  final List<String> _dietPreferences = [
    'No specific diet',
    'Balanced diet',
    'Vegan',
    'Vegetarian',
    'Keto',
    'Paleo',
    'Mediterranean',
    'Low-carb',
    'Low-fat',
    'High-protein',
    'Intermittent fasting',
  ];
  
  // Form keys for validation
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _sportsFormKey = GlobalKey<FormState>();
  final _aiPreferencesFormKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  // Check if progress can be saved
  bool canProceed() {
    switch (_currentPage) {
      case 0: // Basic info
        return _basicInfoFormKey.currentState?.validate() ?? false;
      case 1: // Sports
        return true; // Always allow proceeding as sports section is optional
      case 2: // AI Preferences
        return _aiPreferencesFormKey.currentState?.validate() ?? false;
      default:
        return true;
    }
  }
  
  // Next page method
  void _nextPage() {
    if (!canProceed()) return;
    
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitSurvey();
    }
  }
  
  // Previous page method
  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  // Submit survey method
  void _submitSurvey() {
    // Here you would typically send the survey data to your backend
    print('Survey submitted with data: $_surveyData');
    
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Survey Submitted'),
        content: const Text(
          'Thank you for completing the survey! Your personal experience will now be customized based on your preferences.',
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
            ),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate back to main screen or dashboard
              Navigator.of(context).pop();
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fitness Profile Survey',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Show confirmation before leaving
            if (_currentPage > 0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Exit Survey?'),
                    content: const Text(
                      'Your progress will not be saved. Are you sure you want to exit?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Exit'),
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentPage + 1) / 4,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[800]!),
          ),
          
          // Page steps indicator
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageIndicator(0, "Goals"),
                _buildSeparator(),
                _buildPageIndicator(1, "Activities"),
                _buildSeparator(),
                _buildPageIndicator(2, "Preferences"),
                _buildSeparator(),
                _buildPageIndicator(3, "Review"),
              ],
            ),
          ),
          
          // Survey content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildBasicInfoPage(),
                _buildSportsPage(),
                _buildAIPreferencesPage(),
                _buildReviewPage(),
              ],
            ),
          ),
          
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button (hidden on first page)
                _currentPage > 0
                    ? ElevatedButton(
                        onPressed: _previousPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Previous'),
                      )
                    : const SizedBox(width: 100),
                
                // Next/Submit button
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(_currentPage == 3 ? 'Submit' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Page indicator builder
  Widget _buildPageIndicator(int pageIndex, String label) {
    bool isActive = pageIndex <= _currentPage;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? Colors.grey[800] : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: pageIndex < _currentPage
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '${pageIndex + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.grey[800] : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
  
  // Separator between page indicators
  Widget _buildSeparator() {
    return Container(
      width: 30,
      height: 2,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
  
  // Basic info page
  Widget _buildBasicInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _basicInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Fitness Goals & Physical Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              "Select your fitness and wellness goals:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Fitness goals multi-select
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _fitnessGoals.map((goal) {
                final isSelected = _surveyData['fitnessGoals'].contains(goal);
                return FilterChip(
                  label: Text(goal),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _surveyData['fitnessGoals'].add(goal);
                      } else {
                        _surveyData['fitnessGoals'].remove(goal);
                      }
                    });
                  },
                  selectedColor: Colors.grey[400],
                  checkmarkColor: Colors.grey[800],
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.grey[800] : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            
            // Weight input
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.scale),
              ),
              keyboardType: TextInputType.number,
              initialValue: _surveyData['weight'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your weight';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: (value) {
                _surveyData['weight'] = value;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Height input
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
              keyboardType: TextInputType.number,
              initialValue: _surveyData['height'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your height';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: (value) {
                _surveyData['height'] = value;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Body fat percentage (optional)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Body Fat Percentage (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.percent),
                hintText: 'Leave blank if unknown',
              ),
              keyboardType: TextInputType.number,
              initialValue: _surveyData['bodyFatPercentage'],
              onChanged: (value) {
                _surveyData['bodyFatPercentage'] = value;
              },
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final bodyFat = double.tryParse(value);
                  if (bodyFat == null) {
                    return 'Please enter a valid number';
                  }
                  if (bodyFat < 0 || bodyFat > 100) {
                    return 'Percentage must be between 0 and 100';
                  }
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Workout frequency
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Workout Frequency',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.repeat),
              ),
              value: _surveyData['workoutFrequency'].isEmpty ? null : _surveyData['workoutFrequency'],
              hint: const Text('Select your typical workout frequency'),
              items: _workoutFrequencies.map((frequency) {
                return DropdownMenuItem<String>(
                  value: frequency,
                  child: Text(frequency),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your workout frequency';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _surveyData['workoutFrequency'] = value;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Diet preference
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Diet Preference',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.restaurant_menu),
              ),
              value: _surveyData['dietPreference'].isEmpty ? null : _surveyData['dietPreference'],
              hint: const Text('Select your diet preference'),
              items: _dietPreferences.map((diet) {
                return DropdownMenuItem<String>(
                  value: diet,
                  child: Text(diet),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your diet preference';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _surveyData['dietPreference'] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  
  // Sports page
  Widget _buildSportsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _sportsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Sports & Physical Activities",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            
            // Do you play sports?
            SwitchListTile(
              title: const Text(
                "Do you play sports or engage in specific physical activities?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: _surveyData['playsSports'],
              activeColor: Colors.grey[800],
              onChanged: (value) {
                setState(() {
                  _surveyData['playsSports'] = value;
                  // Clear selections if switched off
                  if (!value) {
                    _surveyData['sportsTypes'] = [];
                    _surveyData['otherSports'] = '';
                  }
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Only show sports selection if user plays sports
            if (_surveyData['playsSports']) ...[
              const Text(
                "Select the sports or activities you participate in:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              // Sports types multi-select
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _sportsTypes.map((sport) {
                  final isSelected = _surveyData['sportsTypes'].contains(sport);
                  return FilterChip(
                    label: Text(sport),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _surveyData['sportsTypes'].add(sport);
                        } else {
                          _surveyData['sportsTypes'].remove(sport);
                        }
                      });
                    },
                    selectedColor: Colors.grey[400],
                    checkmarkColor: Colors.grey[800],
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.grey[800] : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 16),
              
              // Show "Other" field if "Other" is selected
              if (_surveyData['sportsTypes'].contains('Other'))
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Specify other sports/activities',
                    border: OutlineInputBorder(),
                    hintText: 'E.g., Badminton, Table Tennis, etc.',
                  ),
                  initialValue: _surveyData['otherSports'],
                  onChanged: (value) {
                    _surveyData['otherSports'] = value;
                  },
                ),
                
              const SizedBox(height: 24),
              
              // Additional info about experience/goals for the selected sports
              const Text(
                "This information will help us tailor workout and nutrition plans specific to your activities.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey[700],
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        "That's okay! We'll focus on general fitness goals and tailor your experience accordingly.",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  // AI Preferences page
  Widget _buildAIPreferencesPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _aiPreferencesFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AI & Personalization Preferences",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            
            // Premium TiziAI option
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Colors.grey[800],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Premium TiziAI",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Our advanced AI system provides personalized workout plans, nutrition advice, and real-time form corrections based on your specific goals, body metrics, and progress.",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.grey[700],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text("Adaptive workout plans that evolve with you"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.grey[700],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text("Personalized nutrition recommendations"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.grey[700],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text("Smart progress tracking and analytics"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text(
                      "Enable Premium TiziAI",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _surveyData['wantPremiumAI']
                          ? "Additional subscription fee applies"
                          : "Standard AI features will be available",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    value: _surveyData['wantPremiumAI'],
                    activeColor: Colors.grey[800],
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        _surveyData['wantPremiumAI'] = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Personalization option
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey[800],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Content Personalization",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Allow the app to customize your interface, content, and recommendations based on your preferences and usage patterns.",
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text(
                      "Enable Content Personalization",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _surveyData['wantsPersonalization']
                          ? "Your experience will be tailored to your preferences"
                          : "You'll receive general, non-personalized content",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    value: _surveyData['wantsPersonalization'],
                    activeColor: Colors.grey[800],
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        _surveyData['wantsPersonalization'] = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Warning about data usage
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.amber[200]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: Colors.amber[800],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Important Notice",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "The information you provide in this survey will be used to augment your algorithm and will significantly affect your user experience, interface, and the content displayed throughout your journey.",
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "You can update your preferences at any time through the Settings menu.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Review page
  Widget _buildReviewPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review Your Responses",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Please review the information you've provided before submitting.",
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          
          // Fitness Goals section
          _buildReviewSection(
            title: "Fitness Goals",
            content: _surveyData['fitnessGoals'].isEmpty 
                ? "No goals selected" 
                : _surveyData['fitnessGoals'].join(", "),
            icon: Icons.fitness_center,
          ),
          
          // Physical profile section
          _buildReviewSection(
            title: "Physical Profile",
            content: "Weight: ${_surveyData['weight']} kg\n"
                   "Height: ${_surveyData['height']} cm\n"
                   "Body Fat: ${_surveyData['bodyFatPercentage'].isEmpty ? 'Not specified' : _surveyData['bodyFatPercentage'] + '%'}\n"
                   "Workout Frequency: ${_surveyData['workoutFrequency']}\n"
                   "Diet Preference: ${_surveyData['dietPreference']}",
            icon: Icons.person_outline,
          ),
          
          // Sports section
          _buildReviewSection(
            title: "Sports & Activities",
            content: !_surveyData['playsSports'] 
                ? "No sports or specific activities" 
                : (_surveyData['sportsTypes'].isEmpty 
                    ? "No sports selected" 
                    : _surveyData['sportsTypes'].join(", ") + 
                      (_surveyData['otherSports'].isNotEmpty && _surveyData['sportsTypes'].contains('Other')
                        ? "\nOther sports: ${_surveyData['otherSports']}" 
                        : "")),
            icon: Icons.sports,
          ),
          
          // AI Preferences section
          // AI Preferences section
          _buildReviewSection(
            title: "AI & Personalization",
            content: "Premium TiziAI: ${_surveyData['wantPremiumAI'] ? 'Enabled' : 'Disabled'}\n"
                   "Content Personalization: ${_surveyData['wantsPersonalization'] ? 'Enabled' : 'Disabled'}",
            icon: Icons.auto_awesome,
          ),
          
          const SizedBox(height: 24),
          
          // Final confirmation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green[700],
                  size: 24,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    "By submitting this survey, you agree that the information provided will be used to personalize your experience according to our privacy policy.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build review sections
  Widget _buildReviewSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.grey[800],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Navigate to the appropriate page for editing
                  if (title == "Fitness Goals" || title == "Physical Profile") {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _currentPage = 0;
                    });
                  } else if (title == "Sports & Activities") {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _currentPage = 1;
                    });
                  } else if (title == "AI & Personalization") {
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _currentPage = 2;
                    });
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[800],
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text("Edit"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}