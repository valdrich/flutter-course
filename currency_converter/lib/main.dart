import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:async/async.dart";
import "dart:convert";


const request = "https://api.hgbrasil.com/finance?key=232aa44e";

void main() async{ //informing that main function is a async

  http.Response response = await http.get(request); //await: you'll wait for that response (sync).
  print(json.decode(response.body)["results"]);

  runApp(MaterialApp(
    home: Container(),
  ));
}