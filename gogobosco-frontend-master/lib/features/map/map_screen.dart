import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// DATA MODEL
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

enum InstitutionType { school, college, university, center }

class BoscoInstitution {
  final String id;
  final String name;
  final String shortName;
  final InstitutionType type;
  final String city;
  final String state;
  final String address;
  final String description;
  final String phone;
  final String email;
  final String established;
  final String affiliation;
  final double lat;
  final double lng;
  final double mx; // normalized position on cartoon canvas (0.0â€“1.0)
  final double my;

  const BoscoInstitution({
    required this.id,
    required this.name,
    required this.shortName,
    required this.type,
    required this.city,
    required this.state,
    required this.address,
    required this.description,
    required this.phone,
    required this.email,
    required this.established,
    required this.affiliation,
    required this.lat,
    required this.lng,
    required this.mx,
    required this.my,
  });

  String get googleMapsUrl =>
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';

  Color get typeColor {
    switch (type) {
      case InstitutionType.school:
        return const Color(0xFF1E88E5);
      case InstitutionType.college:
        return const Color(0xFF8E24AA);
      case InstitutionType.university:
        return const Color(0xFFE53935);
      case InstitutionType.center:
        return const Color(0xFF43A047);
    }
  }

  IconData get typeIcon {
    switch (type) {
      case InstitutionType.school:
        return Icons.school_rounded;
      case InstitutionType.college:
        return Icons.account_balance_rounded;
      case InstitutionType.university:
        return Icons.local_library_rounded;
      case InstitutionType.center:
        return Icons.star_rounded;
    }
  }

  String get typeLabel {
    switch (type) {
      case InstitutionType.school:
        return 'School';
      case InstitutionType.college:
        return 'College';
      case InstitutionType.university:
        return 'University';
      case InstitutionType.center:
        return 'Center';
    }
  }
}

