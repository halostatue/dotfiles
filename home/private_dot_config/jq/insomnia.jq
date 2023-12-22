# Clean insomnia data
def clean_key_names:
  . as $in
  | if type == "object" then
      reduce keys_unsorted[] as $key (
        {} ;
        . + { ($key | gsub("[^a-z0-9A-Z_]" ; "_")): ($in[$key] | insomnia_clean_key_names) }
      )
    elif type == "array" then
      map(insomnia_clean_key_names)
    else
      .
    end
  ;


