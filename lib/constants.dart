

const jsonFileName = "badminton_matches.json";

const githubJsonBaseUrl = "https://api.github.com/repos/mdrokz/badminton_tracker/contents/$jsonFileName";

const owner = "mdrokz";

const repo = "badminton_tracker";

const githubAPIUrl = "https://api.github.com/repos/$owner/$repo/contents/$jsonFileName";

const devToken = String.fromEnvironment('GH_TOKEN', defaultValue: '');

const matchTypes = ['Singles','Doubles'];

const headers = {
  'Accept': 'application/vnd.github.v3+json',
  'Authorization': 'token $devToken'
};
