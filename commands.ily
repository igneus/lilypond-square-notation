\version "2.24.1"

#(define-markup-command (text-link layout props url text) (string? markup?)
   "highlighted link"
   (interpret-markup layout props
     #{ \markup\with-url #url { \underline\with-color #blue #text } #} ))

#(define-markup-command (url-link layout props url) (string?)
   "clickable URL"
   (interpret-markup layout props
     #{ \markup\text-link #url { #url } #} ))
