import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  /// Iniciar sesión con correo y contraseña
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Error inesperado al iniciar sesión: $e';
    }
  }

  /// Registro de nuevo usuario con correo, contraseña y nombre completo
  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Guardar el nombre completo del usuario
      if (credential.user != null) {
        await credential.user!.updateDisplayName(fullName.trim());
        await credential.user!.reload();
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Error inesperado al registrar usuario: $e';
    }
  }

  /// Iniciar sesión con Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // En Web se utiliza el popup de GoogleAuthProvider de Firebase
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');
        return await _auth.signInWithPopup(googleProvider);
      } else {
        // En plataformas móviles nativas
        final GoogleSignIn googleSignIn = GoogleSignIn(
          scopes: ['email', 'profile'],
        );
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          // El usuario canceló el inicio de sesión
          return null;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Error al autenticar con Google: $e';
    }
  }

  /// Iniciar sesión con Facebook
  Future<UserCredential?> signInWithFacebook() async {
    try {
      if (kIsWeb) {
        // En Web se utiliza el popup de FacebookAuthProvider de Firebase
        final FacebookAuthProvider facebookProvider = FacebookAuthProvider();
        facebookProvider.addScope('email');
        facebookProvider.addScope('public_profile');
        return await _auth.signInWithPopup(facebookProvider);
      } else {
        // En plataformas móviles con flutter_facebook_auth
        final LoginResult result = await FacebookAuth.instance.login(
          permissions: ['email', 'public_profile'],
        );

        if (result.status == LoginStatus.success) {
          final OAuthCredential credential = FacebookAuthProvider.credential(
            result.accessToken!.tokenString,
          );
          return await _auth.signInWithCredential(credential);
        } else if (result.status == LoginStatus.cancelled) {
          return null;
        } else {
          throw result.message ?? 'Error desconocido al autenticar con Facebook.';
        }
      }
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Error al autenticar con Facebook: $e';
    }
  }

  /// Cerrar sesión en Firebase, Google y Facebook
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (_) {}

    try {
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
    } catch (_) {}

    try {
      await FacebookAuth.instance.logOut();
    } catch (_) {}
  }

  /// Mapeo de códigos de error de Firebase a mensajes claros en español
  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No existe ningún usuario registrado con este correo.';
      case 'wrong-password':
        return 'La contraseña ingresada es incorrecta.';
      case 'invalid-credential':
        return 'Credenciales inválidas. Verifica tu correo y contraseña.';
      case 'email-already-in-use':
        return 'El correo electrónico ya se encuentra registrado.';
      case 'invalid-email':
        return 'El formato del correo electrónico no es válido.';
      case 'weak-password':
        return 'La contraseña es muy débil. Debe tener al menos 6 caracteres.';
      case 'user-disabled':
        return 'Esta cuenta ha sido inhabilitada por un administrador.';
      case 'too-many-requests':
        return 'Demasiados intentos fallidos. Por favor espera unos momentos e intenta de nuevo.';
      case 'operation-not-allowed':
        return 'Este método de autenticación no está habilitado en Firebase Console.';
      case 'popup-closed-by-user':
        return 'La ventana de inicio de sesión fue cerrada antes de completar la autenticación.';
      case 'account-exists-with-different-credential':
        return 'Ya existe una cuenta con este correo vinculada a otro proveedor.';
      default:
        return e.message ?? 'Ocurrió un error en la autenticación (${e.code}).';
    }
  }
}
