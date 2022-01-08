import 'package:appflug/data/backend/base.dart';
import 'package:appflug/enums/status_option.dart';

extension UserBackendService on BackendService {
  Future<void> createUserInDatabase({
    required String uid,
    required StatusOption statusOption,
  }) async {
    await firestoreInstance
        .collection(keys.getKeyFromStatusOption(statusOption))
        .doc(uid)
        .set(
      {
        keys.uid: uid,
        keys.status: statusOption.name,
      },
    );
  }
}
