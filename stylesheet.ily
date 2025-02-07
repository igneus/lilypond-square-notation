\version "2.24.1"

% The copied function below needs function make-font-tree-node,
% defined in scm/font.scm as not exported.
% Forcing access to a private function via @@ is very dirty,
% but of all dirty options available it seems to be the most reasonable one.
#(define make-font-tree-node (@@ (lily) make-font-tree-node))

% The standard set-global-fonts function
% (code copied from scm/font.scm of LilyPond 2.24)
% modified so as to allow setting separate factors for text and music font
%
% FUTURE 2.25: set-global-fonts is dropped altogether in LilyPond 2.25!
#(define*
  (set-global-fonts-2factor
   #:key
   (music "emmentaler")
   (brace "emmentaler")
   (roman (if (eq? (ly:get-option 'backend) 'svg)
              "serif" "LilyPond Serif"))
   (sans (if (eq? (ly:get-option 'backend) 'svg)
             "sans-serif" "LilyPond Sans Serif"))
   (typewriter (if (eq? (ly:get-option 'backend) 'svg)
                   "monospace" "LilyPond Monospace"))
   (text-factor 1)
   (music-factor 1))
  (let ((n (make-font-tree-node 'font-encoding 'fetaMusic)))
    (add-music-fonts n 'feta music brace feta-design-size-mapping music-factor)
    (add-pango-fonts n 'roman roman text-factor)
    (add-pango-fonts n 'sans sans text-factor)
    (add-pango-fonts n 'typewriter typewriter text-factor)
    n))

% --------------------------------------------------------

#(set-global-staff-size 30)

\paper {
  #(define fonts
     (set-global-fonts-2factor
      #:roman "Junicode"
      ;; Why different font size factors:
      ;; The standard `set-global-fonts` function uses the same size factor
      ;; for the music font and the text font and for modern notation it works just fine.
      ;; But for square notation (which has very different relation between
      ;; the staff space and text font size)
      ;; it means either tiny notes or huge base text font size.
      ;; gregorian.ly addresses this by downsizing LyricText.font-size
      ;; relative to the staff space,
      ;; but default font size for markup text stays huge, which is unfortunate
      ;; for a markup-heavy document like we have here.
      ;; So we instead configure the size factor for music and text fonts separately.
      #:music-factor (/ staff-height pt 21)
      #:text-factor (/ staff-height pt 26)))

  markup-markup-spacing.basic-distance = #4
}

\layout {
  \override VaticanaLyrics.LyricText.font-size = #0
}
