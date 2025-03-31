import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.urbanistTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  void _scrollToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton('Inicio', 0),
            _buildNavButton('Proyectos', 1),
            _buildNavButton('Contacto', 2),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {});
        },
        children: [
          SobreMiPage(pageController: _pageController),
          const ProyectosPage(),
          const ContactoPage(),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => _scrollToPage(index),
        style: TextButton.styleFrom(
          overlayColor: Colors.transparent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;

  const Section({super.key, required this.child, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          height: constraints.maxHeight,
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth > 800 ? 50 : 20,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
          ),
          child: child,
        );
      },
    );
  }
}

class SobreMiPage extends StatefulWidget {
  final PageController pageController;

  const SobreMiPage({super.key, required this.pageController});

  @override
  _SobreMiPageState createState() => _SobreMiPageState();
}

class _SobreMiPageState extends State<SobreMiPage>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      gradientColors: const [Colors.white, Colors.white],
      child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _opacity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 800;
              return isMobile
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Hola, mi nombre es Alejandro',
                                style: GoogleFonts.urbanist(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Ingeniero Informático',
                                style: GoogleFonts.urbanist(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Apasionado de la tecnología y el desarrollo de software.',
                                style: GoogleFonts.urbanist(
                                  fontSize: 20,
                                  color: Colors.grey.shade400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      widget.pageController.animateToPage(
                                        2,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'Contáctame',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse(
                                            'https://alexfcdesigns.github.io/portfolio/assets/files/Curriculum.pdf'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    icon: const Icon(Icons.download,
                                        color: Colors.white),
                                    label: const Text(
                                      'Descargar CV',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade800,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/images/about.jpg',
                            height: 350,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hola, mi nombre es Alejandro',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Ingeniero Informático',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  'Apasionado de la tecnología y el desarrollo de software.',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 30,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        widget.pageController.animateToPage(
                                          2,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: const Text(
                                        'Contáctame',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        launchUrl(
                                          Uri.parse(
                                              'https://alexfcdesigns.github.io/portfolio/assets/files/Curriculum.pdf'),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.remove_red_eye_rounded,
                                          color: Colors.white),
                                      label: const Text(
                                        'Descargar CV',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade800,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Image.asset('assets/images/about.jpg'),
                          ),
                        ),
                      ],
                    );
            },
          )),
    );
  }
}

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({super.key});

  @override
  _ProyectosPageState createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  final List<bool> _isVisibleList = [false, false];

  void _setVisible(int index, bool visible) {
    if (visible && !_isVisibleList[index]) {
      setState(() {
        _isVisibleList[index] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      gradientColors: const [Colors.white, Colors.white],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 20),
            child: Text(
              'Proyectos',
              style: GoogleFonts.urbanist(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: 2,
              itemBuilder: (context, index) {
                return VisibilityDetector(
                  key: Key('project_$index'),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.2) {
                      _setVisible(index, true);
                    }
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _isVisibleList[index] ? 1.0 : 0.0,
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          bool isMobile = constraints.maxWidth < 700;
                          bool isImageLeft = index % 2 == 0;
                          final image = _buildProjectImage(index);
                          final text = _buildProjectText(index);

                          final content = isMobile
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    image,
                                    const SizedBox(height: 20),
                                    text,
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isImageLeft) image,
                                    const SizedBox(width: 40),
                                    text,
                                    if (!isImageLeft) image,
                                  ],
                                );

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: content,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectImage(int index) {
    final images = ['assets/images/wimu.png', 'assets/images/UAL.png'];
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        images[index],
        width: 350,
        height: 220,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProjectText(int index) {
    final titles = ['WIMU – MyWimu App', 'TFG – UAL'];
    final descriptions = [
      [
        'App multiplataforma para monitorizar el rendimiento de jugadores.',
        'Comparación de resultados con datos deportivos.',
        'Flutter y Dart + APIs (Postman).',
        'UI diseñada en Figma.',
      ],
      [
        'App multiplataforma para la gestión de centros deportivos.',
        'Registro de usuarios y entrenadores.',
        'Tecnologías: Flutter, Dart, Firebase.',
        'UI diseñada en Figma.',
      ]
    ];
    final icons = [Icons.sports_soccer, Icons.fitness_center];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icons[index], color: Colors.teal.shade400, size: 28),
              const SizedBox(width: 10),
              Text(
                titles[index],
                style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...descriptions[index].map((line) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      line,
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: isMobile ? 250 : 400,
              width: isMobile ? 250 : 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  height: isMobile ? 200 : 250,
                  width: isMobile ? 200 : 250,
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHovered = true),
                    onExit: (_) => setState(() => _isHovered = false),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: 1.0, end: _isHovered ? 1.05 : 1.0),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              widget.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold, fontSize: isMobile ? 20 : 24),
            ),
            const SizedBox(height: 5),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: isMobile ? 14 : 16),
            ),
          ],
        );
      },
    );
  }
}

