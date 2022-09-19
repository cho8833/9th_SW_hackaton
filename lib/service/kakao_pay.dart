import 'dart:convert';

import 'package:http/http.dart';
import 'package:sw_hackathon_2022/constants/constants.dart';

class KakaoPay {
  static Future<Map<String, dynamic>> preparePay() async {
    final uri = Uri(
      scheme: 'https',
      host: 'kapi.kakao.com',
      path: '/v1/payment/ready',
    );

    final client = Client();
    var res = await client.post(
        uri,
        headers: {'Authorization': 'KakaoAK ${Constants.adminKey}'},
        body: {
          'cid': 'TC0ONETIME',
          'partner_order_id': 'partner_order_id',
          "partner_user_id": "partner_user_id",
          'item_name': '목격 영상',
          'quantity': '1',
          'total_amount': '2200',
          'var_amount': '200',
          'tax_free_amount': '0',
          'approval_url': 'https://naver.com',
          'fail_url': 'https://naver.com',
          'cancel_url': 'https://naver.com'
        }
    );
    print(res.body);
    return jsonDecode(res.body);

  }
  static Future<void> approvePay(String tid) async {
    final uri = Uri(
      scheme: 'https',
      host: 'kapi.kakao.com',
      path: '/v1/payment/approve',
    );

    final client = Client();
    var res = await client.post(
        uri,
        headers: {'Authorization': 'KakaoAK ${Constants.adminKey}'},
        body: {
          'cid': 'TC0ONETIME',
          'partner_order_id': 'partner_order_id',
          "partner_user_id": "partner_user_id",
          'tid': tid,
          // 'pg_token':
        }
    );
  }
}