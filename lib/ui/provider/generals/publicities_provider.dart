import 'package:flutter/material.dart';

import '../../../domain/entities/publicity.dart';

class PublicitiesProvider extends ChangeNotifier{
  List<Publicity> _publicitiesRectangle=[];
  List<Publicity> _publicitiesSquare=[];

  void setPublicitiesRectangle(List<Publicity> publicities){
    this._publicitiesRectangle=publicities;
  }
  List<Publicity> get publicitiesRectangle => _publicitiesRectangle;

  void setPublicitiesSquare(List<Publicity> publicities){
    this._publicitiesSquare=publicities;
  }
  List<Publicity> get publicitiesSquare => _publicitiesSquare;
}