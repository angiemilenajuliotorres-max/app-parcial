# App Parcial - Flutter + Firebase + TikTok Feed

Aplicación móvil y web desarrollada en **Flutter** con autenticación multicanal en **Firebase**, enrutamiento reactivo con **GoRouter** y un reproductor de videos verticales a pantalla completa interactivo estilo **TikTok**.

---

## 📱 Características Principales

### 1. Autenticación con Firebase
- **Correo y Contraseña**:
  - **Login (`/login`)**: Formulario con validación de campos obligatorios y formato de email. Gestión detallada de errores (usuario no encontrado, credenciales incorrectas, demasiados intentos, cuenta deshabilitada).
  - **Registro (`/registro`)**: Formulario con validación de nombre completo, formato de correo, contraseña mínima de 6 caracteres y confirmación exacta de contraseñas. Crea la cuenta mediante `createUserWithEmailAndPassword` y almacena el nombre con `updateDisplayName`.
- **Inicio de Sesión con Google**:
  - Integración mediante `GoogleAuthProvider` (Web) y `google_sign_in` (móvil).
- **Inicio de Sesión con Facebook**:
  - Integración mediante `FacebookAuthProvider` (Web) y `flutter_facebook_auth` (móvil).
- **Cierre de Sesión Unificado**:
  - Botón de Logout en el feed que muestra el nombre o correo del usuario conectado y revoca las sesiones activas en Firebase, Google y Facebook simultáneamente.

### 2. Enrutamiento Protegido con `go_router`
- **Rutas configuradas**:
  - `/login` (Vista inicial predeterminada sin sesión)
  - `/registro` (Formulario de nueva cuenta)
  - `/feed` (Feed estilo TikTok protegido)
- **Lógica de `redirect`**:
  - **Sin sesión iniciada**: Únicamente se permite acceder a `/login` y `/registro`. Si el usuario intenta navegar a `/feed` u otra ruta protegida, es redirigido automáticamente a `/login`.
  - **Con sesión iniciada**: Al autenticarse (por correo, Google o Facebook), la aplicación redirige de forma reactiva a `/feed`. Cualquier intento de volver a `/login` o `/registro` redirige directamente al `/feed`.

### 3. Feed de Videos Vertical Estilo TikTok (`/feed`)
- **PageView Vertical**: Desplazamiento vertical fluido entre al menos 4 videos en pantalla completa (`BoxFit.cover`).
- **Reproducción Inteligente**: Reproducción automática **exclusiva** del video visible en pantalla; los videos anteriores o siguientes se pausan automáticamente al deslizar.
- **Control Táctil**: Tocar la pantalla alterna entre reproducir y pausar con un indicador animado translúcido en el centro.
- **Interfaz Superpuesta (Overlay)**:
  - Nombre del creador con insignia de verificación.
  - Descripción del video con etiquetas y hashtags.
  - Audio original con pista musical.
  - Contador de **Me Gusta** interactivo (cambia a rojo e incrementa el contador al pulsar).
  - Botón de **Comentarios** que abre una hoja inferior interactiva (Bottom Sheet).
  - Botón de **Compartir** con notificación flotante.
  - Disco de música giratorio animado que rota al ritmo de la reproducción.
- **Barra Superior**: Pestañas "Siguiendo" / "Para ti", chip con el nombre/correo del usuario autenticado y botón de Logout con modal de confirmación.

---

## 🛠️ Tecnologías y Paquetes Utilizados

| Paquete | Versión | Propósito |
| :--- | :--- | :--- |
| `flutter` | 3.47+ / SDK Dart 3.13+ | Framework principal multiplataforma |
| `go_router` | ^18.1.4 | Navegación declarativa y guards de redirección reactiva |
| `firebase_core` | ^5.2.0 | Inicialización del ecosistema Firebase |
| `firebase_auth` | ^7.1.0 | Autenticación y gestión de usuarios |
| `google_sign_in` | ^6.2.1 | Autenticación con cuentas de Google |
| `flutter_facebook_auth` | ^7.3.3 | Autenticación con cuentas de Facebook |
| `video_player` | ^2.14.1 | Reproducción de videos y streaming multimedia |

---

## ⚙️ Configuración de Firebase

El proyecto ya está vinculado con Firebase CLI al proyecto `app-parcial-12e1f` y cuenta con el archivo generado `lib/firebase_options.dart`.

### Habilitar Métodos en Firebase Console:
1. Ingresa a la consola de Firebase: [https://console.firebase.google.com/project/app-parcial-12e1f/authentication/providers](https://console.firebase.google.com/project/app-parcial-12e1f/authentication/providers).
2. Dirígete a **Build > Authentication > Sign-in method**:
   - **Correo electrónico/Contraseña**:
     - Clic en "Correo electrónico/contraseña", activa el interruptor y pulsa **Guardar**.
   - **Google**:
     - Clic en "Google", activa el interruptor, asigna un correo de asistencia técnica y pulsa **Guardar**.
   - **Facebook**:
     - Clic en "Facebook", activa el interruptor.
     - Ingresa tu **ID de la aplicación** y **Secreto de la aplicación** obtenidos desde [Meta for Developers](https://developers.facebook.com/).
     - Copia el URI de redireccionamiento de OAuth proporcionado por Firebase y pégalo en la configuración de inicio de sesión con Facebook en Meta.

---

## 🚀 Instrucciones para Ejecutar la Aplicación

### 1. Clonar el repositorio e instalar dependencias
```bash
git clone <URL_DEL_REPOSITORIO>
cd app-parcial
flutter pub get
```

### 2. Ejecutar pruebas unitarias
```bash
flutter test
```

### 3. Ejecutar en Navegador Web (Chrome o Edge)
```bash
flutter run -d chrome
```

### 4. Compilar para Producción Web
```bash
flutter build web
```

---

## 📸 Capturas de Pantalla y Demostración

A continuación se presentan las secciones correspondientes a la demostración visual de la aplicación:

### 1. Vista de Login (`/login`)
- Formulario con validación de correo y contraseña obligatorios y formato.
- Enlace "¿No tienes cuenta? Regístrate".
- Botones de inicio de sesión rápido con Google y Facebook.

*(Inserta aquí tu captura: `assets/screenshots/login.png`)*

---

### 2. Vista de Registro (`/registro`)
- Campos de nombre completo, correo, contraseña (mínimo 6 caracteres) y confirmar contraseña.
- Validación de coincidencia de contraseñas y mensajes de error descriptivos.
- Redirección automática al feed al registrarse con éxito.

*(Inserta aquí tu captura: `assets/screenshots/registro.png`)*

---

### 3. Métodos de Inicio de Sesión
- Demostración de acceso mediante Correo y Contraseña.
- Ventana emergente de inicio de sesión con Google.
- Ventana emergente de inicio de sesión con Facebook.

*(Inserta aquí tus capturas o GIF: `assets/screenshots/auth_methods.png`)*

---

### 4. Feed de Videos Vertical Estilo TikTok (`/feed`)
- Desplazamiento vertical entre los 4 videos.
- Auto-play del video enfocado y pausa con toque en pantalla.
- Insignia de usuario, descripción, contador de likes interactivo, comentarios y audio giratorio.
- Barra superior con nombre/correo del usuario y botón de Logout.

*(Inserta aquí tu video o captura: `assets/screenshots/feed_tiktok.png`)*

---

## 📦 Instrucciones para Subir a GitHub

Para subir el proyecto a un repositorio nuevo en GitHub:

```bash
# 1. Inicializar git si es necesario
git init

# 2. Agregar todos los archivos
git add .

# 3. Crear el commit inicial
git commit -m "Entrega Parcial: Flutter + Firebase Auth + GoRouter + TikTok Feed"

# 4. Vincular con el repositorio remoto de GitHub
git branch -M main
git remote add origin https://github.com/<TU_USUARIO>/<TU_REPOSITORIO>.git

# 5. Subir los cambios
git push -u origin main
```

---

## 👨‍💻 Autor
Proyecto desarrollado para la materia de Ingeniería de Software.
