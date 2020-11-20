
curl -d 'pointed_event[repo]=repo&pointed_event[type]=PR_APPROVAL&pointed_event[github_handles][]=simpson' http://localhost:3000/api/v1/pointed_events.json

curl -d 'pointed_event[type]=PR_COAUTHORS&pointed_event[emails][]=homer@simpsons.com&pointed_event[emails][]=marge@simpsons.com' https://colaborank.herokuapp.com/api/v1/pointed_events.json

curl https://colaborank.herokuapp.com/api/v1/pointed_events.json
