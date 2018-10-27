#!/usr/bin/jq -rf
.sysstat
  .hosts[0]
    .statistics[0]
      ."cpu-load" [1:]
  | (.[] |= 100 - .idle)
  | . += [. | add / length]
  | .[]
