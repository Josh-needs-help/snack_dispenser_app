import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/AutoScaleText.dart';
import 'package:snack_dispenser_app/Pages/AnalyticsPage.dart';
import 'package:snack_dispenser_app/Pages/HistoryPage.dart';

class PageGallery extends StatefulWidget {
  const PageGallery({super.key});

  @override
  State<PageGallery> createState() => _PageGalleryState();
}

class _PageGalleryState extends State<PageGallery> {
  bool isAnimating = false;
  final List<Widget> pages = [HistoryPage(), AnalyticsPage()];
  int _currentIndex = 0;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF101F22),
        title: Center(
          child: AutoScaleText(
            text: _currentIndex == 0 ? "History" : "Analytics",
            align: TextAlign.center,
            weight: FontWeight.w500,
            maxSize: 20,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF171F30),
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey[400],
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (isAnimating || _currentIndex == index) return;
          isAnimating = true;
          _currentIndex = index;
          setState(() {});
          await controller.animateToPage(
            _currentIndex,
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
          );
          isAnimating = false;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
