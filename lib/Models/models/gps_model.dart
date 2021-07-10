// To parse this JSON data, do
//
//     final gpsPost = gpsPostFromJson(jsonString);

import 'dart:convert';

GpsPost gpsPostFromJson(String str) => GpsPost.fromJson(json.decode(str));

String gpsPostToJson(GpsPost data) => json.encode(data.toJson());

class GpsPost {
    GpsPost({
        this.success,
        this.response,
        this.details,
    });

    bool success;
    Response response;
    Details details;

    factory GpsPost.fromJson(Map<String, dynamic> json) => GpsPost(
        success: json["success"],
        response: Response.fromJson(json["response"]),
        details: Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "response": response.toJson(),
        "details": details.toJson(),
    };
}

class Details {
    Details({
        this.message,
    });

    String message;

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}

class Response {
    Response({
        this.vehicleId,
        this.vehicleLocations,
    });

    int vehicleId;
    List<double> vehicleLocations;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        vehicleId: json["vehicle_id"],
        vehicleLocations: List<double>.from(json["vehicle_locations"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "vehicle_locations": List<dynamic>.from(vehicleLocations.map((x) => x)),
    };
}
