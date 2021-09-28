const trackingExclusions = {
  startsWith: [
    '_bta_',
    '_ga',
    '_hsenc',
    '_hsmi',
    '_ke',
    '_openstat',
    'hsa_',
    'mc_',
    'mtm_',
    'ns_',
    'oly_',
    'piwik_',
    'pk_',
    'soc_',
    'sr_',
    'stm_',
    'trk_',
    'uta_',
    'utm_',
    'vero_',
  ],
  equals: [
    'mkwid',
    'msclkid',
    'otc',
    'pcrid',
    'rb_clickid',
    'dm_i',
    'ef_id',
    'epik',
    'ICID',
    'atlOrigin',
    'fbclid',
    'gclid',
    'gclsrc',
    'gdffi',
    'icid',
    'ighsid',
    'mkt_tok',
    'ncid',
    'ocid',
    'ref',
    'spm',
    'srcid',
    's_kwcid',
  ],
  matches: [/redirect_.*?mongo_id/, /referer/],
}

const rejectKeyStartingWith = (key, { startsWith }) => startsWith.some((pattern) => key.startsWith(pattern))
const rejectKeyEquals = (key, { equals }) => equals.some((pattern) => key === pattern)
const rejectKeyMatches = (key, { matches }) => matches.some((pattern) => key.match(pattern))

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
      match: /vk\.com\/away.php/,
      url({ url }) {
        const match = url.search.split('&').find((parameter) => parameter.startsWith('to='))

        if (!match) {
          return url
        }

        return decodeURIComponent(decodeURIComponent(match.split('=')[1]))
      },
    },
    {
      match: /id\.atlassian\.com\/login\/initiate\/slack\/external/,
      url({ url }) {
        const match = url.search.split('&').find((parameter) => parameter.startsWith('target_link_uri='))

        if (!match) {
          return url
        }

        return decodeURIComponent(match.split('=')[1])
      },
    },
    {
      match: () => true,
      url: rewriteRemoveTracking,
    },
  ],
  handlers: [
    {
      match: (match) => {
        const keys = finicky.getKeys()

        return (
          (keys.option || keys.command) &&
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
    {
      match: () => finicky.getKeys().option,
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
