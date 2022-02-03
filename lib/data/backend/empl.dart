import 'package:appflug/data/backend/base.dart';
import 'package:appflug/enums/status_option.dart';

extension EmplBackendService on BackendService {
  Future<void> createUserInDatabase({
    required String uid,
    required StatusOption statusOption,
    required String email,
  }) async {
    await firestoreInstance
        .collection(keys.getKeyFromStatusOption(statusOption))
        .doc(uid)
        .set(
      {
        keys.uid: uid,
        keys.status: statusOption.name,
        keys.email: email,
      },
    );
  }
}
