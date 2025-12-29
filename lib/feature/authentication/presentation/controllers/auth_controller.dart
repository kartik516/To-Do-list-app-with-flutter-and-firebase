import 'dart:async';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:todo_firebase_yt/feature/authentication/data/auth_repository.dart';
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  AuthController(this.ref) : super(const AsyncData<void>(null));

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email: email, password: password); 
                await ref.read(authRepositoryProvider).signOut();

      state = const AsyncData<void>(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      state = const AsyncData<void>(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).signOut();
      state = const AsyncData<void>(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}