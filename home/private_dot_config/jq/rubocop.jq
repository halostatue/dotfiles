def failed_files:
  .files | map(select(.offenses != []) | .path) | .[]
  ;
