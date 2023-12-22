# bag(stream) uses a two-level dictionary: .[type][tostring]
# So given a bag, $b, to recover a count for an entity, $e, use
# $e | $b[type][tostring]
def bag(stream):
  reduce stream as $x (
      {} ;
      .[$x | type][$x | tostring] += 1
  )
  ;

def bag:
  bag(.[])
  ;

def bag_to_entries:
  [
    to_entries[]
    | .key as $type
    | .value
    | to_entries[]
    | { key: (if $type == "string" then .key else .key | fromjson end), value }
  ]
  ;

# Produce a stream of the distinct elements in the given stream
def uniques(stream):
  bag(stream)
  | to_entries[]
  | .key as $type
  | .value
  | to_entries[]
  | if $type == "string" then .key else .key | fromjson end
  ;

# Emit an array of [value, frequency] pairs, sorted by value
def histogram(stream):
  bag(stream)
  | bag_to_entries
  | sort_by( .key )
  | map( [.key, .value] )
  ;
