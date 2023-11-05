import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const imgbaseUrl = "https://astro.diploy.in";
const baseUrl = 'https://astro.diploy.in/api';
const api = "getCustomerHome";
const astroapi = "getAstrologer";
const astroToken =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2JoYXZpc2h5YWFzdHJvLmNvbS9hZG1pbi9hcGkvbG9naW5BcHBVc2VyIiwiaWF0IjoxNjk4NDIxNDY0LCJleHAiOjE2OTg2Mzc0NjQsIm5iZiI6MTY5ODQyMTQ2NCwianRpIjoiMzRMWkt6UDljekdCNzRWNyIsInN1YiI6IjU0NCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.uBe9ckcfh8Z_t8DvIEnvt1GLRB8Nful2hqgMkovq78I";
const appcolor = Color(0xffff9700);


String formatDate(String inputDate) {
  final originalFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final newFormat = DateFormat('MMM dd,yyyy');
  final parsedDate = originalFormat.parse(inputDate);
  final formattedDate = newFormat.format(parsedDate);

  return formattedDate;
}