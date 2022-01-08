import 'package:cloud_firestore/cloud_firestore.dart';

import 'keys.dart';

class BackendService {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  BackendKeys keys = const BackendKeys();
}
