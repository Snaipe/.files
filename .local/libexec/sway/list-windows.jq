#!/usr/bin/jq -rf
..
  | objects
  | select(.type == "workspace" and .nodes != null)
  | .name as $name
  | .nodes
  | .. | objects
  | select(.type == "con")
  | [
      $name,
      .app_id // .window_properties.class // "",
      if .name != "" then
        " -- \(.name)"
      else
        ""
      end
    ]
  | "[\(.[0])] \(.[1])\(.[2])"
