class Hotel{
  int hotelId;
  String hotelName;
  String? hotelContact;
  String hotelDescription;
  String? hotelPicture;
  Hotel({
    required this.hotelId,
    required this.hotelName,
    this.hotelContact,
    required this.hotelDescription,
    this.hotelPicture
  });

  factory Hotel.fromJson(Map<String,dynamic>json){
    return Hotel(
      hotelId: json['hotel_id'] as int,
      hotelName: json['hotel_name'] as String,
      hotelContact: json['hotel_contact'] as String?,
      hotelDescription: json['hotel_description'] as String,
      hotelPicture: json['hotel_picture'] as String?,
    );
  }

}