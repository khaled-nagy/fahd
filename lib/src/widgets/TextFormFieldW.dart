import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TextFormFieldW extends StatefulWidget {
  final TextInputType textInputType ;
   TextEditingController controller;
   Function validator ;
   bool obSecureText ;
   String hintText ;
   String image ;


  TextFormFieldW({this.textInputType , this.controller , this.validator , this.obSecureText , this.hintText ,this.image});
  @override
  _TextFormFieldWState createState() => _TextFormFieldWState();
}

class _TextFormFieldWState extends State<TextFormFieldW> {
  @override
  Widget build(BuildContext context) {
    return   Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(12)),
                          height: 50,
                          child: Row(
                            textDirection: ui.TextDirection.ltr,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, right: 16, left: 16),
                                child: Image.asset(
                                  widget.image,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Expanded(
                                                            child: Container(
                                  
                                  child: TextFormField(
                                    style: Theme.of(context).textTheme.display1,
                                    keyboardType: widget.textInputType,
                                    textDirection: ui.TextDirection.ltr,
                                    controller:
                                        widget.controller,
                                    validator: widget.validator,
                                    obscureText: widget.obSecureText,
                                    decoration: InputDecoration(
                                      
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          right: 8.0, top: 0.0, left: 8),
                                      hintText: widget.hintText,
                                      hintStyle: TextStyle(color: Colors.grey[400] ,fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
  }
}