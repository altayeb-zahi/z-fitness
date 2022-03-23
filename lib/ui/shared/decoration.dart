import 'package:flutter/material.dart';

var searchTextField = InputDecoration(
  prefixIcon: const Icon(Icons.search),
  suffixIcon: const Icon(Icons.tune_outlined),
  hintText: 'Search Recipes...',
  hintStyle: const TextStyle(color: Colors.grey),
  filled: true,
  fillColor: Colors.grey[300],
  enabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.grey[300]!),
  ),
);