const List<BoscoInstitution> kBoscoInstitutions = [
  BoscoInstitution(
    id: 'db_school_guwahati',
    name: 'Don Bosco School',
    shortName: 'DB Guwahati',
    type: InstitutionType.school,
    city: 'Guwahati',
    state: 'Assam',
    address: 'Panbazar, Guwahati, Assam 781001',
    description:
        'One of the premier educational institutions in Northeast India, founded by the Salesians of Don Bosco in 1923. Offers world-class education from Pre-Primary to Class XII, fostering academic excellence and holistic development in the heart of Assam.',
    phone: '+91 361 254 0033',
    email: 'info@dbsguwahati.edu.in',
    established: '1923',
    affiliation: 'CBSE',
    lat: 26.1445,
    lng: 91.7362,
    mx: 0.38,
    my: 0.31,
  ),
  BoscoInstitution(
    id: 'db_university_guwahati',
    name: 'Assam Don Bosco University Azara',
    shortName: 'ADBU Azara',
    type: InstitutionType.university,
    city: 'Guwahati',
    state: 'Assam',
    address: 'Azara, Guwahati, Assam 781017',
    description:
        'A private university established by the Don Bosco Society offering programs in Engineering, Management, Arts, Science, and Humanities. Recognized by the UGC, it is a hub of academic excellence and innovation in Northeast India.',
    phone: '+91 361 298 4500',
    email: 'info@dbuniversity.ac.in',
    established: '2008',
    affiliation: 'UGC Recognized',
    lat: 26.0694,
    lng: 91.5768,
    mx: 0.43,
    my: 0.23,
  ),
  BoscoInstitution(
    id: 'db_college_tura',
    name: 'Don Bosco College',
    shortName: 'DBC Tura',
    type: InstitutionType.college,
    city: 'Tura',
    state: 'Meghalaya',
    address: 'Tura, West Garo Hills, Meghalaya 794001',
    description:
        'A leading arts and science college in the Garo Hills region of Meghalaya. Managed by the Salesians of Don Bosco, it provides quality higher education to tribal communities and youth of the region since 1951.',
    phone: '+91 3651 220123',
    email: 'dbctura@gmail.com',
    established: '1951',
    affiliation: 'NEHU',
    lat: 25.5175,
    lng: 90.2023,
    mx: 0.13,
    my: 0.46,
  ),
  BoscoInstitution(
    id: 'db_school_shillong',
    name: 'Don Bosco School',
    shortName: 'DB Shillong',
    type: InstitutionType.school,
    city: 'Shillong',
    state: 'Meghalaya',
    address: 'Mawlai, Shillong, Meghalaya 793008',
    description:
        'A prestigious school in the "Scotland of the East". Affiliated to CBSE and known for remarkable academic results and vibrant extracurricular activities that shape well-rounded individuals ready for tomorrow\'s world.',
    phone: '+91 364 255 0101',
    email: 'dbsshillong@gmail.com',
    established: '1934',
    affiliation: 'CBSE',
    lat: 25.5788,
    lng: 91.8933,
    mx: 0.40,
    my: 0.48,
  ),
  BoscoInstitution(
    id: 'db_school_dimapur',
    name: 'Don Bosco School',
    shortName: 'DB Dimapur',
    type: InstitutionType.school,
    city: 'Dimapur',
    state: 'Nagaland',
    address: 'Dimapur, Nagaland 797112',
    description:
        'A well-known educational institution in Dimapur, the commercial capital of Nagaland. Provides quality English-medium education and values-based formation to students from diverse tribal communities across the state.',
    phone: '+91 3862 226789',
    email: 'dbsdimapur@gmail.com',
    established: '1955',
    affiliation: 'CBSE',
    lat: 25.9000,
    lng: 93.7200,
    mx: 0.70,
    my: 0.34,
  ),
  BoscoInstitution(
    id: 'db_school_kohima',
    name: 'Don Bosco School',
    shortName: 'DB Kohima',
    type: InstitutionType.school,
    city: 'Kohima',
    state: 'Nagaland',
    address: 'Kohima, Nagaland 797001',
    description:
        'Located in the picturesque capital city of Nagaland, this school has been instrumental in shaping the educational landscape of the state. It blends academic rigour with Salesian values and cultural pride.',
    phone: '+91 370 222 1234',
    email: 'dbskohima@gmail.com',
    established: '1948',
    affiliation: 'CBSE',
    lat: 25.6751,
    lng: 94.1086,
    mx: 0.77,
    my: 0.43,
  ),
  BoscoInstitution(
    id: 'db_school_imphal',
    name: 'Don Bosco School',
    shortName: 'DB Imphal',
    type: InstitutionType.school,
    city: 'Imphal',
    state: 'Manipur',
    address: 'Imphal, Manipur 795001',
    description:
        'A premier institution in Manipur serving students from across the valley. Renowned for excellent academic performance, sports achievements, and strong character formation rooted in Salesian spirituality.',
    phone: '+91 385 244 5678',
    email: 'dbsimphal@gmail.com',
    established: '1946',
    affiliation: 'CBSE',
    lat: 24.8170,
    lng: 93.9368,
    mx: 0.73,
    my: 0.61,
  ),
  BoscoInstitution(
    id: 'db_college_maram',
    name: 'Don Bosco College',
    shortName: 'DBC Maram',
    type: InstitutionType.college,
    city: 'Maram',
    state: 'Manipur',
    address: 'Maram, Senapati District, Manipur 795013',
    description:
        'Serving the tribal communities in the hills of Manipur, this college offers undergraduate programs in Arts, Science and Commerce. It is a beacon of opportunity for first-generation learners in remote areas.',
    phone: '+91 385 288 1234',
    email: 'dbcmaram@gmail.com',
    established: '1975',
    affiliation: 'Manipur University',
    lat: 25.0667,
    lng: 94.1167,
    mx: 0.77,
    my: 0.53,
  ),
  BoscoInstitution(
    id: 'db_school_agartala',
    name: 'Don Bosco School',
    shortName: 'DB Agartala',
    type: InstitutionType.school,
    city: 'Agartala',
    state: 'Tripura',
    address: 'Agartala, Tripura 799001',
    description:
        'One of the premier schools in Tripura, providing excellent education to the youth of the state since 1952. Known for strong academics, cultural events, and the Salesian tradition of "Good Christians, Honest Citizens".',
    phone: '+91 381 222 3456',
    email: 'dbsagartala@gmail.com',
    established: '1952',
    affiliation: 'CBSE',
    lat: 23.8315,
    lng: 91.2868,
    mx: 0.28,
    my: 0.81,
  ),
  BoscoInstitution(
    id: 'db_school_dibrugarh',
    name: 'Don Bosco School',
    shortName: 'DB Dibrugarh',
    type: InstitutionType.school,
    city: 'Dibrugarh',
    state: 'Assam',
    address: 'Dibrugarh, Assam 786001',
    description:
        'Located in the "Tea Capital of the World", this school has a proud legacy of producing outstanding alumni who serve the nation and society. Offers comprehensive education from kindergarten through Class XII.',
    phone: '+91 373 232 1234',
    email: 'dbsdibrugarh@gmail.com',
    established: '1940',
    affiliation: 'CBSE',
    lat: 27.4728,
    lng: 94.9101,
    mx: 0.87,
    my: 0.14,
  ),
];

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// CARTOON MAP BACKGROUND PAINTER
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class CartoonMapPainter extends CustomPainter {
  final BoscoInstitution? navigatingTo;
  final Offset userLocation;
  final double pathProgress;

  CartoonMapPainter({
    this.navigatingTo,
    required this.userLocation,
    required this.pathProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    _drawBackground(canvas, size);
    _drawFrame(canvas, size);
    _drawWaterBodies(canvas, size);
    _drawTerrain(canvas, size);
    _drawHillsAndTrees(canvas, size);
    _drawRoads(canvas, size);
    _drawClouds(canvas, size);
    _drawStateLabels(canvas, size);
    _drawTitle(canvas, size);
    _drawCompassRose(canvas, Offset(w - 75, h - 75), 48);
    _drawScaleBar(canvas, size);
    if (navigatingTo != null && pathProgress > 0) {
      _drawNavigationPath(canvas, size);
    }
  }

  void _drawBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.1,
        colors: [
          const Color(0xFFFCF0D0),
          const Color(0xFFF5E4B0),
          const Color(0xFFEDD89A),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Subtle texture dots
    final dotPaint = Paint()..color = const Color(0xFFE8D28A).withValues(alpha: 0.3);
    final random = math.Random(42);
    for (var i = 0; i < 120; i++) {
      canvas.drawCircle(
        Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        random.nextDouble() * 2 + 0.5,
        dotPaint,
      );
    }
  }

  void _drawFrame(Canvas canvas, Size size) {
    final outer = Paint()
      ..color = const Color(0xFFB8966E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    final inner = Paint()
      ..color = const Color(0xFFCDAA80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final outerRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(8, 8, size.width - 16, size.height - 16),
        const Radius.circular(6));
    final innerRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(18, 18, size.width - 36, size.height - 36),
        const Radius.circular(4));

    canvas.drawRRect(outerRect, outer);
    canvas.drawRRect(innerRect, inner);

    // Corner ornaments
    for (final pos in [
      const Offset(8, 8), Offset(size.width - 8, 8),
      Offset(8, size.height - 8), Offset(size.width - 8, size.height - 8),
    ]) {
      canvas.drawCircle(pos, 7,
          Paint()..color = const Color(0xFFB8966E)..style = PaintingStyle.fill);
      canvas.drawCircle(pos, 7,
          Paint()..color = Colors.white.withValues(alpha: 0.3)..style = PaintingStyle.fill);
    }
  }

  void _drawWaterBodies(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Brahmaputra river body fill
    final riverFill = Paint()
      ..color = const Color(0xFF89CFF0).withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    final riverPath = Path()
      ..moveTo(w * 0.02, h * 0.24)
      ..cubicTo(w * 0.14, h * 0.20, w * 0.28, h * 0.27, w * 0.42, h * 0.30)
      ..cubicTo(w * 0.56, h * 0.32, w * 0.72, h * 0.25, w * 0.95, h * 0.20)
      ..lineTo(w * 0.95, h * 0.26)
      ..cubicTo(w * 0.72, h * 0.31, w * 0.56, h * 0.38, w * 0.42, h * 0.36)
      ..cubicTo(w * 0.28, h * 0.33, w * 0.14, h * 0.26, w * 0.02, h * 0.30)
      ..close();
    canvas.drawPath(riverPath, riverFill);

    // River sparkle / highlight
    final riverHighlight = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final highlightPath = Path()
      ..moveTo(w * 0.05, h * 0.26)
      ..cubicTo(w * 0.20, h * 0.22, w * 0.35, h * 0.28, w * 0.50, h * 0.31);
    canvas.drawPath(highlightPath, riverHighlight);

    // Barak tributary
    final tribFill = Paint()
      ..color = const Color(0xFF89CFF0).withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;
    final tribPath = Path()
      ..moveTo(w * 0.22, h * 0.76)
      ..quadraticBezierTo(w * 0.30, h * 0.60, w * 0.39, h * 0.49)
      ..lineTo(w * 0.42, h * 0.49)
      ..quadraticBezierTo(w * 0.32, h * 0.61, w * 0.25, h * 0.76)
      ..close();
    canvas.drawPath(tribPath, tribFill);

    // Loktak Lake (Manipur)
    _drawLake(canvas, Offset(w * 0.72, h * 0.65), 20, 13);

    // Umiam Lake (Shillong)
    _drawLake(canvas, Offset(w * 0.39, h * 0.55), 16, 10);

    // River label
    _paintText(canvas, '~ Brahmaputra River ~',
        Offset(w * 0.38, h * 0.195),
        color: const Color(0xFF1565C0),
        fontSize: 11,
        fontStyle: FontStyle.italic,
        weight: FontWeight.w600);
  }

  void _drawLake(Canvas canvas, Offset center, double rx, double ry) {
    final paint = Paint()..color = const Color(0xFF89CFF0).withValues(alpha: 0.65);
    canvas.drawOval(Rect.fromCenter(center: center, width: rx * 2, height: ry * 2), paint);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: rx * 1.5, height: ry),
        Paint()..color = Colors.white.withValues(alpha: 0.25));
  }

  void _drawTerrain(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Arunachal Pradesh (north, cool teal-green)
    _fillRegion(canvas, [
      Offset(w * 0.35, h * 0.04), Offset(w * 0.95, h * 0.02),
      Offset(w * 0.95, h * 0.16), Offset(w * 0.65, h * 0.22),
      Offset(w * 0.40, h * 0.20),
    ], const Color(0xFF80CBC4).withValues(alpha: 0.38));

    // Assam (central)
    _fillRegion(canvas, [
      Offset(w * 0.08, h * 0.22), Offset(w * 0.62, h * 0.18),
      Offset(w * 0.95, h * 0.18), Offset(w * 0.95, h * 0.42),
      Offset(w * 0.64, h * 0.46), Offset(w * 0.46, h * 0.44),
      Offset(w * 0.28, h * 0.48), Offset(w * 0.08, h * 0.43),
    ], const Color(0xFF8BC34A).withValues(alpha: 0.38));

    // Meghalaya (below Assam, left-center)
    _fillRegion(canvas, [
      Offset(w * 0.06, h * 0.44), Offset(w * 0.28, h * 0.48),
      Offset(w * 0.46, h * 0.50), Offset(w * 0.49, h * 0.66),
      Offset(w * 0.36, h * 0.74), Offset(w * 0.10, h * 0.70),
      Offset(w * 0.04, h * 0.57),
    ], const Color(0xFF66BB6A).withValues(alpha: 0.40));

    // Nagaland (east, pine-green)
    _fillRegion(canvas, [
      Offset(w * 0.64, h * 0.22), Offset(w * 0.90, h * 0.18),
      Offset(w * 0.95, h * 0.42), Offset(w * 0.82, h * 0.58),
      Offset(w * 0.66, h * 0.54), Offset(w * 0.62, h * 0.46),
    ], const Color(0xFF558B2F).withValues(alpha: 0.38));

    // Manipur (southeast)
    _fillRegion(canvas, [
      Offset(w * 0.62, h * 0.50), Offset(w * 0.80, h * 0.50),
      Offset(w * 0.87, h * 0.62), Offset(w * 0.80, h * 0.80),
      Offset(w * 0.63, h * 0.80), Offset(w * 0.56, h * 0.68),
    ], const Color(0xFF9CCC65).withValues(alpha: 0.38));

    // Tripura (southwest)
    _fillRegion(canvas, [
      Offset(w * 0.18, h * 0.70), Offset(w * 0.36, h * 0.72),
      Offset(w * 0.41, h * 0.86), Offset(w * 0.28, h * 0.93),
      Offset(w * 0.14, h * 0.88), Offset(w * 0.08, h * 0.76),
    ], const Color(0xFFA5D6A7).withValues(alpha: 0.40));

    // Mizoram (south-center)
    _fillRegion(canvas, [
      Offset(w * 0.38, h * 0.73), Offset(w * 0.56, h * 0.70),
      Offset(w * 0.60, h * 0.88), Offset(w * 0.44, h * 0.94),
      Offset(w * 0.32, h * 0.90),
    ], const Color(0xFFC8E6C9).withValues(alpha: 0.40));

    _drawStateBorders(canvas, size);
  }

  void _fillRegion(Canvas canvas, List<Offset> pts, Color color) {
    if (pts.length < 3) return;
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx, pts[i].dy);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  void _drawStateBorders(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = const Color(0xFF9E8A6E).withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    void border(List<Offset> pts) {
      final path = Path()..moveTo(pts[0].dx, pts[0].dy);
      for (var i = 1; i < pts.length; i++) { path.lineTo(pts[i].dx, pts[i].dy); }
      canvas.drawPath(path, paint);
    }

    border([Offset(w*0.08,h*0.43), Offset(w*0.28,h*0.48), Offset(w*0.46,h*0.50)]);
    border([Offset(w*0.46,h*0.50), Offset(w*0.49,h*0.66), Offset(w*0.36,h*0.74)]);
    border([Offset(w*0.62,h*0.46), Offset(w*0.64,h*0.22)]);
    border([Offset(w*0.62,h*0.50), Offset(w*0.80,h*0.50)]);
    border([Offset(w*0.18,h*0.70), Offset(w*0.36,h*0.72)]);
  }

  void _drawHillsAndTrees(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Meghalaya hills
    _hills(canvas, [
      Offset(w*0.15, h*0.55), Offset(w*0.22, h*0.53),
      Offset(w*0.30, h*0.56), Offset(w*0.18, h*0.62),
    ], 26, const Color(0xFF558B2F));

    // Nagaland/Manipur hills
    _hills(canvas, [
      Offset(w*0.68, h*0.50), Offset(w*0.74, h*0.53),
      Offset(w*0.80, h*0.51), Offset(w*0.72, h*0.58),
    ], 24, const Color(0xFF33691E));

    // Arunachal hills
    _hills(canvas, [
      Offset(w*0.55, h*0.10), Offset(w*0.70, h*0.08),
      Offset(w*0.80, h*0.11),
    ], 22, const Color(0xFF00796B));

    // Trees scattered across map
    for (final pt in [
      Offset(w*0.50, h*0.38), Offset(w*0.56, h*0.32),
      Offset(w*0.20, h*0.36), Offset(w*0.64, h*0.38),
      Offset(w*0.34, h*0.56), Offset(w*0.48, h*0.59),
      Offset(w*0.75, h*0.65), Offset(w*0.22, h*0.79),
      Offset(w*0.60, h*0.76), Offset(w*0.12, h*0.58),
      Offset(w*0.52, h*0.22), Offset(w*0.83, h*0.25),
    ]) {
      _treeCluster(canvas, pt, 4);
    }
  }

  void _hills(Canvas canvas, List<Offset> centers, double r, Color color) {
    for (final c in centers) {
      final path = Path()
        ..moveTo(c.dx - r, c.dy + r * 0.5)
        ..quadraticBezierTo(c.dx, c.dy - r, c.dx + r, c.dy + r * 0.5)
        ..close();
      canvas.drawPath(path, Paint()..color = color.withValues(alpha: 0.55));
      // Snowy top
      final snowPath = Path()
        ..moveTo(c.dx - r * 0.25, c.dy - r * 0.55)
        ..quadraticBezierTo(c.dx, c.dy - r * 0.95, c.dx + r * 0.25, c.dy - r * 0.55)
        ..close();
      canvas.drawPath(snowPath, Paint()..color = Colors.white.withValues(alpha: 0.35));
    }
  }

  void _treeCluster(Canvas canvas, Offset center, int count) {
    final rng = math.Random(center.dx.toInt() * 31 + center.dy.toInt());
    for (var i = 0; i < count; i++) {
      final off = Offset(
        center.dx + (rng.nextDouble() - 0.5) * 28,
        center.dy + (rng.nextDouble() - 0.5) * 20,
      );
      _drawTree(canvas, off);
    }
  }

  void _drawTree(Canvas canvas, Offset p) {
    // Trunk
    canvas.drawRect(
        Rect.fromCenter(center: Offset(p.dx, p.dy + 6), width: 3, height: 9),
        Paint()..color = const Color(0xFF5D4037));
    // Bottom layer
    final p1 = Path()
      ..moveTo(p.dx - 8, p.dy + 3)
      ..lineTo(p.dx, p.dy - 6)
      ..lineTo(p.dx + 8, p.dy + 3)
      ..close();
    canvas.drawPath(p1, Paint()..color = const Color(0xFF2E7D32));
    // Top layer
    final p2 = Path()
      ..moveTo(p.dx - 5.5, p.dy - 1)
      ..lineTo(p.dx, p.dy - 10)
      ..lineTo(p.dx + 5.5, p.dy - 1)
      ..close();
    canvas.drawPath(p2, Paint()..color = const Color(0xFF388E3C));
  }

  void _drawRoads(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final outline = Paint()
      ..color = const Color(0xFFD4A832)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final road = Paint()
      ..color = const Color(0xFFF5D76E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    void drawRoad(List<Offset> pts) {
      final path = Path()..moveTo(pts[0].dx, pts[0].dy);
      if (pts.length == 4) {
        path.cubicTo(pts[1].dx, pts[1].dy, pts[2].dx, pts[2].dy, pts[3].dx, pts[3].dy);
      } else if (pts.length == 3) {
        path.quadraticBezierTo(pts[1].dx, pts[1].dy, pts[2].dx, pts[2].dy);
      } else {
        for (var i = 1; i < pts.length; i++) { path.lineTo(pts[i].dx, pts[i].dy); }
      }
      canvas.drawPath(path, outline);
      canvas.drawPath(path, road);
    }

    // NH-27 / NH-37 Guwahati â†’ East
    drawRoad([
      Offset(w*0.38, h*0.31), Offset(w*0.52, h*0.29),
      Offset(w*0.65, h*0.33), Offset(w*0.72, h*0.35),
    ]);
    // Guwahati â†’ Tura (NH-17)
    drawRoad([
      Offset(w*0.38, h*0.31), Offset(w*0.27, h*0.36),
      Offset(w*0.18, h*0.43), Offset(w*0.13, h*0.47),
    ]);
    // Guwahati â†’ Shillong (NH-6 / NH-40)
    drawRoad([
      Offset(w*0.38, h*0.33), Offset(w*0.38, h*0.40),
      Offset(w*0.40, h*0.48),
    ]);
    // Dimapur â†’ Kohima â†’ Imphal (NH-29)
    drawRoad([
      Offset(w*0.72, h*0.35), Offset(w*0.75, h*0.44),
      Offset(w*0.77, h*0.53), Offset(w*0.73, h*0.61),
    ]);
    // Guwahati â†’ Agartala (via Shillong)
    drawRoad([
      Offset(w*0.40, h*0.50), Offset(w*0.38, h*0.60),
      Offset(w*0.34, h*0.70), Offset(w*0.28, h*0.80),
    ]);
    // Guwahati â†’ Dibrugarh (NH-37)
    drawRoad([
      Offset(w*0.44, h*0.30), Offset(w*0.62, h*0.25),
      Offset(w*0.76, h*0.20), Offset(w*0.87, h*0.15),
    ]);

    // NH labels
    _paintText(canvas, 'NH 27', Offset(w*0.55, h*0.275), color: const Color(0xFF7A5800), fontSize: 9, fontStyle: FontStyle.italic);
    _paintText(canvas, 'NH 6', Offset(w*0.44, h*0.415), color: const Color(0xFF7A5800), fontSize: 9, fontStyle: FontStyle.italic);
    _paintText(canvas, 'NH 29', Offset(w*0.80, h*0.47), color: const Color(0xFF7A5800), fontSize: 9, fontStyle: FontStyle.italic);
  }

  void _drawClouds(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    _cloud(canvas, Offset(w*0.16, h*0.07));
    _cloud(canvas, Offset(w*0.74, h*0.05));
    _cloud(canvas, Offset(w*0.52, h*0.95));
  }

  void _cloud(Canvas canvas, Offset pos) {
    final p = Paint()..color = Colors.white.withValues(alpha: 0.72);
    for (final d in [
      const Offset(0, 0), const Offset(20, 4),
      const Offset(-17, 6), const Offset(5, 9),
    ]) {
      canvas.drawCircle(pos + d, 14 - d.dy * 0.3, p);
    }
  }

  void _drawStateLabels(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    for (final item in [
      ['ASSAM', w*0.42, h*0.36],
      ['MEGHALAYA', w*0.22, h*0.59],
      ['NAGALAND', w*0.77, h*0.38],
      ['MANIPUR', w*0.72, h*0.64],
      ['TRIPURA', w*0.24, h*0.82],
      ['MIZORAM', w*0.47, h*0.84],
      ['ARUNACHAL\nPRADESH', w*0.62, h*0.10],
    ]) {
      _paintText(canvas, item[0] as String,
          Offset(item[1] as double, item[2] as double),
          color: const Color(0xFF4E342E),
          fontSize: 10,
          weight: FontWeight.w800,
          letterSpacing: 1.8,
          opacity: 0.5);
    }
  }

  void _drawTitle(Canvas canvas, Size size) {
    _paintText(
      canvas, 'âœ¦  BoscoMap  âœ¦',
      Offset(size.width / 2, size.height * 0.024),
      color: const Color(0xFF4E342E),
      fontSize: 17,
      weight: FontWeight.w900,
      letterSpacing: 3.0,
    );
  }

  void _drawCompassRose(Canvas canvas, Offset c, double r) {
    // Outer rim
    canvas.drawCircle(c, r,
        Paint()..color = const Color(0xFFCDAA80)..style = PaintingStyle.fill);
    canvas.drawCircle(c, r,
        Paint()..color = const Color(0xFFB8966E)..style = PaintingStyle.stroke..strokeWidth = 2);
    canvas.drawCircle(c, r * 0.35,
        Paint()..color = const Color(0xFFE8D29A));

    // 8-point star
    final colors = [
      const Color(0xFFD32F2F), const Color(0xFF4E342E),
      const Color(0xFF4E342E), const Color(0xFF4E342E),
    ];
    final labels = ['N', 'S', 'E', 'W'];
    final angles = [
      -math.pi / 2, math.pi / 2,
      0.0, math.pi,
    ];
    for (var i = 0; i < 4; i++) {
      final a = angles[i];
      final tip = Offset(c.dx + math.cos(a) * r * 0.85, c.dy + math.sin(a) * r * 0.85);
      final perp = Offset(-math.sin(a), math.cos(a));
      final lBase = c + perp * r * 0.2;
      final rBase = c - perp * r * 0.2;

      final path = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(lBase.dx, lBase.dy)
        ..lineTo(c.dx, c.dy)
        ..lineTo(rBase.dx, rBase.dy)
        ..close();
      canvas.drawPath(path, Paint()..color = colors[i]);

      // Label
      final labelPos = Offset(
        c.dx + math.cos(a) * (r + 12),
        c.dy + math.sin(a) * (r + 12),
      );
      _paintText(canvas, labels[i], labelPos,
          color: colors[i], fontSize: 11, weight: FontWeight.w900);
    }
  }

  void _drawScaleBar(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final x0 = w * 0.05, x1 = w * 0.16, y = h * 0.962;

    final p = Paint()
      ..color = const Color(0xFF4E342E)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x0, y - 5), Offset(x0, y + 5), p);
    canvas.drawLine(Offset(x0, y), Offset(x1, y), p);
    canvas.drawLine(Offset(x1, y - 5), Offset(x1, y + 5), p);

    // Mid-tick
    canvas.drawLine(Offset((x0 + x1) / 2, y - 3), Offset((x0 + x1) / 2, y + 3), p);

    _paintText(canvas, '0', Offset(x0, y - 9), color: const Color(0xFF4E342E), fontSize: 8);
    _paintText(canvas, '100 km', Offset(x1, y - 9), color: const Color(0xFF4E342E), fontSize: 8);
  }

  void _drawNavigationPath(Canvas canvas, Size size) {
    if (navigatingTo == null) return;
    final w = size.width;
    final h = size.height;

    final start = userLocation;
    final end = Offset(navigatingTo!.mx * w, navigatingTo!.my * h);
    final total = (end - start).distance;
    final current = total * pathProgress;
    final dir = (end - start) / total;

    // Glow behind path
    final glowPaint = Paint()
      ..color = const Color(0xFFFF5722).withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    // Animated dashes
    final dashPaint = Paint()
      ..color = const Color(0xFFFF5722)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    var drawn = 0.0;
    var dash = true;
    while (drawn < current) {
      final segLen = dash ? 14.0 : 7.0;
      final next = math.min(drawn + segLen, current);
      if (dash) {
        final p1 = start + dir * drawn;
        final p2 = start + dir * next;
        canvas.drawLine(p1, p2, glowPaint);
        canvas.drawLine(p1, p2, dashPaint);
      }
      drawn = next;
      dash = !dash;
    }

    // Arrowhead
    if (pathProgress > 0.08) {
      final tipPos = start + dir * math.min(current, total * 0.96);
      final perp = Offset(-dir.dy, dir.dx);
      const as_ = 14.0;
      final arrow = Path()
        ..moveTo(tipPos.dx + dir.dx * as_, tipPos.dy + dir.dy * as_)
        ..lineTo(tipPos.dx + perp.dx * as_ * 0.5, tipPos.dy + perp.dy * as_ * 0.5)
        ..lineTo(tipPos.dx - perp.dx * as_ * 0.5, tipPos.dy - perp.dy * as_ * 0.5)
        ..close();
      canvas.drawPath(arrow,
          Paint()..color = const Color(0xFFFF5722)..style = PaintingStyle.fill);
    }
  }

  void _paintText(
    Canvas canvas,
    String text,
    Offset center, {
    required Color color,
    required double fontSize,
    FontWeight weight = FontWeight.w600,
    FontStyle fontStyle = FontStyle.normal,
    double letterSpacing = 0,
    double opacity = 1.0,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: opacity),
          fontSize: fontSize,
          fontWeight: weight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();
    tp.paint(canvas,
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(CartoonMapPainter old) =>
      old.navigatingTo != navigatingTo ||
      old.pathProgress != pathProgress ||
      old.userLocation != userLocation;
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// MAIN MAP SCREEN
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  static const double _cW = 1400;
  static const double _cH = 900;

  // â”€â”€ Animations â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  late AnimationController _pathCtrl;
  late Animation<double> _pathAnim;

  late AnimationController _cardCtrl;
  late Animation<double> _cardAnim;

  late AnimationController _pinCtrl;
  late Animation<double> _pinBounce;

  // â”€â”€ State â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  BoscoInstitution? _selected;
  BoscoInstitution? _navigatingTo;
  final TextEditingController _searchCtrl = TextEditingController();
  List<BoscoInstitution> _searchResults = [];
  bool _showResults = false;
  final TransformationController _transformCtrl = TransformationController();

  // User location on the canvas (near Guwahati)
  final Offset _userLoc = const Offset(_cW * 0.355, _cH * 0.345);

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
    _pulseAnim = Tween(begin: 0.0, end: 1.0).animate(_pulseCtrl);

    _pathCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));
    _pathAnim = CurvedAnimation(parent: _pathCtrl, curve: Curves.easeInOut);

    _cardCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 380));
    _cardAnim = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutCubic);

    _pinCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _pinBounce = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -18.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: -18.0, end: 6.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _pinCtrl, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) => _fitMap());
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _pathCtrl.dispose();
    _cardCtrl.dispose();
    _pinCtrl.dispose();
    _searchCtrl.dispose();
    _transformCtrl.dispose();
    super.dispose();
  }

  // â”€â”€ Map helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  void _fitMap() {
    if (!mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final s = box.size;
    final scale = (math.min(s.width / _cW, (s.height - 110) / _cH) * 0.96)
        .clamp(0.2, 1.0);
    final tx = (s.width - _cW * scale) / 2;
    final ty = (s.height - _cH * scale) / 2;
    _transformCtrl.value = Matrix4.identity()
      ..translateByDouble(tx, ty, 0, 1.0)
      ..scaleByDouble(scale, scale, 1.0, 1.0);
  }

  void _zoom(double factor) {
    final m = _transformCtrl.value.clone();
    final s = m.getMaxScaleOnAxis();
    final ns = (s * factor).clamp(0.2, 3.5);
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final sc = box.size;
    final cx = sc.width / 2;
    final cy = sc.height / 2;
    // Get current translation
    final currentTx = m.getTranslation().x;
    final currentTy = m.getTranslation().y;

    // Zoom around the viewport center
    final ratio = ns / s;
    final newTx = cx - (cx - currentTx) * ratio;
    final newTy = cy - (cy - currentTy) * ratio;

    final newM = Matrix4.identity()
      ..translateByDouble(newTx, newTy, 0, 1.0)
      ..scaleByDouble(ns, ns, 1.0, 1.0);
    _transformCtrl.value = newM;
  }

  void _focusOn(BoscoInstitution inst) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final s = box.size;
    const scale = 1.4;
    final tx = s.width / 2 - inst.mx * _cW * scale;
    final ty = s.height / 2 - inst.my * _cH * scale;
    final m = Matrix4.identity()..translateByDouble(tx, ty, 0, 1.0)..scaleByDouble(scale, scale, 1.0, 1.0);
    _transformCtrl.value = m;
  }

  // â”€â”€ Interaction â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  void _selectInstitution(BoscoInstitution inst) {
    setState(() {
      _selected = inst;
      _navigatingTo = null;
      _showResults = false;
      _pathCtrl.reset();
    });
    _pinCtrl.forward(from: 0);
    _cardCtrl.forward(from: 0);
  }

  void _clearSelection() {
    _cardCtrl.reverse().then((_) {
      if (mounted) setState(() => _selected = null);
    });
  }

  void _onSearch(String q) {
    if (q.trim().isEmpty) {
      setState(() { _searchResults = []; _showResults = false; });
      return;
    }
    final lower = q.toLowerCase();
    final results = kBoscoInstitutions
        .where((i) =>
            i.name.toLowerCase().contains(lower) ||
            i.city.toLowerCase().contains(lower) ||
            i.state.toLowerCase().contains(lower) ||
            i.shortName.toLowerCase().contains(lower))
        .toList();
    setState(() { _searchResults = results; _showResults = true; });
  }

  void _submitSearch() {
    _onSearch(_searchCtrl.text);
    FocusScope.of(context).unfocus();
    if (_searchResults.length == 1) {
      _selectInstitution(_searchResults.first);
      _focusOn(_searchResults.first);
    } else if (_searchResults.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No institutions found. Try another name or city.'),
          backgroundColor: Color(0xFFE53935),
        ),
      );
    }
  }

  void _navigateTo(BoscoInstitution inst) {
    setState(() => _navigatingTo = inst);
    _pathCtrl.forward(from: 0);
    showDialog(
      context: context,
      builder: (_) => _NavigateDialog(institution: inst),
    );
  }

  // â”€â”€ Build â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top + 8;
    final bottomPad = _selected != null ? 270.0 : 30.0;
    final navBottomPad = MediaQuery.of(context).padding.bottom + 100.0;

    return Scaffold(
      backgroundColor: const Color(0xFFEDD89A),
      body: Stack(
        children: [
          // â”€â”€ Map canvas â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (_selected != null) _clearSelection();
                if (_showResults) setState(() => _showResults = false);
              },
              child: InteractiveViewer(
                transformationController: _transformCtrl,
                minScale: 0.2,
                maxScale: 3.5,
                constrained: false,
                child: SizedBox(
                  width: _cW,
                  height: _cH,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Cartoon map background
                      AnimatedBuilder(
                        animation: _pathAnim,
                        builder: (_, __) => CustomPaint(
                          size: const Size(_cW, _cH),
                          painter: CartoonMapPainter(
                            navigatingTo: _navigatingTo,
                            userLocation: _userLoc,
                            pathProgress: _pathAnim.value,
                          ),
                        ),
                      ),

                      // Institution markers
                      ...kBoscoInstitutions.map((inst) => _MarkerWidget(
                            institution: inst,
                            isSelected: _selected?.id == inst.id,
                            isNavigating: _navigatingTo?.id == inst.id,
                            pinBounce: _pinBounce,
                            pinCtrl: _pinCtrl,
                            onTap: () => _selectInstitution(inst),
                          )),

                      // User location
                      _UserLocationMarker(
                          pulse: _pulseAnim, position: _userLoc),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // â”€â”€ Search bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned(
            top: 48,
            left: 16,
            right: 16,
            child: _SearchBar(
              controller: _searchCtrl,
              onChanged: _onSearch,
              onSubmit: _submitSearch,
            ),
          ),

          // â”€â”€ Search results â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          if (_showResults && _searchResults.isNotEmpty)
            Positioned(
              top: 110,
              left: 16,
              right: 90,
              child: _SearchResults(
                results: _searchResults,
                onSelect: (inst) {
                  _selectInstitution(inst);
                  _focusOn(inst);
                  setState(() {
                    _showResults = false;
                    _searchCtrl.text = inst.name;
                  });
                },
              ),
            ),

          // â”€â”€ Zoom controls â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned(
            right: 14,
            top: 120,
            child: _ZoomPanel(
              onZoomIn: () => _zoom(1.3),
              onZoomOut: () => _zoom(0.77),
              onReset: _fitMap,
            ),
          ),

          // â”€â”€ Legend â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          const Positioned(
            bottom: 30,
            left: 14,
            child: _Legend(),
          ),

          // â”€â”€ My-location FAB â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          AnimatedPositioned(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            bottom: bottomPad,
            right: 14,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              onPressed: _fitMap,
              child: const Icon(Icons.my_location_rounded),
            ),
          ),

          // â”€â”€ Institution info card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          if (_selected != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _cardAnim,
                builder: (_, child) => Transform.translate(
                  offset: Offset(0, (1 - _cardAnim.value) * 320),
                  child: child,
                ),
                child: _InstitutionCard(
                  institution: _selected!,
                  onClose: _clearSelection,
                  onKnowMore: () => _showKnowMore(_selected!),
                  onNavigate: () => _navigateTo(_selected!),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showKnowMore(BoscoInstitution inst) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _KnowMoreSheet(institution: inst),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// MARKER WIDGET
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _MarkerWidget extends StatelessWidget {
  final BoscoInstitution institution;
  final bool isSelected;
  final bool isNavigating;
  final Animation<double> pinBounce;
  final AnimationController pinCtrl;
  final VoidCallback onTap;

  const _MarkerWidget({
    required this.institution,
    required this.isSelected,
    required this.isNavigating,
    required this.pinBounce,
    required this.pinCtrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isNavigating
        ? const Color(0xFFFF5722)
        : institution.typeColor;

    return Positioned(
      left: institution.mx * 1400 - 22,
      top: institution.my * 900 - 58,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: pinBounce,
          builder: (_, child) => Transform.translate(
            offset: isSelected ? Offset(0, pinBounce.value) : Offset.zero,
            child: child,
          ),
          child: AnimatedScale(
            scale: isSelected ? 1.25 : 1.0,
            duration: const Duration(milliseconds: 350),
            curve: Curves.elasticOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Label bubble
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? color : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : color,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: isSelected ? 0.4 : 0.15),
                        blurRadius: isSelected ? 10 : 4,
                      ),
                    ],
                  ),
                  child: Text(
                    institution.shortName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : color,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 2),

                // Pin circle
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Shadow
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Container(
                        width: 18,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        // Circle
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(institution.typeIcon,
                              color: Colors.white, size: 18),
                        ),
                        // Pointer
                        CustomPaint(
                          size: const Size(12, 9),
                          painter: _PointerPainter(color),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PointerPainter extends CustomPainter {
  final Color color;
  const _PointerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_PointerPainter old) => old.color != color;
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// USER LOCATION MARKER
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _UserLocationMarker extends StatelessWidget {
  final Animation<double> pulse;
  final Offset position;

  const _UserLocationMarker({required this.pulse, required this.position});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 20,
      top: position.dy - 20,
      child: AnimatedBuilder(
        animation: pulse,
        builder: (_, __) => SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulse ring
              Container(
                width: 20 + pulse.value * 36,
                height: 20 + pulse.value * 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1565C0)
                      .withValues(alpha: 0.12 * (1 - pulse.value)),
                  border: Border.all(
                    color: const Color(0xFF1565C0)
                        .withValues(alpha: 0.4 * (1 - pulse.value)),
                    width: 1.5,
                  ),
                ),
              ),
              // Inner glow
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1565C0),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x771565C0), blurRadius: 10, spreadRadius: 2),
                  ],
                ),
              ),
              // Core white dot
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// SEARCH BAR
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;

  const _SearchBar(
      {required this.controller,
      required this.onChanged,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: (_) => onSubmit(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E2022)),
              decoration: const InputDecoration(
                hintText: 'Search Don Bosco Institutions...',
                hintStyle:
                    TextStyle(color: Color(0xFF9CA3AF), fontWeight: FontWeight.w400),
                prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF6B7280)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Search button
        GestureDetector(
          onTap: onSubmit,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFCD1C), Color(0xFFFF9800)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFCD1C).withValues(alpha: 0.45),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.search_rounded, color: Colors.white, size: 18),
                SizedBox(width: 5),
                Text('Search',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// SEARCH RESULTS DROPDOWN
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _SearchResults extends StatelessWidget {
  final List<BoscoInstitution> results;
  final ValueChanged<BoscoInstitution> onSelect;

  const _SearchResults({required this.results, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.13),
              blurRadius: 24,
              offset: const Offset(0, 8)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: results.take(5).map((inst) {
            return ListTile(
              dense: true,
              leading: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: inst.typeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(inst.typeIcon, color: inst.typeColor, size: 17),
              ),
              title: Text(inst.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13)),
              subtitle: Text('${inst.city}, ${inst.state}',
                  style: const TextStyle(
                      color: Color(0xFF6B7280), fontSize: 11)),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 12, color: Colors.grey[400]),
              onTap: () => onSelect(inst),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// ZOOM PANEL
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _ZoomPanel extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onReset;

  const _ZoomPanel(
      {required this.onZoomIn,
      required this.onZoomOut,
      required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ZBtn(icon: Icons.add_rounded, onTap: onZoomIn, tooltip: 'Zoom In'),
          Container(height: 1, color: const Color(0xFFE5E7EB)),
          _ZBtn(icon: Icons.remove_rounded, onTap: onZoomOut, tooltip: 'Zoom Out'),
          Container(height: 1, color: const Color(0xFFE5E7EB)),
          _ZBtn(
              icon: Icons.fit_screen_rounded,
              onTap: onReset,
              tooltip: 'Fit Map'),
        ],
      ),
    );
  }
}

