import 'package:flutter/material.dart';
import 'package:engineer/app_router.dart';
import 'package:engineer/themes/colors.dart';
import 'package:engineer/models/user_model.dart';
import 'package:engineer/services/productiondaily_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isGridView = true;
  // สร้างฟังก์ชันสลับระหว่าง ListView และ GridView
  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: _toggleView,
            icon: Icon(_isGridView ? Icons.list_outlined : Icons.grid_view)),
        title: const Text('Home'),
        actions: [],
      ),
    );
  }
}
