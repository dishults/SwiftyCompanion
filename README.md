# SwiftyCompanion
Introduction to iOS development.

## Test 42 API V2
Firts, get access to API by registering your app in intra -> settings -> register new app:
- Name: "SwiftyCompanion"
- Redirect URI: http://localhost/callback

Make a note of your UID and SECRET

### Get token
`curl -X POST --data "grant_type=client_credentials&client_id=YOUR_UID&client_secret=YOUR_SECRET" https://api.intra.42.fr/oauth/token`

### Make requests
`curl  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" "https://api.intra.42.fr/v2/users/dshults"`