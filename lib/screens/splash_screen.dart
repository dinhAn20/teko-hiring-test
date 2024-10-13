import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_management/data/dio_client.dart';
import 'package:product_management/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DioClient _dioClient = DioClient();
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    _getAppComponents();
  }

  void _getAppComponents() async {
    try {
      setState(() {
        errorMessage = null;
      });
      var res = await _dioClient.getAllComponents();
      if (mounted) {
        Navigator.pushReplacement(context, HomeScreen.route(res));
      }
    } on DioException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: errorMessage != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(errorMessage!),
                  FilledButton.icon(
                    icon: const Icon(
                      CupertinoIcons.refresh,
                      size: 20,
                    ),
                    label: const Text("Tải Lại"),
                    onPressed: _getAppComponents,
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
