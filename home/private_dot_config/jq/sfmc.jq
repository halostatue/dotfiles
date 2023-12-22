# The  functions are used to clean Exact Target (SFMC) contact data.
def clean_key_name:
  .name | gsub("[- ]"; "_") | ascii_downcase
  ;

def clean_value:
  if (.name | type) == "Contact ID" then (.value | tostring)
  elif .value == "blank" then null
  else .value end
  ;

def clean_kv:
  {key: clean_key_name, value: clean_value}
  ;

def filter_null:
  reduce .[] as $item (
    [] ;
    if ($item.value | length) == 0 then . else . +  [$item] end
  )
  ;

def hoist:
  map(.values | map(clean_kv) | filter_null | from_entries)
  ;

def document:
  map({type: "add", id: .contact_id, fields: .})
  ;

