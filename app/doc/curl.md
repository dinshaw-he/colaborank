
curl -d 'pointed_event[value]=1000&pointed_event[type]=PR_APPROVAL&pointed_event[user]=github' https://colaborank.herokuapp.com/api/v1/pointed_events.json

curl -d 'pointed_event[value]=1000&pointed_event[type]=PR_COAUTHORS&pointed_event[emails][]=homer@simpsons.com&pointed_event[emails][]=marge@simpsons.com' localhost:3000/api/v1/pointed_events.json
