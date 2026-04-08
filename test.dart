import 'package:http/http.dart' as http; void main() async { var res = await http.post(Uri.parse('https://api.mindglow.tech/v1/users/signup/')); print(res.statusCode); print(res.request?.url); }
