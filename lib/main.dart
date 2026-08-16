import 'package:flutter/material.dart';
import 'alter/alter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Geist',
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              ApplicationHeader(
                onProfileTap: () {
                  debugPrint('Profile tapped!');
                },
                onActionOneTap: () {
                  debugPrint('Action One tapped!');
                },
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonGraphicImage(
                              onTap: () {
                                debugPrint('ButtonGraphicImage pressed!');
                              },
                            ),
                            const SizedBox(width: 16),
                            ButtonGraphicText(
                              onTap: () {
                                debugPrint('ButtonGraphicText pressed!');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonIcon(
                              type: ButtonIconType.gray,
                              onTap: () {},
                            ),
                            const SizedBox(width: 12),
                            ButtonIcon(
                              type: ButtonIconType.white,
                              onTap: () {},
                            ),
                            const SizedBox(width: 12),
                            ButtonIcon(
                              type: ButtonIconType.primary,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonText(
                              label: 'Add',
                              type: ButtonType.gray,
                              size: ButtonSize.normal,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            ButtonText(
                              label: 'Add',
                              type: ButtonType.white,
                              size: ButtonSize.normal,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            ButtonText(
                              label: 'Add',
                              type: ButtonType.primary,
                              size: ButtonSize.normal,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonText(
                              label: 'Add',
                              type: ButtonType.gray,
                              size: ButtonSize.large,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            ButtonText(
                              label: 'Add',
                              type: ButtonType.white,
                              size: ButtonSize.large,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            ButtonText(
                              label: 'Add',
                              type: ButtonType.primary,
                              size: ButtonSize.large,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
