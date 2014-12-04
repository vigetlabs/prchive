# PRchive: Grab all the media from your PRs

Run `npm install prchive -g`, then `prchive` to start. Point PRchive at a project you have access to, and it'll grab all the images and gifs from the project's pull requests and save them as files, as a list of links, and as a list of <img> tags.

## Development

Run `npm run prepublish && node lib/test.js` to test the script while in development. Create a file called `.config.json` in the root to save on typing time, and fill it with your credentials like this:
