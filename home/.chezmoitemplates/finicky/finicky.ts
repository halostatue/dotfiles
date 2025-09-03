import type {
  BrowserHandler,
  FinickyConfig,
  UrlRewriteRule,
} from '/Applications/Finicky.app/Contents/Resources/finicky.d.ts'

// {{- /* vim: ft=typescript.chezmoitmpl */ -}}
// {{- $work := has "work" (get . "roles" | default list) -}}
// This file is generated from home/private_dot_finicky.ts.tmpl and
// home/.chezmoitemplate/finicky/finicky.ts
// @ts-ignore
const isWork = 'true' === '{{ $work }}'

// {{- $fallbacks := list "Browsers" "Browserosaurus" "BrowserFairy" "OpenIn" -}}
// Set fallback from {{ $fallbacks | join ", " }}, Safari
// {{- $fallback := "Safari" -}}
// {{- range $_, $candidate := $fallbacks -}}
// {{-   $path := printf "/Applications/%s.app" $candidate -}}
// {{-   if stat $path }}{{ $fallback = $candidate }}{{ break }}{{ end -}}
// {{-   $path := printf "/Applications/Setapp/%s.app" $candidate -}}
// {{-   if stat $path }}{{ $fallback = $candidate }}{{ break }}{{ end -}}
// {{- end -}}
// Fallback is: {{ $fallback }}
const Fallback = '{{ $fallback }}'

const Browsers: Record<
  string,
  | string
  | {
      name: string
      appType?: ('appName' | 'bundleId' | 'path' | 'none') | undefined
      openInBackground?: boolean | undefined
      profile?: string | undefined
      args?: string[] | undefined
    }
> = {
  Safari: 'Safari',
  // {{- range $_, $browser := list "Firefox" "Microsoft Edge" "Google Chrome" -}}
  // {{-   $path := printf "/Applications/%s.app" $browser -}}
  // {{-   if not (stat $path) -}}{{ $path = "" }}{{ end }}
  '{{ nospace $browser }}': '{{ $browser }}',
  // {{- end }}
  Music: 'Music',
  Fallback,
}

if (isWork) {
  // The Northern Labs Chrome profile is in the Default folder
  Browsers.NorthernLabs = { name: 'Google Chrome', profile: 'Default' }
  // The Forte Chrome profile is in the Profile 1 folder
  Browsers.Forte = { name: 'Google Chrome', profile: 'Profile 1' }
}

// JWT Decoding from https://github.com/auth0/jwt-decode
// Base64 decoding function base64decode is from https://github.com/dankogai/js-base64.
class InvalidCharacterError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'InvalidCharacterError'
  }
}

class InvalidTokenError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'InvalidTokenError'
  }
}

const base64Re = /^(?:[A-Za-z\d+\/]{4})*?(?:[A-Za-z\d+\/]{2}(?:==)?|[A-Za-z\d+\/]{3}=?)?$/
const base64Chars = Array.prototype.slice.call(
  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=',
)
const base64Tab = {}

for (const [i, c] of base64Chars.entries()) {
  base64Tab[c] = i
}

const _fromCC = String.fromCharCode.bind(String)

const base64Decode = (input: string) => {
  let asc = String(input).replace(/\s+/, '')

  if (!base64Re.test(asc)) {
    throw new InvalidCharacterError('base64decode failed: malformed base64.')
  }

  asc += '=='.slice(2 - (asc.length & 3))

  let u24: number
  let r1: number
  let r2: number
  let bin = ''

  for (let i = 0; i < asc.length; ) {
    r1 = base64Tab[asc.charAt(i++)]
    r2 = base64Tab[asc.charAt(i++)]

    u24 =
      (base64Tab[asc.charAt(i++)] << 18) |
      (base64Tab[asc.charAt(i++)] << 12) |
      (r1 << 6) |
      r2
    bin +=
      r1 === 64
        ? _fromCC((u24 >> 16) & 255)
        : r2 === 64
          ? _fromCC((u24 >> 16) & 255, (u24 >> 8) & 255)
          : _fromCC((u24 >> 16) & 255, (u24 >> 8) & 255, u24 & 255)
  }

  return bin
}

const base64DecodeURI = (str: string) =>
  decodeURIComponent(
    base64Decode(str).replace(/(.)/g, (_m, p) => {
      let code = p.charCodeAt(0).toString(16).toUpperCase()

      if (code.length < 2) {
        code = `0${code}`
      }

      return `%${code}`
    }),
  )

const base64_url_decode = (str: string) => {
  let output = str.replace(/-/g, '+').replace(/_/g, '/')

  switch (output.length % 4) {
    case 0: {
      break
    }
    case 2: {
      output += '=='
      break
    }
    case 3: {
      output += '='
      break
    }
    default: {
      throw 'Illegal base64url string!'
    }
  }

  try {
    return base64DecodeURI(output)
  } catch (_err) {
    return base64Decode(output)
  }
}

const jwt_decode = (token: string, opts: { header?: boolean } = {}) => {
  if (typeof token !== 'string') {
    throw new InvalidTokenError('Invalid token specified')
  }

  const options: { header?: boolean } = opts || {}
  const pos = options.header === true ? 0 : 1

  try {
    return JSON.parse(base64_url_decode(token.split('.')[pos]))
  } catch (e) {
    throw new InvalidTokenError(`Invalid token specified: ${e.message}`)
  }
}

type ExclusionsType = {
  equals: string[]
  startsWith: string[]
  matches: RegExp[]
}

const TRACKING_EXCLUSIONS: ExclusionsType = {
  startsWith: [
    '__hs',
    '_bta_',
    '_ga',
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
    'ICID',
    '__hsfp',
    '__hssc',
    '__hstc',
    '__s',
    '_hsenc',
    '_openstat',
    'atlOrigin',
    'dclid',
    'dm_i',
    'ef_id',
    'epik',
    'fbclid',
    'gclid',
    'gclsrc',
    'gdffi',
    'hsCtaTracking',
    'icid',
    'igshid',
    'mc_eid',
    'mkt_tok',
    'mkwid',
    'ml_subscriber',
    'ml_subscriber_hash',
    'msclkid',
    'ncid',
    'ocid',
    'otc',
    'pcrid',
    'rb_clickid',
    'ref',
    's_cid',
    's_kwcid',
    'spm',
    'srcid',
    'vero_conv',
    'vero_id',
    'wickedid',
    'yclid',
  ],
  matches: [/redirect_.*?mongo_id/, /referer/],
}

const rejectKeyStartingWith = (key: string, { startsWith }) =>
  startsWith.some((pattern: string) => key.startsWith(pattern))
const rejectKeyEquals = (key: string, { equals }) =>
  equals.some((pattern: string) => key === pattern)
const rejectKeyMatches = (key: string, { matches }) =>
  matches.some((pattern: RegExp) => key.match(pattern))

const excludeKey = (key: string, exclusions: ExclusionsType) =>
  rejectKeyMatches(key, exclusions) ||
  rejectKeyStartingWith(key, exclusions) ||
  rejectKeyEquals(key, exclusions)

const rewriteRemoveTracking = (url: URL): URL => {
  const searchParams = url.searchParams

  for (const key of searchParams.keys()) {
    if (excludeKey(key, TRACKING_EXCLUSIONS)) {
      searchParams.delete(key)
    }
  }

  const newUrl = new URL(url)
  const search = searchParams.toString()

  if (search === '') {
    newUrl.search = search
  } else {
    newUrl.search = `?${search}`
  }

  return newUrl
}

const rewrite: UrlRewriteRule[] = [
  {
    match: (url, { opener }) =>
      opener?.bundleId === 'com.tinyspeck.slackmacgap' ||
      /openid\/connect\/login_initiate_redirect/.test(url.href),
    url: (url) => {
      const jwt = url.searchParams.get('login_hint')

      if (!jwt) {
        return url
      }

      try {
        const decoded = jwt_decode(jwt)
        const targetURI = decoded['https://slack.com/target_uri']
        return targetURI ? new URL(targetURI) : url
      } catch (_error) {
        return url
      }
    },
  },
  {
    match: (url) => url.hostname.endsWith('medium.com'),
    url: (url) => {
      const newUrl = new URL(url.href)
      newUrl.hostname = 'scribe.rip'
      return newUrl
    },
  },
  {
    match: /vk\.com\/away.php/,
    url: (url) => {
      const param = url.searchParams.get('to')

      if (!param) {
        return url
      }

      return new URL(decodeURIComponent(decodeURIComponent(param)))
    },
  },
  {
    match: /safelinks\.protection\.outlook\.com/,
    url: (url) => {
      const match = url.searchParams.get('url')

      if (!match) {
        return url
      }

      return new URL(encodeURI(decodeURIComponent(match)))
    },
  },
  {
    match: /id\.atlassian\.com\/login\/initiate\/slack\/external/,
    url: (url) => {
      const param = url.searchParams.get('target_link_url')

      if (!param) {
        return url
      }

      return new URL(decodeURIComponent(param))
    },
  },
  {
    match: () => true,
    url: rewriteRemoveTracking,
  },
]

let handlers: BrowserHandler[] = [
  {
    match: () =>
      finicky.getModifierKeys().option ||
      finicky.getModifierKeys().command ||
      (finicky.getModifierKeys().command && finicky.getModifierKeys().option),
    browser: Browsers.Fallback,
  },
]

let workHandlers: BrowserHandler[] = []

if (isWork) {
  workHandlers = [
    {
      match: (url) =>
        url.hostname.endsWith('github.com') && /\/northernLabs\//i.test(url.pathname),
      browser: Browsers.NorthernLabs,
    },
    {
      match: (url) =>
        url.hostname.endsWith('github.com') && /\/fortelabsinc\//i.test(url.pathname),
      browser: Browsers.NorthernLabs,
    },
    {
      match: (url) =>
        url.hostname === 'northernlabs.atlassian.net' ||
        url.hostname === 'northern-labs.slack.com' ||
        url.hostname === 'app.scalyr.com',
      browser: Browsers.NorthernLabs,
    },
    {
      match: (url) =>
        url.hostname === 'forteio.atlassian.net' || url.hostname === 'forte-io.slack.com',
      browser: Browsers.Forte,
    },
    {
      match: (url) => url.hostname === 'identity.getpostman.com',
      browser: Browsers.NorthernLabs,
    },
    {
      match: (url) => url.hostname === 'forte-io.postman.co',
      browser: Browsers.NorthernLabs,
    },
    {
      match: (url) => url.hostname === 'newreleases.io',
      browser: Browsers.NorthernLabs,
    },
    {
      match: (url) => /flux\.\w+-dev\.cloud/.test(url.hostname),
      browser: Browsers.NorthernLabs,
    },
  ]
}

handlers = handlers.concat(workHandlers).concat([
  {
    match: (url) => url.host === 'meet.google.com',
    browser: Browsers.NorthernLabs || Browsers.GoogleChrome,
  },
  {
    match: (url) => url.host === 'script.google.com',
    browser: Browsers.GoogleChrome,
  },
  {
    match: (url) => url.host === 'teams.microsoft.com',
    browser: Browsers.MicrosoftEdge,
  },
  {
    match: (url) => url.host.endsWith('zoom.us'),
    browser: Browsers.Firefox,
  },
  {
    match: [
      'music.apple.com*',
      'geo.music.apple.com*',
      ({ protocol }) => protocol === 'itmss',
    ],
    browser: Browsers.Music,
  },
  {
    match: (url) => url.host.endsWith('github.com') || url.host.endsWith('github.io'),
    browser: Browsers.Safari,
  },
  {
    match: (_url, { opener }) => !opener?.path && !opener?.name && !opener?.bundleId,
    browser: Browsers.Fallback,
  },
])

export default {
  defaultBrowser: Browsers.Safari,
  options: {
    logRequests: true,
  },
  rewrite,
  handlers,
} satisfies FinickyConfig
