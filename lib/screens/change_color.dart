import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class ChangeColor extends StatefulWidget {
  const ChangeColor({super.key});

  @override
  State<ChangeColor> createState() => _ChangeColorState();
}

class _ChangeColorState extends State<ChangeColor> {
  Color baseColor = Colors.white;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Color.fromARGB(255, 241, 233, 227) : Color(0xff1e2026),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
                colorFilter: ColorFilter.mode(baseColor, BlendMode.modulate),
                child: Image.asset('assets/chair.png', width: MediaQuery.of(context).size.width / 1.2)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Color color = baseColor;
                AlertDialog dialog = AlertDialog(
                    title: const Text('Choose color'),
                    content: SizedBox(
                      width: 300,
                      child: ColorPicker(
                        paletteHeight: 100,
                        color: baseColor,
                        onChanged: (value) {
                          setState(() {
                            color = value;
                          });
                        },
                        initialPicker: Picker.wheel,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            baseColor = color;
                            isDark = color.computeLuminance() < 0.5;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ]);
                showDialog(context: context, builder: (context) => dialog);
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Change Color',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
