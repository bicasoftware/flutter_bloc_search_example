import 'package:flutter/material.dart';

@immutable
class Cliente {
  Cliente({
    this.nome,
    this.sobrenome,
    this.nascto,
    this.salario,
  });

  final String nome, sobrenome;
  final DateTime nascto;
  final double salario;

  Cliente copyWith({
    String nome,
    String sobrenome,
    DateTime nascto,
    double salario,
  }) {
    return Cliente(
      nome: nome ?? this.nome,
      sobrenome: sobrenome ?? this.sobrenome,
      nascto: nascto ?? this.nascto,
      salario: salario ?? this.salario,
    );
  }
}
