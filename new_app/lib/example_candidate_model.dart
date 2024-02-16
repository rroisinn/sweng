import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ExampleCandidateModel {
  final String name;
  final String image;
  final String link;
  final String price;

  ExampleCandidateModel({
    required this.name,
    required this.image,
    required this.link,
    required this.price,
  });
}

// final List<ExampleCandidateModel> candidates = [
//   ExampleCandidateModel(
//     name: 'One, 1',
//     job: 'Developer',
//     city: 'Areado',
//     color: const [Color(0xFFFF3868), Color(0xFFFFB49A)],
//   ),
//   ExampleCandidateModel(
//     name: 'Two, 2',
//     job: 'Manager',
//     city: 'New York',
//     color: const [Color(0xFF736EFE), Color(0xFF62E4EC)],
//   ),
//   ExampleCandidateModel(
//     name: 'Three, 3',
//     job: 'Engineer',
//     city: 'London',
//     color: const [Color(0xFF2F80ED), Color(0xFF56CCF2)],
//   ),
//   ExampleCandidateModel(
//     name: 'Four, 4',
//     job: 'Designer',
//     city: 'Tokyo',
//     color: const [Color(0xFF0BA4E0), Color(0xFFA9E4BD)],
//   ),
// ];
