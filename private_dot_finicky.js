// url-search-params-polyfill by Jerry Bendy (https://github.com/jerrybendy) - MIT license
// Adapted for Finicky as a _ponyfill_ even if Finicky later adds `URLSearchParams`.
const __URLSearchParams__ = '__URLSearchParams__'

// Construct a URLSearchParams instance from an object, string, or UrlSearchParams
function UrlSearchParams(search) {
  search = search || ''

  // support construct object with another URLSearchParams instance
  if (search instanceof UrlSearchParams) {
    search = search.toString()
  }

  this[__URLSearchParams__] = parseToDict(search)
}

// Appends a specified key/value pair as a new search parameter.
UrlSearchParams.prototype.append = function (name, value) {
  appendTo(this[__URLSearchParams__], name, value)
}

// Deletes the given search parameter, and its associated value, from the list of all search parameters.
UrlSearchParams.prototype['delete'] = function (name) {
  delete this[__URLSearchParams__][name]
}

// Returns the first value associated to the given search parameter.
UrlSearchParams.prototype.get = function (name) {
  const dict = this[__URLSearchParams__]
  return this.has(name) ? dict[name][0] : null
}

// Returns all the values association with a given search parameter.
UrlSearchParams.prototype.getAll = function (name) {
  const dict = this[__URLSearchParams__]
  return this.has(name) ? dict[name].slice(0) : []
}

// Returns a Boolean indicating if such a search parameter exists.
UrlSearchParams.prototype.has = function (name) {
  return hasOwnProperty(this[__URLSearchParams__], name)
}

// Sets the value associated to a given search parameter to the given value. If there were several values, delete the
// others.
UrlSearchParams.prototype.set = function set(name, value) {
  this[__URLSearchParams__][name] = ['' + value]
}

// Returns a string containing a query string suitable for use in a URL.
UrlSearchParams.prototype.toString = function () {
  const dict = this[__URLSearchParams__]
  const query = []
  for (const key in dict) {
    let name = encode(key)
    for (let i = 0, value = dict[key]; i < value.length; i++) {
      if (value[i]) {
        query.push(name + '=' + encode(value[i]))
      } else {
        query.push(name)
      }
    }
  }
  return query.join('&')
}

// Implement forEach
UrlSearchParams.prototype.forEach = function (callback, thisArg) {
  const dict = parseToDict(this.toString())
  Object.getOwnPropertyNames(dict).forEach(function (name) {
    dict[name].forEach(function (value) {
      callback.call(thisArg, value, name, this)
    }, this)
  }, this)
}

// Sort all name-value pairs
UrlSearchParams.prototype.sort = function () {
  const dict = parseToDict(this.toString())
  const keys = []
  for (const k in dict) {
    keys.push(k)
  }
  keys.sort()

  for (let i = 0; i < keys.length; i++) {
    this['delete'](keys[i])
  }
  for (let i = 0; i < keys.length; i++) {
    const key = keys[i]
    const values = dict[key]
    for (let j = 0; j < values.length; j++) {
      this.append(key, values[j])
    }
  }
}

// Returns an iterator allowing to go through all keys of the key/value pairs contained in this object.
UrlSearchParams.prototype.keys = function () {
  const items = []
  this.forEach((_item, name) => items.push(name))
  return makeIterator(items)
}

// Returns an iterator allowing to go through all values of the key/value pairs contained in this object.
UrlSearchParams.prototype.values = function () {
  const items = []
  this.forEach((item) => items.push(item))
  return makeIterator(items)
}

// Returns an iterator allowing to go through all key/value pairs contained in this object.
UrlSearchParams.prototype.entries = function () {
  const items = []
  this.forEach((item, name) => items.push([name, item]))
  return makeIterator(items)
}

const iterable = typeof Symbol !== 'undefined' && typeof Symbol.iterator !== 'undefined'

if (iterable) {
  UrlSearchParams[Symbol.iterator] = UrlSearchParams[Symbol.iterator] || UrlSearchParams.entries
}

const UriEncodingMap = {
  '!': '%21',
  "'": '%27',
  '(': '%28',
  ')': '%29',
  '~': '%7E',
  '%20': '+',
  '%00': '\x00',
}

