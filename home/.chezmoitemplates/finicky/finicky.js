// {{- /* vim: ft=javascript.chezmoitmpl */ -}}
// {{- $work := has "work" (get . "roles" | default list) -}}
// This file is generated from home/private_dot_finicky.js.tmpl and
// home/.chezmoitemplate/finicky/finicky.js
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

const Browsers = {
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

function _hasOwnProperty(obj, prop) {
  return Object.prototype.hasOwnProperty.call(obj, prop)
}

// url-search-params-polyfill by Jerry Bendy (https://github.com/jerrybendy) - MIT license
// Adapted for Finicky as a _ponyfill_ even if Finicky later adds `URLSearchParams`.
const UriEncodingMap = Object.freeze({
  '!': '%21',
  "'": '%27',
  '(': '%28',
  ')': '%29',
  '~': '%7E',
  '%20': '+',
  '%00': '\x00',
})

class UrlSearchParams {
  #internal

  // Construct a UrlSearchParams instance from an object, string, or UrlSearchParams
  constructor(input) {
    let search = input || ''

    // support construct object with another UrlSearchParams instance
    if (search instanceof UrlSearchParams) {
      search = search.toString()
    }

    this.#internal = this.#parseToDict(search)
  }

  // Appends a specified key/value pair as a new search parameter.
  append(name, value) {
    this.#appendTo(this.#internal, name, value)
  }

  // Deletes the given search parameter, and its associated value, from the list of all search parameters.
  delete(name) {
    delete this.#internal[name]
  }

  // Returns the first value associated to the given search parameter.
  get(name) {
    return this.has(name) ? this.#internal[name][0] : null
  }

  // Returns all the values association with a given search parameter.
  getAll(name) {
    return this.has(name) ? this.#internal[name].slice(0) : []
  }

  // Returns a Boolean indicating if such a search parameter exists.
  has(name) {
    return _hasOwnProperty(this.#internal, name)
  }

  // Sets the value associated to a given search parameter to the given value. If there
  // were several values, delete the others.
  set(name, value) {
    this.#internal[name] = [`${value}`]
  }

  // Returns a string containing a query string suitable for use in a URL.
  toString() {
    const query = []

    for (const key of Object.keys(this.#internal)) {
      const name = this.#encode(key)
      for (const value of this.#internal[key]) {
        if (value) {
          query.push(`${name}=${this.#encode(value)}`)
        } else {
          query.push(name)
        }
      }
    }

    return query.join('&')
  }

  // Implement forEach
  forEach(callback, thisArg) {
    for (const [name, value] of Object.entriesl(this.#internal)) {
      callback.call(thisArg, value, name, this)
    }
  }

  // Sort all name-value pairs
  sort() {
    const dict = this.#parseToDict(this.toString())
    const keys = Object.keys(this.#internal).sort()

    this.#internal = {}

    for (const key of keys) {
      for (const value of dict[key]) {
        this.append(key, value)
      }
    }
  }

  // Returns an iterator allowing to go through all keys of the key/value pairs contained
  // in this object.
  keys() {
    return Object.keys(this.#internal)
  }

  // Returns an iterator allowing to go through all values of the key/value pairs
  // contained in this object.
  values() {
    return Object.values(this.#internal)
  }

  // Returns an iterator allowing to go through all key/value pairs contained in this
  // object.
  entries() {
    return Object.entries(this.#internal)
  }

  [Symbol.iterator]() {
    return this.#internal[Symbol.iterator]()
  }

  #appendTo(dict, name, value) {
    const val =
      typeof value === 'string'
        ? value
        : value !== null && value !== undefined && typeof value.toString === 'function'
          ? value.toString()
          : JSON.stringify(value)

    // #47 Prevent using `hasOwnProperty` as a property name
    if (_hasOwnProperty(dict, name)) {
      dict[name].push(val)
    } else {
      dict[name] = [val]
    }
  }

  #encode(str) {
    return encodeURIComponent(str).replace(
      /[!'\(\)~]|%20|%00/g,
      (match) => UriEncodingMap[match],
    )
  }

  #decode(str) {
    return str
      .replace(/[ +]/g, '%20')
      .replace(/(%[a-f0-9]{2})+/gi, (match) => decodeURIComponent(match))
  }

  #parseToDict(search) {
    const dict = {}

    if (typeof search === 'object') {
      // if `search` is an array, treat it as a sequence
      if (Array.isArray(search)) {
        for (const item of search) {
          if (Array.isArray(item) && item.length === 2) {
            this.#appendTo(dict, item[0], item[1])
          } else {
            throw new TypeError(
              "Failed to construct 'UrlSearchParams': Sequence initializer must only contain pair elements",
            )
          }
        }
      } else {
        for (const key in search) {
          if (_hasOwnProperty(search, key)) {
            this.#appendTo(dict, key, search[key])
          }
        }
      }
    } else {
      const pairs = (search.indexOf('?') === 0 ? search.slice(1) : search)
        .replace(/&amp/, () => '%26')
        .split('&')

      for (let j = 0; j < pairs.length; j++) {
        const value = pairs[j]
        const index = value.indexOf('=')

        if (-1 < index) {
          this.#appendTo(
            dict,
            this.#decode(value.slice(0, index)),
            this.#decode(value.slice(index + 1)),
          )
        } else if (value) {
          this.#appendTo(dict, this.#decode(value), '')
        }
      }
    }

    return dict
  }
}

// JWT Decoding from https://github.com/auth0/jwt-decode
// Base64 decoding function base64decode is from https://github.com/dankogai/js-base64.
class InvalidCharacterError extends Error {
  constructor(message) {
    super(message)
    this.name = 'InvalidCharacterError'
  }
}

class InvalidTokenError extends Error {
  constructor(message) {
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

const base64Decode = (input) => {
  let asc = String(input).replace(/\s+/, '')

  if (!base64Re.test(asc)) {
    throw new InvalidCharacterError('base64decode failed: malformed base64.')
  }

  asc += '=='.slice(2 - (asc.length & 3))

  let u24
  let r1
  let r2
  let bin = ''

  for (let i = 0; i < asc.length; ) {
    r1 = b64tab[asc.charAt(i++)]
    r2 = b64tab[asc.charAt(i++)]

    u24 =
      (b64tab[asc.charAt(i++)] << 18) | (b64tab[asc.charAt(i++)] << 12) | (r1 << 6) | r2
    bin +=
      r1 === 64
        ? _fromCC((u24 >> 16) & 255)
        : r2 === 64
          ? _fromCC((u24 >> 16) & 255, (u24 >> 8) & 255)
          : _fromCC((u24 >> 16) & 255, (u24 >> 8) & 255, u24 & 255)
  }

  return bin
}

const base64DecodeURI = (str) =>
  decodeURIComponent(
    base64Decode(str).replace(/(.)/g, (_m, p) => {
      let code = p.charCodeAt(0).toString(16).toUpperCase()

      if (code.length < 2) {
        code = `0${code}`
      }

      return `%${code}`
    }),
  )

const base64_url_decode = (str) => {
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

const jwt_decode = (token, opts = {}) => {
  if (typeof token !== 'string') {
    throw new InvalidTokenError('Invalid token specified')
  }

  const options = opts || {}
  const pos = options.header === true ? 0 : 1

  try {
    return JSON.parse(base64_url_decode(token.split('.')[pos]))
  } catch (e) {
    throw new InvalidTokenError(`Invalid token specified: ${e.message}`)
  }
}

const TRACKING_EXCLUSIONS = {
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

const rejectKeyStartingWith = (key, { startsWith }) =>
  startsWith.some((pattern) => key.startsWith(pattern))
const rejectKeyEquals = (key, { equals }) => equals.some((pattern) => key === pattern)
const rejectKeyMatches = (key, { matches }) =>
  matches.some((pattern) => key.match(pattern))

const excludeKey = (key, exclusions) =>
  rejectKeyMatches(key, exclusions) ||
  rejectKeyStartingWith(key, exclusions) ||
  rejectKeyEquals(key, exclusions)

const rewriteRemoveTracking = ({ url }) => {
  const searchParams = new UrlSearchParams(url.search)

  for (const key of searchParams.keys()) {
    if (excludeKey(key, TRACKING_EXCLUSIONS)) {
      searchParams.delete(key)
    }
  }

  const search = searchParams.toString()

  return { ...url, search }
}

const getUrlParam = ({ search }, key) => new UrlSearchParams(search).get(key)

module.exports = {
  defaultBrowser: Browsers.Safari,
  options: {
    logRequests: true,
    // hideIcon: true,
  },
  rewrite: [
    {
      match: ({ opener, urlString }) =>
        opener.bundleId === 'com.tinyspeck.slackmacgap' ||
        /openid\/connect\/login_initiate_redirect/.test(urlString),
      url: ({ url }) => {
        const jwt = getUrlParam(url, 'login_hint')

        if (!jwt) {
          return url
        }

        try {
          const decoded = jwt_decode(jwt)
          const targetURI = decoded['https://slack.com/target_uri']
          return targetURI ?? url
        } catch (_error) {
          return url
        }
      },
    },
    {
      match: ({ url }) => url.host.endsWith('medium.com'),
      url: ({ url }) => ({ ...url, host: 'scribe.rip' }),
    },
    {
      match: /vk\.com\/away.php/,
      url: ({ url }) => {
        const param = getUrlParam(url, 'to')

        if (!param) {
          return url
        }

        return decodeURIComponent(decodeURIComponent(param))
      },
    },
    {
      match: /safelinks\.protection\.outlook\.com/,
      url: ({ url }) => {
        const match = getUrlParam(url, 'url')

        if (!match) {
          return url
        }

        return encodeURI(decodeURIComponent(match))
      },
    },
    {
      match: /id\.atlassian\.com\/login\/initiate\/slack\/external/,
      url: ({ url }) => {
        const param = getUrlParam(url, 'target_link_url')

        if (!param) {
          return url
        }

        return decodeURIComponent(param)
      },
    },
    {
      match: () => true,
      url: rewriteRemoveTracking,
    },
  ],
  handlers: [
    {
      match: () =>
        finicky.getKeys().option ||
        finicky.getKeys().command ||
        (finicky.getKeys().command && finicky.getKeys().option),
      browser: Browsers.Fallback,
    },
    isWork && {
      match: ({ url }) =>
        url.host.endsWith('github.com') && url.pathname.match(/\/northernlabs\//i),
      browser: Browsers.NorthernLabs,
    },
    isWork && {
      match: ({ url }) =>
        url.host.endsWith('github.com') && url.pathname.match(/\/fortelabsinc\//i),
      browser: Browsers.NorthernLabs,
    },
    isWork && {
      match: ({ url }) =>
        url.host === 'northernlabs.atlassian.net' ||
        url.host === 'northern-labs.slack.com',
      browser: Browsers.NorthernLabs,
    },
    isWork && {
      match: ({ url }) =>
        url.host === 'forteio.atlassian.net' || url.host === 'forte-io.slack.com',
      browser: Browsers.Forte,
    },
    isWork && {
      match: ({ url }) => url.host === 'identity.getpostman.com',
      browser: Browsers.NorthernLabs,
    },
    isWork && {
      match: ({ url }) => url.host === 'forte-io.postman.co',
      browser: Browsers.NorthernLabs,
    },
    isWork && {
      match: ({ url }) => url.host === 'newreleases.io',
      browser: Browsers.NorthernLabs,
    },
    isWork && {
      match: ({ url }) => url.host.match(/flux\.\w+-dev\.cloud/),
      browser: Browsers.NorthernLabs,
    },
    {
      match: ({ url }) => url.host === 'meet.google.com',
      browser: Browsers.NorthernLabs || Browsers.GoogleChrome,
    },
    {
      match: ({ url }) => url.host === 'script.google.com',
      browser: Browsers.GoogleChrome,
    },
    {
      match: ({ url }) => url.host === 'teams.microsoft.com',
      browser: Browsers.MicrosoftEdge,
    },
    {
      match: ({ url }) => url.host.endsWith('zoom.us'),
      browser: Browsers.Firefox,
    },
    {
      match: ['music.apple.com*', 'geo.music.apple.com*'],
      url: { protocol: 'itmss' },
      browser: Browsers.Music,
    },
    {
      match: ({ url }) =>
        url.host.endsWith('github.com') || url.host.endsWith('github.io'),
      browser: Browsers.Safari,
    },
    {
      match: ({ opener }) => !opener.path && !opener.name && !opener.bundleId,
      browser: Browsers.Fallback,
    },
  ].filter((e) => e),
}
