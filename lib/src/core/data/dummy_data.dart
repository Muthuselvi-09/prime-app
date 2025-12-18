import 'package:flutter/material.dart';

class DummyDataService {
  static List<Map<String, dynamic>> categories = [
    {
      'id': 'c1',
      'label': 'Traffic Cones',
      'icon': Icons.traffic_rounded,
      'image': 'assets/images/cat_cones.png'
    },
    {
      'id': 'c2',
      'label': 'Safety Jackets',
      'icon': Icons.person_add_alt_1_rounded, // Best fit for now
      'image': 'assets/images/cat_jackets.png'
    },
    {
      'id': 'c3',
      'label': 'Barricades',
      'icon': Icons.fence_rounded,
      'image': 'assets/images/cat_barricades.png'
    },
    {
      'id': 'c4',
      'label': 'Road Studs',
      'icon': Icons.light_mode_rounded,
      'image': 'assets/images/cat_studs.png'
    },
    {
      'id': 'c5',
      'label': 'Helmets',
      'icon': Icons.security_rounded,
      'image': 'assets/images/cat_helmets.png'
    },
    {
      'id': 'c6',
      'label': 'Speed Breakers',
      'icon': Icons.waves_rounded,
      'image': 'assets/images/cat_breakers.png'
    },
    {
      'id': 'c7',
      'label': 'Reflective Tapes',
      'icon': Icons.format_paint_rounded,
      'image': 'assets/images/cat_tape.png'
    },
    {
      'id': 'c8',
      'label': 'Gloves',
      'icon': Icons.back_hand_rounded,
      'image': 'assets/images/cat_gloves.png'
    },
  ];

  static const List<Map<String, dynamic>> sellers = [
    {
      'id': 's1',
      'name': 'RoadSafe India Pvt Ltd',
      'location': 'Mumbai, Maharashtra',
      'verified': true,
      'rating': 4.8,
      'memberSince': '2016',
      'responseRate': '98%'
    },
    {
      'id': 's2',
      'name': 'Safety First Supplies',
      'location': 'Delhi, NCR',
      'verified': true,
      'rating': 4.5,
      'memberSince': '2019',
      'responseRate': '92%'
    },
    {
      'id': 's3',
      'name': 'National Highways Corp',
      'location': 'Bangalore, Karnataka',
      'verified': false,
      'rating': 4.2,
      'memberSince': '2021',
      'responseRate': '85%'
    },
  ];

  static const List<Map<String, dynamic>> products = [
    {
      'id': 'p1',
      'name': 'PVC Traffic Cone - 750mm (Red/White)',
      'category': 'Traffic Cones',
      'price': 350.0,
      'moq': 50,
      'rating': 4.7,
      'reviews': 124,
      'sellerId': 's1',
      'image': 'assets/images/prod_cone.png',
      'description': 'Heavy duty flexible PVC traffic cone with high intensity reflective sleeve. Ideal for highway and construction usage. Weight: 3.5kg.'
    },
    {
      'id': 'p2',
      'name': 'High Visibility Reflective Safety Jacket',
      'category': 'Safety Jackets',
      'price': 180.0,
      'moq': 100,
      'rating': 4.5,
      'reviews': 89,
      'sellerId': 's2',
      'image': 'assets/images/prod_jacket.png',
      'description': 'Neon green safety jacket with 2-inch silver reflective tape. Breathable mesh fabric. EN ISO 20471 certified.'
    },
    {
      'id': 'p3',
      'name': 'Plastic Expandable Barricade',
      'category': 'Barricades',
      'price': 2400.0,
      'moq': 5,
      'rating': 4.9,
      'reviews': 32,
      'sellerId': 's1',
      'image': 'assets/images/prod_barricade.png',
      'description': 'Yellow/Black expandable barrier. Extends up to 2.5 meters. Water fillable base for stability.'
    },
    {
      'id': 'p4',
      'name': 'Solar Road Stud (Aluminium)',
      'category': 'Road Studs',
      'price': 450.0,
      'moq': 20,
      'rating': 4.3,
      'reviews': 56,
      'sellerId': 's3',
      'image': 'assets/images/prod_stud.png',
      'description': 'Cast aluminium solar road stud with 6 LEDs. Auto flashing at night. Load capacity: 20 tons.'
    },
    {
      'id': 'p5',
      'name': 'Industrial Safety Helmet',
      'category': 'Helmets',
      'price': 120.0,
      'moq': 200,
      'rating': 4.6,
      'reviews': 210,
      'sellerId': 's2',
      'image': 'assets/images/prod_helmet.png',
      'description': 'HDPE bright yellow helmet with adjustable chin strap. Impact resistant.'
    },
    {
      'id': 'p6',
      'name': 'Rubber Speed Breaker (1 Meter)',
      'category': 'Speed Breakers',
      'price': 1500.0,
      'moq': 10,
      'rating': 4.4,
      'reviews': 45,
      'sellerId': 's1',
      'image': 'assets/images/prod_breaker.png',
      'description': 'Heavy duty rubber speed hump. Dimensions: 1000x350x50mm. Includes fixing bolts.'
    },
  ];
  
  // Helpers
  static Map<String, dynamic>? getSeller(String id) {
    return sellers.firstWhere((element) => element['id'] == id, orElse: () => sellers[0]);
  }
}
