let apikey = (syncthing cli config dump-json | jq -r '.gui.apiKey')
let addr = (syncthing cli config dump-json | jq -r '.gui.address')
let requets_data = (syncthing cli show pending folders | jq '{ id: . | keys[], label: .[][][].label, path: "~/CloudBox/\(.[][][].label)", devices: .[].offeredBy | keys | map({ deviceID: . })}')
post -t application/json -H ["X-API-Key" ($apikey)] $"http://($addr)/rest/config/folders" $requets_data
