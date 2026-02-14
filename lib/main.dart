import 'package:flutter/material.dart';

void main() {
  runApp(const CounterImageToggleApp());
}

class CounterImageToggleApp extends StatelessWidget {
  const CounterImageToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW1 Counter & Toggle',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isDark = false;
  bool _isFirstImage = true;

  int _stepValue = 1; // step control variable

  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() => _counter += _stepValue);
  }

  void _decrementCounter() {
    if (_counter >= _stepValue) {
      setState(() {
        _counter -= _stepValue;
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  void _toggleImage() {
    if (_isFirstImage) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _isFirstImage = !_isFirstImage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CW1 Counter & Toggle'),
          actions: [
            IconButton(
              onPressed: _toggleTheme,
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // counter display
              Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              // step selector buttons
              Text(
                'Select step size:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // step 1
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _stepValue = 1;
                      });
                    },
                    child: const Text('Step 1'),
                  ),
                  const SizedBox(width: 8),
                  // step 5
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _stepValue = 5;
                      });
                    },
                    child: const Text('Step 5'),
                  ),
                  const SizedBox(width: 8),   
                  // step 10
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _stepValue = 10;
                      });
                    },
                    child: const Text('Step 10'),
                  ),             
                ],
              ),
              const SizedBox(height: 16),
              // current step display
              Text(
                'Incrementing by: $_stepValue',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              // counter control
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // decrement
                  ElevatedButton(
                    onPressed: _counter >= _stepValue ? _decrementCounter : null,
                    child: Text('-$_stepValue'),
                  ),
                  const SizedBox(width: 12),
                  // increment
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text('+$_stepValue'),
                  ),
                  const SizedBox(width: 12),
                  // reset
                  ElevatedButton(
                    onPressed: _counter > 0 ? _resetCounter : null,
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fade,
                child: Image.asset(
                  _isFirstImage ? 'assets/images/image1.png' : 'assets/images/image2.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text('Toggle Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}