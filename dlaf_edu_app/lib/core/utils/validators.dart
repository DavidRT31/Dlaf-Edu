class Validators {
  // Para la validación de ingreso de solo números
  static String? validarSoloNumeros(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    final RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Solo se permite el ingreso de números';
    }
    return null;
  }

  // Para la validación de ingreso de solo texto
  static String? validarSoloTexto(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    final RegExp regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$');
    if (!regex.hasMatch(value)) {
      return 'Solo se permite el ingreso de texto';
    }
    return null;
  }

  // Para validar un ingreso mínimo de texto u data
  static String? validateMinLength(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    if (value.length < minLength) {
      return 'Debe tener al menos $minLength caracteres';
    }
    return null;
  }

  // Para validar un ingreso máximo de texto u data
  static String? validateMaxLength(String? value, int maxLength) {
    if (value != null && value.length > maxLength) {
      return 'Debe tener como máximo $maxLength caracteres';
    }
    return null;
  }

  // Para validar un ingreso exacto de texto u data (Ejemplo: El campo debe tener si o si 8 dígitos, en caso de un DNI)
  static String? validateExactLength(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    if (value.length != length) {
      return 'Debe tener exactamente $length caracteres';
    }
    return null;
  }

  // Para validar un ingreso de un correo
  static String? validarCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regex.hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }
}
