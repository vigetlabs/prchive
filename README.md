# PRchive



## Grab all the media from your PRs

Run `npm install prchive -g`, then `prchive` to start. Point PRchive at a project you have access to, and it'll grab all linked files and images from the project's pull requests and save them in a dir that looks like this:

<img src="https://s3.amazonaws.com/f.cl.ly/items/0e0Y2J3Q2A2I1e3K1D0C/Screen%20Shot%202014-12-04%20at%205.00.07%20PM.png">

The leading number before each filename is the PR number. PRchive also include a list of the original URLs, an HTML with images src-ing those URLs, and another page of images pointing to the local copies.

## Development

Run `npm run prepublish && node lib/test.js` to test the script while in development. Create a file called `.config.json` in the root to save on typing time, and fill it with your credentials like this:

```
{
  "username" : "averyvery",
  "password" : "password",
  "repo"     : "vigetlabs/prchive"
}
```

<hr>

See more [Viget(https://viget.com/) projects at [code.viget.com.](http://code.viget.com/)
