Formulario con Autenticación Firebase

Trabajo Final del Módulo de Desarrollo de Aplicaciones Móviles

## Que se quiere lograr

Esta mini aplicación móvil ha sido desarrollada en **Flutter** e implementa las siguientes funcionalidades:

- Formulario de ingreso de datos personales (nombre, edad, correo electrónico).
- Validación de campos con mensajes de error apropiados.
- Manejo de estado utilizando `setState`.
- Registro e inicio de sesión de usuario mediante **Firebase Authentication** (Email y Contraseña).
- Alerta que muestra los datos ingresados si son válidos.
- Interfaz amigable y funcional.
- Proyecto publicado en GitHub.

---

## Objetivos del Proyecto final

- Utilizar formularios y validaciones en Flutter.
- Aplicar el manejo de estado con `setState`.
- Integrar Firebase Authentication para registro e inicio de sesión con email/contraseña.
- Publicar un proyecto Flutter en GitHub.

---

## Tecnologías Utilizadas

- Flutter SDK
- Firebase (Authentication)
- Dart
- Android Studio / Visual Studio Code
- Git + GitHub

---

## Funcionalidades Implementadas

### 1. Formulario

- **Campos incluidos**:
  - Nombre (obligatorio).
  - Edad (numérica y mayor a cero).
  - Correo electrónico (formato válido).
  - Contraseña (mínimo 6 caracteres).

- **Validaciones**:
  - Verificación de campos vacíos.
  - Edad numérica y válida.
  - Formato correcto de correo.
  - Contraseña con longitud mínima.

- **Resultado**:
  - Al presionar el botón de registro o inicio de sesión, si los datos son válidos, se muestra un `AlertDialog` con la información ingresada y el mensaje correspondiente.

---

### 2. Manejo de Estado (`setState`)

- Se utiliza `setState()` para actualizar el contenido en pantalla, como los mensajes de error, mensajes de bienvenida, y cambio de vistas entre login/registro.

---

### 3. Autenticación Firebase

- Se implementa:
  - **Registro de usuario con email y contraseña.**
  - **Inicio de sesión con email y contraseña.**
  - Cierre de sesión.
  - Mensaje de bienvenida con el correo del usuario autenticado.

- **Requisitos en Firebase Console**:
  - Proyecto creado en [https://console.firebase.google.com](https://console.firebase.google.com).
  - Módulo de Authentication habilitado.
  - Método de autenticación **"Email/Password"** activado.

---

## Estructura del Proyecto