function encode(str) {
  return encodeURIComponent(str).replace(/[!'\(\)~]|%20|%00/g, (match) => UriEncodingMap[match])
}

function decode(str) {
  return str.replace(/[ +]/g, '%20').replace(/(%[a-f0-9]{2})+/gi, (match) => decodeURIComponent(match))
}

function makeIterator(arr) {
  const iterator = {
    next: () => {
      const value = arr.shift()
      return { done: value === undefined, value: value }
    },
  }

  if (iterable) {
    iterator[Symbol.iterator] = () => iterator
  }

  return iterator
}

function parseToDict(search) {
  const dict = {}

  if (typeof search === 'object') {
    // if `search` is an array, treat it as a sequence
    if (isArray(search)) {
      for (let i = 0; i < search.length; i++) {
        const item = search[i]
        if (isArray(item) && item.length === 2) {
          appendTo(dict, item[0], item[1])
        } else {
          throw new TypeError(
            "Failed to construct 'UrlSearchParams': Sequence initializer must only contain pair elements"
          )
        }
      }
    } else {
      for (const key in search) {
        if (hasOwnProperty(search, key)) {
          appendTo(dict, key, search[key])
        }
      }
    }
  } else {
    // remove first '?'
    if (search.indexOf('?') === 0) {
      search = search.slice(1)
    }

    const pairs = search.replace(/&amp;/, () => '%26').split('&')
    for (let j = 0; j < pairs.length; j++) {
      const value = pairs[j]
      const index = value.indexOf('=')

      if (-1 < index) {
        appendTo(dict, decode(value.slice(0, index)), decode(value.slice(index + 1)))
      } else if (value) {
        appendTo(dict, decode(value), '')
      }
    }
  }

  return dict
}

function appendTo(dict, name, value) {
  const val =
    typeof value === 'string'
      ? value
      : value !== null && value !== undefined && typeof value.toString === 'function'
      ? value.toString()
      : JSON.stringify(value)

  // #47 Prevent using `hasOwnProperty` as a property name
  if (hasOwnProperty(dict, name)) {
    dict[name].push(val)
  } else {
    dict[name] = [val]
  }
}

function isArray(val) {
  return !!val && '[object Array]' === Object.prototype.toString.call(val)
}

function hasOwnProperty(obj, prop) {
  return Object.prototype.hasOwnProperty.call(obj, prop)
}

// JWT Decoding from https://github.com/auth0/jwt-decode
// Base64 decoding function atob is from https://github.com/davidchambers/Base64.js
const base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='

function InvalidCharacterError(message) {
  this.message = message
}
InvalidCharacterError.prototype = new Error()
InvalidCharacterError.prototype.name = 'InvalidCharacterError'

function InvalidTokenError(message) {
  this.message = message
}

InvalidTokenError.prototype = new Error()
InvalidTokenError.prototype.name = 'InvalidTokenError'

const atob = (input) => {
  const str = String(input).replace(/=+$/, '')

  if (str.length % 4 == 1) {
    throw new InvalidCharacterError(`'atob' failed: The string to be decoded is not correctly encoded.`)
  }

  // initialize result and counters
  let bc = 0
  let bs
  let buffer
  let idx = 0
  let output = ''

  for (
    ;
    // get next character
    (buffer = str.charAt(idx++));
    // character found in table? initialize bit storage and add its ascii value;
    ~buffer &&
    ((bs = bc % 4 ? bs * 64 + buffer : buffer),
    // and if not first of each 4 characters, convert the first 8 bits to one ascii character
    bc++ % 4)
      ? (output += String.fromCharCode(255 & (bs >> ((-2 * bc) & 6))))
      : 0
  ) {
    // try to find character in table (0-63, not found => -1)
    buffer = base64Chars.indexOf(buffer)
  }

  return output
}

const b64DecodeUnicode = (str) =>
  decodeURIComponent(
    atob(str).replace(/(.)/g, (_m, p) => {
      let code = p.charCodeAt(0).toString(16).toUpperCase()

      if (code.length < 2) {
        code = '0' + code
      }
      return '%' + code
    })
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
    return b64DecodeUnicode(output)
  } catch (_err) {
    return atob(output)
  }
}

const jwt_decode = (token, options) => {
  if (typeof token !== 'string') {
    throw new InvalidTokenError('Invalid token specified')
  }

  options = options || {}

  const pos = options.header === true ? 0 : 1

  try {
    return JSON.parse(base64_url_decode(token.split('.')[pos]))
  } catch (e) {
    throw new InvalidTokenError('Invalid token specified: ' + e.message)
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

const NITTER_HOSTS = ['twiiit.com', 'twitit.gq']

const nitterHost = () => NITTER_HOSTS[Math.floor(Math.random() * NITTER_HOSTS.length)]

const rejectKeyStartingWith = (key, { startsWith }) => startsWith.some((pattern) => key.startsWith(pattern))
const rejectKeyEquals = (key, { equals }) => equals.some((pattern) => key === pattern)
const rejectKeyMatches = (key, { matches }) => matches.some((pattern) => key.match(pattern))

const excludeKey = (key, exclusions) =>
  rejectKeyMatches(key, exclusions) || rejectKeyStartingWith(key, exclusions) || rejectKeyEquals(key, exclusions)

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
  defaultBrowser: 'Safari',
  options: {
    logRequests: true,
    // hideIcon: true,
  },
  rewrite: [
    {
      match: ({ opener, urlString }) =>
        opener.bundleId === 'com.tinyspeck.slacmacgap' || /openid\/connect\/login_initiate_redirect/.test(urlString),
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
      match: ({ url }) => url.host === 'twitter.com',
      url: ({ url }) => ({ ...url, host: nitterHost() }),
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
      match: ({ url }) => url.host.endsWith('bitbucket.org') && url.pathname.startsWith('/ascendis-ca/'),
      browser: 'Microsoft Edge',
    },
    {
      match: () => finicky.getKeys().option,
      browser: '/Applications/Setapp/OpenIn.app',
    },
    {
      match: (match) => {
        return finicky.matchHostnames(['ascendis.atlassian.net'])(match)
      },
      browser: 'Microsoft Edge',
    },
    {
      match: (match) => {
        return (
          finicky.getKeys().command &&
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
      match: ({ url }) => url.host.endsWith('zoom.us'),
      browser: 'Firefox',
    },
    {
      match: ['music.apple.com*', 'geo.music.apple.com*'],
      url: { protocol: 'itmss' },
      browser: 'Music',
    },
  ],
}
