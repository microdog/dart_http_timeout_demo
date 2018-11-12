import 'dart:io';

main(List<String> args) async {
  final client = new HttpClient();

  // CRITICAL
  // Comment this line and the request will be finished with a
  // [SocketException] caused by system level timeout.
  // If a custom connectionTimeout is set and is shorter than
  // the system timeout, an unexpected [NoSuchMethodError] will
  // be thrown.
  client.connectionTimeout = new Duration(microseconds: 1);

  // expected [SocketException] instead of [NoSuchMethodError]
  await client.getUrl(Uri.parse("http://10.255.255.1"));
}
