module {
} ;

def empty_leaves: select(tostring | . == "{}" or . == "[]")
  ;

def flatten(join_char):
  . as $data |
  [ path(.. | select(scalars | tostring), select(empty_leaves)) ] |
  map({ (map(tostring) | join(join_char)) : (. as $path | . = $data | getpath($path)) }) |
  reduce .[] as $item (
    {} ;
    . + $item
  )
  ;

def flatten:
  flatten(".")
  ;

def unflatten(join_char):
  reduce to_entries[] as $element
    (
      null ;
      setpath($element.key / join_char | map(tonumber? // .) ; $element.value)
    )
  ;

def unflatten:
  unflatten_json(".")
  ;