class ContactoPage extends StatefulWidget {
  const ContactoPage({super.key});

  @override
  State<ContactoPage> createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Section(
      gradientColors: const [Colors.white, Colors.white],
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 800;

                return isMobile
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Contacta conmigo',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No dudes en contactar conmigo para cualquier consulta o propuesta.',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Image.asset('assets/images/contact.png',
                                      height: 200),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  _buildTextField(
                                      'Nombre/Empresa', 'Nombre/Empresa'),
                                  const SizedBox(height: 20),
                                  _buildTextField('Email', 'Email'),
                                  const SizedBox(height: 20),
                                  _buildTextField('Mensaje', 'Mensaje',
                                      maxLines: 5),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final serviceId = 'service_yzajrev';
                                      final templateId = 'template_rpc99eh';
                                      final publicKey = 'exvv38Kgvsn5D7Y0W';
                                      final nameController = TextEditingController(
                                          text:
                                              ''); // reemplazar por valor real del formulario
                                      final emailController = TextEditingController(
                                          text:
                                              ''); // reemplazar por valor real del formulario
                                      final messageController =
                                          TextEditingController(
                                              text:
                                                  ''); // reemplazar por valor real del formulario
                                      final url = Uri.parse(
                                          'https://api.emailjs.com/api/v1.0/email/send');
                                      final response = await http.post(
                                        url,
                                        headers: {
                                          'origin': 'http://localhost',
                                          'Content-Type': 'application/json',
                                        },
                                        body: json.encode({
                                          'service_id': serviceId,
                                          'template_id': templateId,
                                          'user_id': publicKey,
                                          'template_params': {
                                            'user_name': nameController.text,
                                            'user_email': emailController.text,
                                            'message': messageController.text,
                                          }
                                        }),
                                      );
                                      if (response.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Mensaje enviado con éxito')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Error al enviar el mensaje')),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'Enviar Mensaje',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contacta conmigo',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'No dudes en contactar conmigo para cualquier consulta o propuesta.',
                                    style: GoogleFonts.urbanist(
                                        fontSize: 25,
                                        color: Colors.grey.shade600),
                                  ),
                                  const SizedBox(height: 20),
                                  Image.asset(
                                    width: 500,
                                    'assets/images/contact.png',
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildTextField(
                                            'Nombre/Empresa', 'Nombre/Empresa',
                                            controller: nameController),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: _buildTextField('Email', 'Email',
                                            controller: emailController),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  _buildTextField('Mensaje', 'Mensaje',
                                      maxLines: 5,
                                      controller: messageController),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final serviceId = 'service_yzajrev';
                                      final templateId = 'template_rpc99eh';
                                      final publicKey = 'exvv38Kgvsn5D7Y0W';

                                      final url = Uri.parse(
                                          'https://api.emailjs.com/api/v1.0/email/send');
                                      final response = await http.post(
                                        url,
                                        headers: {
                                          'origin': 'http://localhost',
                                          'Content-Type': 'application/json',
                                        },
                                        body: json.encode({
                                          'service_id': serviceId,
                                          'template_id': templateId,
                                          'user_id': publicKey,
                                          'template_params': {
                                            'user_name': nameController.text,
                                            'user_email': emailController.text,
                                            'message': messageController.text,
                                          }
                                        }),
                                      );
                                      if (response.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Mensaje enviado con éxito')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Error al enviar el mensaje')),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'Enviar Mensaje',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        launchUrl(
                            Uri.parse('https://github.com/AlexFCDesigns'));
                      },
                      icon: Image.asset(
                        'assets/images/github.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://www.linkedin.com/in/alejandro-fernández-crespo-2a1045144/'));
                      },
                      icon: Image.asset(
                        'assets/images/linkedin.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {int maxLines = 1, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactInfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Colors.black),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}
