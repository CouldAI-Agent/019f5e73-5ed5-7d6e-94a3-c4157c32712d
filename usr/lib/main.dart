import 'package:flutter/material.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Presentasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationDeck(),
      },
    );
  }
}

class PresentationDeck extends StatefulWidget {
  const PresentationDeck({super.key});

  @override
  State<PresentationDeck> createState() => _PresentationDeckState();
}

class _PresentationDeckState extends State<PresentationDeck> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _slides = [
    const TitleSlide(),
    const FeatureSlide(),
    const ContentSlide(),
    const ConclusionSlide(),
  ];

  void _nextSlide() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevSlide() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _slides,
          ),
          // Navigation Controls for Web/Desktop
          if (MediaQuery.of(context).size.width > 600)
            Positioned(
              bottom: 20,
              right: 20,
              child: Row(
                children: [
                  FloatingActionButton.small(
                    onPressed: _currentPage > 0 ? _prevSlide : null,
                    tooltip: 'Slide Sebelumnya',
                    backgroundColor: _currentPage > 0
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Colors.grey,
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${_currentPage + 1} / ${_slides.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton.small(
                    onPressed: _currentPage < _slides.length - 1 ? _nextSlide : null,
                    tooltip: 'Slide Berikutnya',
                    backgroundColor: _currentPage < _slides.length - 1
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Colors.grey,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          // Mobile indicator
          if (MediaQuery.of(context).size.width <= 600)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_currentPage + 1} / ${_slides.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TitleSlide extends StatelessWidget {
  const TitleSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.slideshow, size: 100, color: Colors.blue),
            const SizedBox(height: 24),
            Text(
              'Presentasi dengan Flutter',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Membangun Aplikasi PPT Interaktif',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                  ),
            ),
            const SizedBox(height: 40),
            Text(
              'Geser atau gunakan tombol panah',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class FeatureSlide extends StatelessWidget {
  const FeatureSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideLayout(
      title: 'Fitur Utama',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          BulletPoint(text: 'Navigasi mulus menggunakan PageView'),
          BulletPoint(text: 'Mendukung kontrol gestur (geser) di perangkat seluler'),
          BulletPoint(text: 'Tombol navigasi intuitif untuk Desktop & Web'),
          BulletPoint(text: 'Dapat diisi dengan komponen interaktif (animasi, video, grafik)'),
          BulletPoint(text: 'Desain responsif yang menyesuaikan ukuran layar'),
        ],
      ),
    );
  }
}

class ContentSlide extends StatelessWidget {
  const ContentSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideLayout(
      title: 'Fleksibilitas Konten',
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Bukan Sekedar Teks & Gambar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Karena ini adalah aplikasi Flutter, Anda tidak terbatas pada elemen presentasi konvensional. Anda bisa menyematkan widget interaktif apa saja di dalam slide.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                BulletPoint(text: 'Formulir langsung'),
                BulletPoint(text: 'Pemanggilan API real-time'),
                BulletPoint(text: 'Animasi Rive atau Lottie'),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 600) ...[
            const SizedBox(width: 32),
            Expanded(
              child: Center(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class ConclusionSlide extends StatelessWidget {
  const ConclusionSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Terima Kasih',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Anda menekan tombol di dalam slide!')),
                );
              },
              icon: const Icon(Icons.thumb_up),
              label: const Text('Tepuk Tangan'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Komponen Pembantu
class SlideLayout extends StatelessWidget {
  final String title;
  final Widget content;

  const SlideLayout({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 32),
            Expanded(child: SingleChildScrollView(child: content)),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
