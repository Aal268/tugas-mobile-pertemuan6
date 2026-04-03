import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    title: 'Book List',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
    ),
    home: BookListScreen(),
  ));
}

class BookListScreen extends StatelessWidget {
  final List<Map<String, String>> books = [
    {
      'title': 'Algorithms to Live By: The Computer Science of Human Decisions',
      'author': 'Brian Christian',
      'description':
          'In a dazzlingly interdisciplinary work, Brian Christian and Tom Griffiths show how algorithms developed for computers also untangle very human questions. '
          'They explain how to have better hunches and when to leave things to chance, how to deal with overwhelming choices and how best to connect with others. '
          'From finding a spouse to finding a parking spot, from organizing one\'s inbox to peering into the future, '
          'Algorithms to Live By transforms the wisdom of computer science into strategies for human living.',
      'pdf': 'assets/pdf/978-3-030-53199-7.pdf',
    },
    {
      'title': 'Beginning Programming All-in-One Desk Reference for Dummies',
      'author': 'Wallace Wang',
      'description':
          'Beginning Programming All In One Desk Reference For Dummies shows you how to decide what you want your program to do, '
          'turn your instructions into "machine language" that the computer understands, use programming best practices, '
          'explore the "how" and "why" of data structuring, and more. '
          'You\'ll even get a look into various applications like database management, bioinformatics, computer security, and artificial intelligence. '
          'Soon you\'ll realize that — wow! You\'re a programmer!',
      'pdf': 'assets/pdf/978-3-031-21534-6.pdf',
    },
    {
      'title': 'Streamlit for Data Science: Create interactive data apps in Python',
      'author': 'Tyler Richards',
      'description':
          'If you work with data in Python and are looking to create data apps that showcase ML models and make beautiful interactive visualizations, '
          'then this is the ideal book for you. Streamlit for Data Science, Second Edition, shows you how to create and deploy data apps quickly, all within Python. '
          'This helps you create prototypes in hours instead of days! Written by a prolific Streamlit user and senior data scientist at Snowflake, '
          'this fully updated second edition builds on the practical nature of the previous edition with exciting updates.',
      'pdf': 'assets/pdf/C295BIGDATAISBN978-623-8531-51-6PDFTerbitFebruari2024SonpediaPublishingIndonesia.pdf',
    },
    {
      'title': 'Rekayasa Perangkat Lunak (RPL)',
      'author': 'Rosa A.S & M. Shalahuddin',
      'description':
          'Buku ini membahas konsep dasar rekayasa perangkat lunak secara komprehensif. '
          'Mulai dari perencanaan, analisis, perancangan, implementasi, pengujian, hingga pemeliharaan sistem perangkat lunak. '
          'Disajikan dengan bahasa yang mudah dipahami dan dilengkapi contoh kasus nyata.',
      'pdf': 'assets/pdf/RPL-Cetak-SHARE.pdf',
    },
    {
      'title': 'Desain Grafis dengan CorelDRAW',
      'author': 'Tim Penulis',
      'description':
          'Ebook ini membahas cara menggunakan CorelDRAW secara lengkap dari dasar hingga tingkat lanjut. '
          'Dilengkapi dengan tutorial langkah demi langkah untuk membuat desain grafis profesional, '
          'mulai dari logo, brosur, hingga banner.',
      'pdf': 'assets/pdf/ebook-coreldraw.pdf',
    },
    {
      'title': 'Multimedia: Teori dan Aplikasi',
      'author': 'Tim Penulis',
      'description':
          'Ebook multimedia ini membahas berbagai aspek multimedia meliputi teks, gambar, audio, video, dan animasi. '
          'Dilengkapi dengan pembahasan mengenai pengembangan aplikasi multimedia interaktif '
          'yang dapat diterapkan dalam berbagai bidang seperti pendidikan, hiburan, dan bisnis.',
      'pdf': 'assets/pdf/ebook-multimedia.pdf',
    },
    {
      'title': 'Pemrograman Mobile Android',
      'author': 'Tim Penulis',
      'description':
          'Buku panduan lengkap pemrograman aplikasi mobile berbasis Android. '
          'Membahas dasar-dasar pengembangan aplikasi Android mulai dari instalasi lingkungan pengembangan, '
          'konsep Activity, Intent, Fragment, hingga koneksi ke database dan web service.',
      'pdf': 'assets/pdf/ebook-pemrograman-mobile-android.pdf',
    },
    {
      'title': 'Pemrograman Website Jilid 1',
      'author': 'Tim Penulis',
      'description':
          'Panduan lengkap pemrograman website yang membahas HTML, CSS, dan JavaScript secara terstruktur. '
          'Buku ini cocok untuk pemula yang ingin mempelajari pengembangan web dari nol '
          'hingga mampu membuat website yang responsif dan interaktif.',
      'pdf': 'assets/pdf/ebook-pemrograman-website-1.pdf',
    },
    {
      'title': 'Desain Foto dengan Adobe Photoshop',
      'author': 'Tim Penulis',
      'description':
          'Ebook Photoshop ini membahas teknik-teknik editing foto menggunakan Adobe Photoshop secara lengkap. '
          'Mulai dari pengenalan antarmuka, penggunaan tools dasar, retouching foto, manipulasi gambar, '
          'hingga teknik desain tingkat lanjut yang sering digunakan oleh para desainer profesional.',
      'pdf': 'assets/pdf/ebook-photoshop.pdf',
    },
    {
      'title': 'Rekayasa Perangkat Lunak: Rosa A.S & M. Shalahuddin (Lengkap)',
      'author': 'Rosa A.S & M. Shalahuddin',
      'description':
          'Edisi lengkap buku Rekayasa Perangkat Lunak oleh Rosa A.S dan M. Shalahuddin. '
          'Membahas secara mendalam metodologi pengembangan perangkat lunak, '
          'termasuk model waterfall, agile, scrum, dan berbagai teknik analisis serta perancangan sistem.',
      'pdf': 'assets/pdf/feismo.com-buku-rpl-rosa-as-amp-m-salahuddin-pr_181536ac17a40e1d3c30207b43e251e2.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                books[index]['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(books[index]['author']!),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(
                      title: books[index]['title']!,
                      author: books[index]['author']!,
                      description: books[index]['description']!,
                      pdfAsset: books[index]['pdf']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BookDetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String pdfAsset;

  BookDetailScreen({
    required this.title,
    required this.author,
    required this.description,
    required this.pdfAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Author: $author',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 12),
            Text(
              'Description:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Expanded(
              child: SingleChildScrollView(
                child: Text(description, style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text('Back'),
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadingBookFile(
                          title: title,
                          pdfAsset: pdfAsset,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.menu_book),
                  label: Text('Read the book'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ReadingBookFile extends StatefulWidget {
  final String title;
  final String pdfAsset;

  ReadingBookFile({required this.title, required this.pdfAsset});

  @override
  State<ReadingBookFile> createState() => _ReadingBookFileState();
}

class _ReadingBookFileState extends State<ReadingBookFile> {
  String? _localPath;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      // Load PDF from assets and copy to temp directory so flutter_pdfview can read it
      final byteData = await rootBundle.load(widget.pdfAsset);
      final tempDir = await getTemporaryDirectory();
      final fileName = widget.pdfAsset.split('/').last;
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

      setState(() {
        _localPath = file.path;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat PDF: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                          label: Text('Kembali'),
                        ),
                      ],
                    ),
                  ),
                )
              : PDFView(
                  filePath: _localPath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  },
                  onPageError: (page, error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Page $page error: $error')),
                    );
                  },
                ),
    );
  }
}