\version "2.24.1"

#(set-global-staff-size 30)

\paper {
  #(define fonts
     (set-global-fonts
      #:roman "Junicode"
      #:factor (/ staff-height pt 21)))

  markup-markup-spacing.basic-distance = #4
}

\layout {
  \override VaticanaLyrics.LyricText.font-size = #-2
}
