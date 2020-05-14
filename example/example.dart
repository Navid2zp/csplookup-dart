import 'package:csplookup/csplookup.dart' as csplookup;

void handleResponse(csplookup.LookupResponse response) {
	// call checkAPIError() to check for API errors (Limit reached, Invalid key, etc.)
	try {
		response.checkAPIError();
	} on csplookup.InvalidKeyException {
		print('api key is not valid');
		return;
		// All exceptions are avilable in exceptions file
	} catch(e) {
		print('exception: ' + e.toString());
		return;
	}

	var result = response.getResult();
	print(result);
	// Instance of LookupResult
	print(result.country.isoCode);
	// Country iso code
}

void main(List<String> arguments) async {
  var client = csplookup.LookupClient(apiKey: 'YOUR_API_KEY');
  client.ipLookup('1.1.1.1').then((response) => handleResponse(response));
}
