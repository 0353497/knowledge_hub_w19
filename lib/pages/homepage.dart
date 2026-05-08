import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:knowledge_hub/pages/video_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 24,
        children: [
          Image.asset("assets/media-files/tainex_logo.jpg"),
          OwnButton(icon: Icons.person, text: 'Management', index: 0),
          OwnButton(icon: Icons.location_on, text: 'About the Venue', index: 1),
          OwnButton(icon: Icons.sticky_note_2, text: 'Public Art', index: 2),
          OwnButton(icon: Icons.mood, text: 'Facilities', index: 3),
          OwnButton(icon: Icons.star, text: 'Dining & Catering', index: 4),
          Row(),
        ],
      ),
    );
  }
}

class OwnButton extends StatelessWidget {
  const OwnButton({
    super.key,
    required this.index,
    required this.icon,
    required this.text,
  });
  final int index;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .5,
      height: 60,
      child: ElevatedButton(
        onPressed: () =>
            Get.to(() => VideoPage(index: index, icon: icon, title: text)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [Icon(icon), Text(text)]),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
