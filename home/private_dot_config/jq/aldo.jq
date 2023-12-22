module {
} ;

# These aldo-specific functions exist only to show how it is possible to use jq
# to produce SQL statements from JSON data.
def store_sql:
  . as $in
  | "UPDATE stores SET " + (
    reduce ($in.good | keys)[] as $key (
      [] ;
      . + [$key + " = '" + $in.good[$key] + "'"]
    ) | join(", ")
  ) + " WHERE id = " + ($in.store | tostring) + ";"
  ;

def store_values:
  . as $in |
  reduce keys[] as $key (
    [] ;
    . + [$in[$key]]
  )
  ;

def stores_sql:
  store_values | map(. | store_sql) | join("\n")
  ;
