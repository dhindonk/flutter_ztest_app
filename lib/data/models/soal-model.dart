
import 'dart:convert';

SoalModel soalModelFromJson(String str) => SoalModel.fromJson(json.decode(str));

String soalModelToJson(SoalModel data) => json.encode(data.toJson());

class SoalModel {
  List<Datum> data;

  SoalModel({
    required this.data,
  });

  factory SoalModel.fromJson(Map<String, dynamic> json) => SoalModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int no;
  String pertanyaan;
  String pilihanA;
  String pilihanB;
  String pilihanC;
  String pilihanD;
  String kunciJawaban;

  Datum({
    required this.no,
    required this.pertanyaan,
    required this.pilihanA,
    required this.pilihanB,
    required this.pilihanC,
    required this.pilihanD,
    required this.kunciJawaban,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        no: json["no"],
        pertanyaan: json["pertanyaan"],
        pilihanA: json["pilihan_a"],
        pilihanB: json["pilihan_b"],
        pilihanC: json["pilihan_c"],
        pilihanD: json["pilihan_d"],
        kunciJawaban: json["kunci_jawaban"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "pertanyaan": pertanyaan,
        "pilihan_a": pilihanA,
        "pilihan_b": pilihanB,
        "pilihan_c": pilihanC,
        "pilihan_d": pilihanD,
        "kunci_jawaban": kunciJawaban,
      };
}


