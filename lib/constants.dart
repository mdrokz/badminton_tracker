

const jsonFileName = "badminton_matches.json";

const githubJsonBaseUrl = "https://raw.githubusercontent.com/mdrokz/badminton_tracker/master/$jsonFileName";

const owner = "mdrokz";

const repo = "badminton_tracker";

const githubAPIUrl = "https://api.github.com/repos/$owner/$repo/contents/$jsonFileName";

const devToken = "";

const headers = {
  'Accept': 'application/vnd.github.v3+json',
  'Authorization': 'token $devToken'
};