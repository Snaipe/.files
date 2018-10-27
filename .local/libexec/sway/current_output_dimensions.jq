#!/usr/bin/jq -rf
..
  | objects
  | select(.type == "output")
  | select(..
    | objects
    | select(.focused == true))
  | .rect
  | "\(.width)x\(.height)"