class _ZBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _ZBtn(
      {required this.icon, required this.onTap, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          child: Icon(icon, size: 22, color: const Color(0xFF374151)),
        ),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// LEGEND
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.1), blurRadius: 12)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('LEGEND',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 9,
                  color: Color(0xFF4E342E),
                  letterSpacing: 1.5)),
          const SizedBox(height: 6),
          for (final type in InstitutionType.values) ...[
            _LegendRow(type: type),
            const SizedBox(height: 3),
          ],
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  final InstitutionType type;
  const _LegendRow({required this.type});

  @override
  Widget build(BuildContext context) {
    final dummy = BoscoInstitution(
      id: '', name: '', shortName: '', type: type,
      city: '', state: '', address: '', description: '',
      phone: '', email: '', established: '', affiliation: '',
      lat: 0, lng: 0, mx: 0, my: 0,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: dummy.typeColor, shape: BoxShape.circle),
          child: Icon(dummy.typeIcon, color: Colors.white, size: 7),
        ),
        const SizedBox(width: 6),
        Text(dummy.typeLabel,
            style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// INSTITUTION CARD (bottom sheet preview)
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _InstitutionCard extends StatelessWidget {
  final BoscoInstitution institution;
  final VoidCallback onClose;
  final VoidCallback onKnowMore;
  final VoidCallback onNavigate;

  const _InstitutionCard({
    required this.institution,
    required this.onClose,
    required this.onKnowMore,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final c = institution.typeColor;
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 32,
              offset: const Offset(0, -8)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2)),
          ),

          Row(
            children: [
              // Icon
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [c, c.withValues(alpha: 0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: c.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Icon(institution.typeIcon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(institution.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 17,
                            color: Color(0xFF1E2022))),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: 13, color: c),
                        const SizedBox(width: 3),
                        Text('${institution.city}, ${institution.state}',
                            style: const TextStyle(
                                color: Color(0xFF6B7280), fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.close_rounded,
                      size: 16, color: Color(0xFF6B7280)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Info chips
          Row(
            children: [
              _Chip(label: 'Est.', value: institution.established, color: c),
              const SizedBox(width: 8),
              _Chip(label: institution.typeLabel, value: institution.affiliation, color: c),
              const SizedBox(width: 8),
              _Chip(label: 'State', value: institution.state, color: c),
            ],
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              // Know More
              Expanded(
                child: GestureDetector(
                  onTap: onKnowMore,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: c.withValues(alpha: 0.25), width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline_rounded, color: c, size: 17),
                        const SizedBox(width: 6),
                        Text('Know More',
                            style: TextStyle(
                                color: c,
                                fontWeight: FontWeight.w800,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Take Me There
              Expanded(
                child: GestureDetector(
                  onTap: onNavigate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [c, c.withValues(alpha: 0.75)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: c.withValues(alpha: 0.4),
                            blurRadius: 14,
                            offset: const Offset(0, 5))
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.navigation_rounded,
                            color: Colors.white, size: 17),
                        SizedBox(width: 6),
                        Text('Take Me There',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _Chip(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(
                    color: color, fontSize: 9, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xFF1E2022),
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// KNOW MORE BOTTOM SHEET
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _KnowMoreSheet extends StatelessWidget {
  final BoscoInstitution institution;

  const _KnowMoreSheet({required this.institution});

  @override
  Widget build(BuildContext context) {
    final c = institution.typeColor;
    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (ctx, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          controller: scrollCtrl,
          child: Column(
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 14, bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2)),
              ),

              // Header gradient band
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [c.withValues(alpha: 0.08), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [c, c.withValues(alpha: 0.65)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                              color: c.withValues(alpha: 0.35),
                              blurRadius: 14,
                              offset: const Offset(0, 5))
                        ],
                      ),
                      child: Icon(institution.typeIcon,
                          color: Colors.white, size: 34),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: c.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(institution.typeLabel,
                                style: TextStyle(
                                    color: c,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800)),
                          ),
                          const SizedBox(height: 6),
                          Text(institution.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Color(0xFF1E2022))),
                          const SizedBox(height: 2),
                          Text('${institution.city}, ${institution.state}',
                              style: const TextStyle(
                                  color: Color(0xFF6B7280), fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats
                    Row(
                      children: [
                        _StatCard(
                            label: 'Established',
                            value: institution.established,
                            icon: Icons.history_edu_rounded,
                            color: c),
                        const SizedBox(width: 12),
                        _StatCard(
                            label: 'Affiliation',
                            value: institution.affiliation,
                            icon: Icons.verified_rounded,
                            color: c),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _sectionTitle('About'),
                    const SizedBox(height: 8),
                    Text(institution.description,
                        style: const TextStyle(
                            color: Color(0xFF4B5563),
                            fontSize: 14,
                            height: 1.7)),

                    const SizedBox(height: 24),
                    _sectionTitle('Contact'),
                    const SizedBox(height: 10),
                    _ContactRow(
                        icon: Icons.location_on_rounded,
                        text: institution.address,
                        color: c),
                    const SizedBox(height: 8),
                    _ContactRow(
                        icon: Icons.phone_rounded,
                        text: institution.phone,
                        color: c),
                    const SizedBox(height: 8),
                    _ContactRow(
                        icon: Icons.email_rounded,
                        text: institution.email,
                        color: c),

                    const SizedBox(height: 28),

                    // Open in Google Maps
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final url = Uri.parse(institution.googleMapsUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: const Icon(Icons.map_rounded),
                        label: const Text('Open in Google Maps'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: Color(0xFF1E2022)),
      );
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.15), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(value,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Color(0xFF1E2022))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _ContactRow(
      {required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(9)),
          child: Icon(icon, color: color, size: 15),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(text,
                style: const TextStyle(
                    color: Color(0xFF4B5563), fontSize: 13, height: 1.4)),
          ),
        ),
      ],
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// NAVIGATE DIALOG
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

class _NavigateDialog extends StatelessWidget {
  final BoscoInstitution institution;

  const _NavigateDialog({required this.institution});

  @override
  Widget build(BuildContext context) {
    final c = institution.typeColor;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 40,
                offset: const Offset(0, 16))
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with animated ring
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [c, c.withValues(alpha: 0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: c.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 4)
                ],
              ),
              child: const Icon(Icons.navigation_rounded,
                  color: Colors.white, size: 34),
            ),
            const SizedBox(height: 20),
            const Text('Navigation Ready!',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
            const SizedBox(height: 8),
            Text(
              'Route drawn on BoscoMap.\nOpen Google Maps for real-time GPS navigation to ${institution.name}, ${institution.city}.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xFF6B7280), fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: c.withValues(alpha: 0.3), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Stay on BoscoMap',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      final url = Uri.parse(institution.googleMapsUrl);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    icon: const Icon(Icons.open_in_new_rounded, size: 16),
                    label: const Text('Open Google Maps'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
