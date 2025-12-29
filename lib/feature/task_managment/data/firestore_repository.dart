import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_repository.g.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  void _checkUserPermission(String userId) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || currentUser.uid != userId) {
      throw Exception('Unauthorized access attempt');
    }
  }

  Future<void> addTask({required Task task, required String userId}) async {
    _checkUserPermission(userId);

    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add({
          ...task.toMap(),
          'uid': userId,
        });
    await docRef.update({'id': docRef.id});
  }

  Future<void> updateTask({
    required Task task,
    required String taskId,
    required String userId,
  }) async {
    _checkUserPermission(userId);

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .update(task.toMap());
  }


  Stream<List<Task>> loadTasks(String userId) {
    _checkUserPermission(userId);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Stream<List<Task>> loadCompletedTasks(String userId) {
    _checkUserPermission(userId);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isComplete', isEqualTo: true)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Stream<List<Task>> loadInCompletedTasks(String userId) {
    _checkUserPermission(userId);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isComplete', isEqualTo: false)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Future<void> deleteTask({
    required String userId,
    required String taskId,
  }) async {
    _checkUserPermission(userId);

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }


  Future<void> updateTaskCompletion({
    required String userId,
    required String taskId,
    required bool isComplete,
  }) async {
    _checkUserPermission(userId);

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .update({'isComplete': isComplete});
  }
}

@Riverpod(keepAlive: true)
FirestoreRepository firestoreRepository(FirestoreRepositoryRef ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Task>> loadTasks(LoadTasksRef ref, String userId) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadTasks(userId);
}

@riverpod
Stream<List<Task>> loadCompleteTasks(LoadCompleteTasksRef ref, String userId) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadCompletedTasks(userId);
}

@riverpod
Stream<List<Task>> loadInCompleteTasks(
    LoadInCompleteTasksRef ref, String userId) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return firestoreRepository.loadInCompletedTasks(userId);
}
