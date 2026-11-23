import 'package:flutter_test/flutter_test.dart';
import 'package:app_parcial/models/video_model.dart';

void main() {
  group('Pruebas unitarias de modelos y validaciones', () {
    test('El feed debe contener al menos 4 videos en vertical', () {
      expect(VideoModel.sampleVideos.length, greaterThanOrEqualTo(4));
    });

    test('Los videos del feed deben tener URLs y atributos válidos', () {
      for (final video in VideoModel.sampleVideos) {
        expect(video.id.isNotEmpty, true);
        expect(video.videoUrl.startsWith('http'), true);
        expect(video.username.startsWith('@'), true);
        expect(video.description.isNotEmpty, true);
        expect(video.likesCount, greaterThan(0));
      }
    });

    test('Validación de formato de correo electrónico', () {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      expect(emailRegex.hasMatch('test@gmail.com'), true);
      expect(emailRegex.hasMatch('usuario.valido@empresa.co'), true);
      expect(emailRegex.hasMatch('correo-invalido'), false);
      expect(emailRegex.hasMatch('correo@sin-dominio'), false);
      expect(emailRegex.hasMatch(''), false);
    });

    test('Validación de longitud mínima de contraseña (mínimo 6 caracteres)', () {
      bool isPasswordValid(String pass) => pass.length >= 6;

      expect(isPasswordValid('12345'), false);
      expect(isPasswordValid('123456'), true);
      expect(isPasswordValid('abcdefgh'), true);
    });

    test('Validación de coincidencia de contraseñas', () {
      bool passwordsMatch(String pass1, String pass2) => pass1 == pass2;

      expect(passwordsMatch('clave123', 'clave123'), true);
      expect(passwordsMatch('clave123', 'clave456'), false);
    });
  });
}
