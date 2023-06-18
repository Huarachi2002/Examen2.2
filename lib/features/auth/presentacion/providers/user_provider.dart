import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _id = "";
  String _nombre = "";
  String _apellido = "";
  String _email = "";
  String _telefono = "";
  String _image = "";
  String _imageHorario = "";
  String _calificacion = "";
  List<String> _role = [];
  bool _sentRequest = false;
  String _token = "";
  bool _loading = false;

  // UserProvider() {
  //   loadingUser(); // Carga el usuario
  // }

  set id(id) {
    _id = id.toString();
    notifyListeners();
  }

  get id => _id;

  set nombre(nombre) {
    _nombre = nombre;
    notifyListeners();
  }

  get nombre => _nombre;

  set apellido(apellido) {
    _apellido = apellido;
    notifyListeners();
  }

  get apellido => _apellido;

  set email(email) {
    _email = email;
    notifyListeners();
  }

  get email => _email;

  set telefono(telefono) {
    _telefono = telefono;
    notifyListeners();
  }

  get telefono => _telefono;

  set token(token) {
    _token = token;
    notifyListeners();
  }

  get token => _token;

  set loading(loading) {
    _loading = loading;
    notifyListeners();
  }

  get loading => _loading;

  set image(image) {
    _image = image;
    notifyListeners();
  }

  set imageHorario(imageHorario) {
    _imageHorario = imageHorario;
    notifyListeners();
  }

  get image => _image;

  void setUser(String id, String? nombre, String? apellido, String? telefono,
      String? email, String? image, String? token) {
    _id = id;
    _nombre = nombre ?? 'Sin Nombre';
    _apellido = apellido ?? 'Sin Apellido';
    _telefono = telefono ?? 'No tiene Telefono';
    _email = email ?? 'No tiene email';
    _image = image ?? '';
    _token = token ?? '';
    notifyListeners();
  }

  get sentRequest => _sentRequest;

  set sentRequest(request) {
    _sentRequest = request;
    notifyListeners();
  }

  bool existNull() =>
      _nombre == '' || _apellido == '' || _telefono == '' || _email == '';
}
