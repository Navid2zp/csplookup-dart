# csplookup

Client package for CSP Lookup API.

### Install

```
dependencies:
  csplookup: ^0.9.3
```

### Usage

```dart
import 'package:csplookup/csplookup.dart' as csplookup;

var client = csplookup.LookupClient(apiKey: 'YOUR_API_KEY');
client.ipLookup('1.1.1.1').then((response) => handleResponse(response));


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
```

#### Client methods:

```dart
// set https for request
// Default: true
client.setHttps(false)

// Set request timeout
// Default: 10 seconds
client.setTimeout(Duration(seconds: 2))
```

#### Response methods:

```dart
// returns Result instance
// same as 'response.result'
response.getResult()


// returns country iso code (String)
// same as 'response.result.country.isoCode'
response.getCountryCode()

// returns country name in english (String)
// other languages are available in 'result.country.names' (Map<String,String>)
// same as 'response.result.country.names['en']'
response.getCountryName()

// returns city name in english (String)
// other languages are available in 'result.city.names' (Map<String,String>)
// same as 'response.result.city.names['en']'
response.getCityName()

```

## License

MIT
