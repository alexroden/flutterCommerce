import 'package:flutter/material.dart';

double getWidthUnits(BuildContext context) =>
    MediaQuery.of(context).size.width / 100;

double getHeightUnits(BuildContext context) =>
    MediaQuery.of(context).size.height / 100;

double getTextScaleFactor(BuildContext context) =>
    MediaQuery.of(context).textScaleFactor;

Map<String, double> getMediaQuery(BuildContext context) => <String, double>{
  'height': getHeightUnits(context),
  'width': getWidthUnits(context),
  'scaleFactor': getTextScaleFactor(context),
};