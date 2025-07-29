(script_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)) @container

(template_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)
  ) @container

(style_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)) @container

(interpolation
  "{{" @delimiter
  "}}" @delimiter @sentinel) @container

; div
(element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter @tag_name (#match? @tag_name "^div$")
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter @tag_name (#match? @tag_name "^div$")
    ">" @delimiter @sentinel)  
) @container
