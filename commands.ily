\version "2.24.1"

#(define-markup-command (text-link layout props url text) (string? markup?)
   "highlighted link"
   (interpret-markup layout props
     #{ \markup\with-url #url { \underline\with-color #blue #text } #} ))

#(define-markup-command (url-link layout props url) (string?)
   "clickable URL"
   (interpret-markup layout props
     #{ \markup\text-link #url { #url } #} ))

#(define-markup-command (lilypond-issue layout props issue-num) (integer?)
   "link to an issue in LilyPond issue tracker"
   (interpret-markup layout props
     #{ \markup\text-link #(string-append "https://gitlab.com/lilypond/lilypond/-/issues/" (number->string issue-num)) {
       #(string-append "lilypond#" (number->string issue-num))
     } #} ))

#(define-markup-command (gregorio-issue layout props issue-num) (integer?)
   "link to an issue in Gregorio issue tracker"
   (interpret-markup layout props
     #{ \markup\text-link #(string-append "https://github.com/gregorio-project/gregorio/issues/" (number->string issue-num)) {
       #(string-append "gregorio#" (number->string issue-num))
     } #} ))
