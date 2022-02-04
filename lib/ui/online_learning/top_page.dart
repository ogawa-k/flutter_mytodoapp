import 'package:flutter/material.dart';

import 'course_page.dart';

const figmaLogoUrl = 'assets/83031886-1ce87880-a070-11ea-89c8-5cee840d5782.png';
const sketchLogoUrl = 'assets/83145378-a7dc7800-a12f-11ea-93e1-32c7982c5e63.png';
const xdLogoUrl = 'assets/83145578-f558e500-a12f-11ea-85fa-3e26a966d180.png';


class Header extends StatelessWidget {
  final String title;

  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blue[50],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 150,
              child: Text('Choose from over 100,000 online video courses'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 32,
                ),
              ),
              child: const Text('Browse all courses'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FigmaLogo extends StatelessWidget {
  final double size;

  const _FigmaLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(8),
        color: Colors.black,
        child: Image.network(figmaLogoUrl, fit: BoxFit.contain),
      ),
    );
  }
}

class _Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 32, left: 8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Featured',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 32,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.navigate_before),
                      SizedBox(
                        width: 180,
                        child: Column(
                          children: const [
                            Text(
                              'Figma: Solid Foundations',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'The most complete beginner to advanced guide',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: _FigmaLogo(size: 48),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrendingCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 32, bottom: 8, left: 8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Trending Courses',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  color: Colors.grey[100],
                  child: const ListTile(
                    leading: Icon(Icons.school, color: Colors.blue),
                    trailing: Text('Communication Skills'),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: Colors.grey[100],
                  child: const ListTile(
                    leading: Icon(Icons.school, color: Colors.blue),
                    trailing: Text('Digital Marketing 101'),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: Colors.grey[100],
                  child: const ListTile(
                    leading: Icon(Icons.school, color: Colors.blue),
                    trailing: Text('UX Research'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text('View trending list'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnlineLearningTopPage extends StatefulWidget {
  const OnlineLearningTopPage({Key? key}) : super(key: key);
  static String routeName = '/ui/online_learning/top';

  @override
  _OnlineLearningTopPageState createState() => _OnlineLearningTopPageState();
}

class _OnlineLearningTopPageState extends State<OnlineLearningTopPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;
  late Animation<Offset> _animation3;
  late Animation<Offset> _animation4;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    final tween = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    );

    _animation1 = tween.animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeInOutBack),
    ));
    _animation2 = tween.animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.8, curve: Curves.easeInOutBack),
    ));
    _animation3 = tween.animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.9, curve: Curves.easeInOutBack),
    ));
    _animation4 = tween.animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeInOutBack),
    ));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Learning'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SlideTransition(
                  position: _animation1,
                  child: const Header(title: 'TurtleU'),
                ),
                SlideTransition(
                  position: _animation2,
                  child: _Hero(),
                ),
                SlideTransition(
                  position: _animation3,
                  child: _Featured(),
                ),
                SlideTransition(
                  position: _animation4,
                  child: _TrendingCourses(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward().then((_) {
            Navigator.of(context)
                .push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => const CoursesPage()),
                )
                .then((_) => _controller.reverse());
          });
        },
        child: const Icon(Icons.list),
      ),
    );
  }
}
