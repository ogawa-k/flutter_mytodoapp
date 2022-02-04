import 'package:flutter/material.dart';

import 'top_page.dart';

class _CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logoUrl;

  const _CourseCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.logoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              logoUrl,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.more_horiz),
        ),
      ),
    );
  }
}

class _Recommended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 32, bottom: 8, left: 8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Recommended',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const _CourseCard(
          title: 'Figma',
          subtitle: 'Figma Mastery',
          logoUrl: figmaLogoUrl,
        ),
        const _CourseCard(
          title: 'Sketch',
          subtitle: 'Symbol Libraries',
          logoUrl: sketchLogoUrl,
        ),
        const _CourseCard(
          title: 'Adobe XD',
          subtitle: 'Fundamentals of XD',
          logoUrl: xdLogoUrl,
        ),
        const _CourseCard(
          title: 'Figma',
          subtitle: 'Figma Mastery',
          logoUrl: figmaLogoUrl,
        ),
        const _CourseCard(
          title: 'Sketch',
          subtitle: 'Symbol Libraries',
          logoUrl: sketchLogoUrl,
        ),
        const _CourseCard(
          title: 'Adobe XD',
          subtitle: 'Fundamentals of XD',
          logoUrl: xdLogoUrl,
        ),
      ],
    );
  }
}

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationHorizontal;
  late Animation<Offset> _animationVertical;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationHorizontal = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));
    _animationVertical = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SlideTransition(
                    position: _animationHorizontal,
                    child: const Header(title: 'Courses'),
                  ),
                  SlideTransition(
                    position: _animationVertical,
                    child: _Recommended(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.reverse().then((_) {
            Navigator.of(context).pop();
          });
        },
        child: const Icon(Icons.keyboard_backspace),
      ),
    );
  }
}
