const trackingExclusions = {
  startsWith: ['utm_', 'uta_'],
  equals: ['fblid', 'gclid', 'atlOrigin'],
  matches: [],
}

const rejectKeyStartingWith = (key, { startsWith }) => startsWith.some((pattern) => key.startsWith(pattern))
const rejectKeyEquals = (key, { equals }) => equals.some((pattern) => key == pattern)
const rejectKeyMatches = (key, { matches }) => matches.some((pattern) => key.matches(pattern))

const excludeKey = (key, exclusions = trackingExclusions) =>
  rejectKeyMatches(key, exclusions) || rejectKeyStartingWith(key, exclusions) || rejectKeyEquals(key, exclusions)

const rewriteRemoveTracking = ({ url }) => {
  const search = url.search
    .split('&')
    .map((parameter) => parameter.split('='))
    .filter(([key]) => !excludeKey(key, trackingExclusions))
    .map((parameter) => parameter.join('='))
    .join('&')

  return {
    ...url,
    search,
  }
}

module.exports = {
  defaultBrowser: 'Safari',
  options: {
    // hideIcon: true,
  },
  rewrite: [
    {
      match: () => true,
      url: rewriteRemoveTracking,
    },
    {
      match: /vk\.com\/away.php/,
      url({ url }) {
        const match = url.search.match(/to=(.+)/)

        if (!match) {
          return url
        }

        return decodeURIComponent(decodeURIComponent(match[1]))
      },
    },
  ],
  handlers: [
    /*
    {
      match: (match) => {
        return (
          (match.keys.option || match.keys.command) &&
          finicky.matchHostnames([
            'halogenmobile.atlassian.net',
            'jira.com',
            /atlassian.(com|io|net)/,
            'atl-paas.net',
            'jira.e-loreal.com',
          ])(match)
        )
      },
      browser: 'Firefox',
    },
    */
    {
      match: ({ keys }) => keys.option,
      browser: '/Applications/Browserosaurus.app',
    },
    /*
    {
      match: finicky.matchHostnames([
        'halogenmobile.atlassian.net',
        'jira.com',
        /atlassian.(com|io|net)/,
        'atl-paas.net',
        'jira.e-loreal.com',
      ]),
      browser: '/Applications/JIRA.app',
    },
    */
    {
      match: ({ url }) => url.host === 'meet.google.com',
      browser: 'Google Chrome',
    },
    {
      match: ({ url }) => url.host === 'app.jazz.co',
      browser: 'Google Chrome',
    },
    {
      match: ({ url }) => url.host === 'zeplin.io' || url.host === 'zpl.io',
      browser: '/Applications/Zeplin.app',
    },
    {
      match: ({ url }) => url.host === 'teams.microsoft.com',
      browser: 'Microsoft Edge',
    },
    {
      match: finicky.matchHostnames('zoom.us'),
      browser: 'Firefox',
    },
  ],
}
