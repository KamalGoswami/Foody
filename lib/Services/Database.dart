import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseMethods {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    try {

      final response = await _client
          .from('users')
          .upsert({...userInfoMap, 'id': id});

      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      print('Error adding user details: $e');
    }
  }

  Future<void> addProduct(Map<String, dynamic> userInfoMap, String categoryName) async {
    try {


      final response = await _client
          .from(categoryName)
          .insert(userInfoMap);

      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      print('Error adding product: $e');
    }
  }


  Future<Stream<List<Map<String, dynamic>>>> getProduct(String category) async {
    final supabase = Supabase.instance.client;


    final productStream = supabase
        .from(category)
        .stream(primaryKey: ['id'])
        .execute();

    return productStream;
  }



  //Future<void> addToCart(Map<String, dynamic> userInfoMap, String id) async {
  //  final supabase = Supabase.instance.client;
//
  //  final response = await supabase
  //      .from('cart')
  //      .insert({
  //    'user_id': id,
  //    ...userInfoMap,
  //  });
//
  //  if (response.error != null) {
  //    throw Exception('Failed to add to cart: ${response.error!.message}');
  //  }
  //}


}
