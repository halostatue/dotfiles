import "aldo" as aldo ;
import "bag" as bag ;
import "combine" as combine ;
import "insomnia" as insomnia ;
import "rubocop" as rubocop ;
import "sfmc" as sfmc ;
import "string" as string ;
import "transform" as transform ;

# Given an array of values as input, generate a stream of values of the
# maximal elements as determined by f.
# Notes:
# 1. If the input is [] then the output stream is empty.
# 2. If f evaluates to null for all the input elements,
#    then the output stream will be the stream of all the input items.
def maximal_by(f):
  (map(f) | max) as $mx |
  .[] | select(f == $mx)
  ;

# Emit a stream of the f-maximal elements of the given stream on the assumption
# that `[stream]==[stream]`
def maximals_by_(stream ; f):
  (
   reduce stream as $x (
     null ;
     ($x | f) as $y | if . == null or . < $y then $y else . end
    )
  ) as $mx
  | stream
  | select(f == $mx)
  ;

# Emit a stream of the f-maximal elements of the stream, s:
def maximals_by(s ; f):
  reduce s as $x (
    [] ;
    ($x | f) as $y
    | if length == 0 then [$x]
      else (.[0] | f) as $v |
        if $y == $v then . + [$x] elif $y > $v then [$x] else . end
      end
  )
  | .[]
  ;

def maybe_add_as(current ; new):
  if current then . + {(new): current} else . end
  ;

def delete_matching(key; list):
  .[key] as $value |
  if list | any($value == .) then del(.[key]) else . end
  ;
