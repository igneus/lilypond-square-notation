\version "2.24.1"

\include "gregorian.ly"
\include "stylesheet.ily"

\header {
  title = "State of square notation in LilyPond"
}

\bookpart {
  \header { subtitle = "Introduction" }

  \markup\justify{
    This document describes the state of square notation support
    as of LilyPond 2.24.
    It serves a double purpose:
    first to assist anyone considering LilyPond for an engraving project
    which involves square notation;
    second to set direction and priorities of possible future work on
    improving square notation support in LilyPond.
  }
}

\bookpart {
  \header { subtitle = "Safe area" }

  \markup\column{
    \line{LilyPond more or less safely renders square notation pieces which}
    \line{- have lyrics}
    \line{- contain no accidentals, articulations, rhythmic signs or puncta inclinata}
  }
  \markup\justify{
    Examples of such chants are some very simple antiphons and hymns,
    as well as selected genres, e.g. prefaces.
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      e f g f \[ d\melisma \pes f\melismaEnd \] f \divisioMinima
      f f \[ e\melisma \pes f\melismaEnd \] d f \[ f\melisma \pes g\melismaEnd \] e e \finalis
      a g a \[ b\melisma \flexa a\melismaEnd \] \[ g\melisma \flexa f\melismaEnd \] e \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      Ju -- bi -- lá -- te De -- o
      om -- nis ter -- ra, al -- le -- lú -- ia.
      E u o u a e.
    }
    >>
    \header {
      piece = "AR1912, p. 2"
    }
  }


  \markup\justify{
    Scores not matching these requirements may still be rendered correctly,
    but each of the listed properties increases chances of running into
    some sort of glitch.
  }

  % TODO example of a piece rendering correctly even with the risky features
}

\bookpart {
  \header {
    subtitle = "Potential selling points (compared to Gregorio)"
  }

  \markup\justify{
    LilyPond square notation is (by far) no match for Gregorio in terms of
    output quality and has some very serious problems (see the chapters
    further below), but it also offers some unique features.
  }

  \markup\justify{
    \bold{Unlimited lines of lyrics aligned to a staff}
    -- think of hymn stanzas, parallel lines of a sequence,
    litany invocations, psalm verses, ...
    or antiphon texts sung to the same melodic formula:
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      d c d f \[ f\melisma \pes g\melismaEnd \] g \divisioMaior
      a g a a g f e d \divisioMinima f \[ g\melisma \pes a\melismaEnd \] g g \finalis

      g g g d f \[ e \flexa d \] \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      Mar -- tý -- res Dó -- mi -- ni,
      Dó -- mi -- num be -- ne -- dí -- ci -- te in ae -- tér -- num.

      E u o u a e.
    }
    \new VaticanaLyrics \lyricsto "v" {
      _ San -- cti Dó -- mi -- ni, "..."
    }
    \new VaticanaLyrics \lyricsto "v" {
      Vír -- gi -- nes Dó -- mi -- ni, "..."
    }
    \new VaticanaLyrics \lyricsto "v" {
      An -- ge -- li Dó -- mi -- ni, "..."
    }
    >>
    \header {
      piece = ""
    }
  }

  \markup\bold{Multiple aligned staffs:}

  \score {
    <<
      \new VaticanaVoice = "voice-a" {
        \clef "vaticana-do3"
        % in square notation durations don't affect the note appearance,
        % but are useful when aligning voices
        d' c' \[ a8\melisma \flexa g\melismaEnd \] f4 g f g a \divisioMaxima
        a c' d' c' \[ a8\melisma \flexa g\melismaEnd \] \[ f\melisma \flexa e\melismaEnd \] f4 d \divisioMaxima
        d f d e f g \[ f8\melisma \flexa e\melismaEnd \] d4 \divisioMaxima
        d f \[ a\melisma \pes b\melismaEnd \] c' d' \[ c'\melisma \pes b\melismaEnd \] c' d' \finalis
      }
      \new VaticanaLyrics \lyricsto "voice-a" { \repeat unfold 16 { A -- men } }
      \new VaticanaVoice {
        \clef "vaticana-do3"
        d c d f g \[ f8\melisma \flexa e\melismaEnd \] f4 d \divisioMaxima
        b, d b, d b, d e f \divisioMaxima
        a c' a b c' d' c' d' \divisioMaxima
        d' c' \[ a\melisma \flexa g\melismaEnd \] f g \[ f\melisma \flexa e\melismaEnd \] f d \finalis
      }
    >>
    \header {
      piece = \markup\with-url
        "https://new.manuscriptorium.com/apis/resolver-api/cs/browser/default/detail?url=https://collectiones.manuscriptorium.com/assorted/AIPDIG/NKCR__/7/AIPDIG-NKCR__XIV_G_46____2SSE2F7-cs/&imageId=https://imagines.manuscriptorium.com/loris/AIPDIG-NKCR__XIV_G_46____2SSE2F7-cs/ID0102r"
        "CZ-Pu XIV G 46, f. 102r"
    }
    \layout {
      \override VaticanaStaff.Clef.extra-offset = #'(0.3 . 0)
    }
  }

  \markup\justify{
    \bold{Virtually unlimited in-staff polyphony}
  }

  % polyphony entered as separate voices
  \score {
    <<
      \new VaticanaStaff <<
        \new VaticanaVoice = "v" {
          \clef "vaticana-do3"
          c' d' c'
        }
        \new VaticanaVoice {
          % TODO fix LilyPond warnings
          a a a
        }
        \new VaticanaVoice {
          f \[ f8 \flexa e \] d4
        }
        \new VaticanaVoice {
          c b, a,
        }
      >>
      \new VaticanaLyrics \lyricsto "v" {
        La la la
      }
    >>
  }

  % polyphony entered as chords
  \score {
    <<
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        g
        <f a>
        <e g b>
        <d f a c'>
        <c e g b d'>
      }
      \new VaticanaLyrics \lyricsto "v" {
        La la la la la
      }
    >>
  }

  \markup\justify{
    \bold{Virtually unlimited range} (in Gregorio the maximum range without changing
    clef is 13 steps in the standard four line staff, 15 steps in a five line one;
    LilyPond doesn't limit the number of ledger lines)
  }

  \score {
    <<
      \new VaticanaStaff <<
        \new VaticanaVoice = "v" {
          \clef "vaticana-do3"
          g b d' f' a' c'' e'' g''
          e'' c'' a' f' d' b g g g
        }
        \new VaticanaVoice {
          g e c a, f, d, b,, g,,
          b,, d, f, a, c e
        }
      >>
      \new VaticanaLyrics \lyricsto "v" {
        La \repeat unfold 16 { la }
      }
    >>
  }

  \markup\bold{Various kinds of annotations:}

  \score {
    <<
    \new VaticanaVoice = "v" \with {
      \consists Balloon_engraver
      \consists Horizontal_bracket_engraver
    } {
      \clef "vaticana-do3"
      e^"fi" % markup attached to a note
      f g-3 % fingering doesn't make much sense in chant, but it's available
      f \[ d\melisma \pes f\melismaEnd \]
      \once\override HorizontalBracketText.text = "reciting on fa" % horizontal bracket with a label
      f\startGroup \divisioMinima
      \mark "B" % rehearsal mark
      f f\stopGroup \[ e\melisma \pes f\melismaEnd \] d f \[ f\melisma \pes g\melismaEnd \] e \balloonGrobText #'NoteHead #'(2 . 4) \markup { "back on the final" } e \finalis

      \override NoteHead.color = #red % coloured objects
      \staffHighlight "gold"

      a g a \[ b\melisma \flexa a\melismaEnd \] \[ g\melisma \flexa f\melismaEnd \] e \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      Ju -- bi -- lá -- te De -- o
      om -- nis ter -- ra, al -- le -- lú -- ia.

      \override Lyrics.LyricText.color = #red

      E u o u a e.
    }
    >>
    \header {
      piece = "AR1912, p. 2"
    }
  }

  \markup\bold{Different notation styles in a single system:}

  \score {
    <<
      \new VaticanaVoice = "voice-a" {
        \clef "vaticana-do3"
        % in square notation durations don't affect the note appearance,
        % but are useful when aligning voices
        d' c' \[ a8\melisma \flexa g\melismaEnd \] f4 g f g a \divisioMaxima
        a c' d' c' \[ a8\melisma \flexa g\melismaEnd \] \[ f\melisma \flexa e\melismaEnd \] f4 d \divisioMaxima
        d f d e f g \[ f8\melisma \flexa e\melismaEnd \] d4 \divisioMaxima
        d f \[ a8\melisma \pes b\melismaEnd \] c'4 d' \[ c'8\melisma \pes b\melismaEnd \] c'4 d' \finalis
      }
      \new VaticanaLyrics \lyricsto "voice-a" { \repeat unfold 16 { A -- men } }
      \new Voice \with { \magnifyStaff #4/5 } \transpose c c' {
        \cadenzaOn
        \override TimeSignature.stencil = #f
        d c d f g f8( e) f4 d \bar "|"
        b, d b, d b, d e f \bar "|"
        a c' a b c' d' c' d' \bar "|"
        d' c' a8( g) f4 g f8( e) f4 d \bar "||"
      }
    >>
    \header {
      piece = \markup\with-url
        "https://new.manuscriptorium.com/apis/resolver-api/cs/browser/default/detail?url=https://collectiones.manuscriptorium.com/assorted/AIPDIG/NKCR__/7/AIPDIG-NKCR__XIV_G_46____2SSE2F7-cs/&imageId=https://imagines.manuscriptorium.com/loris/AIPDIG-NKCR__XIV_G_46____2SSE2F7-cs/ID0102r"
        "CZ-Pu XIV G 46, f. 102r"
    }
    \layout {
      \override VaticanaStaff.Clef.extra-offset = #'(0.3 . 0)
    }
  }

  \markup\column{
    \line{}
    \line{}
  }
}

\bookpart {
  \header { subtitle = "Missing notation features" }

  \markup\justify{
    \bold{Initials.}
    To same extent they can be faked using LilyPond's instrument name facility,
    but correct positioning requires detailed attention to each particular instance:
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \set VaticanaStaff.instrumentName =
        \markup\center-column{
          \tiny{per.}
          \huge\larger\larger\larger\larger\larger\larger\larger\larger{M} % TODO better font sizing solution
        }

      \clef "vaticana-do3"
      d c d f \[ f\melisma \pes g\melismaEnd \] g \divisioMaior
      a g a a g f e d \divisioMinima f \[ g\melisma \pes a\melismaEnd \] g g \finalis

      g g g d f \[ e \flexa d \] \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      ar -- tý -- res Dó -- mi -- ni,
      Dó -- mi -- num be -- ne -- dí -- ci -- te in ae -- tér -- num.

      E u o u a e.
    }
    >>
    \header {
      piece = ""
    }
    \layout {
      indent = 1\in % make space for the initial
    }
  }

  \markup\justify{
    \bold{Missing clefs.}
    The chant clefs predefined in LilyPond
    don't include the C clef on the bottom-most staff line
    and the F clef on the bottom- and upper-most line.
    But custom clefs can be defined easily, making this just a slight inconvenience.
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      g
      \clef "vaticana-do2"
      g
      \clef "vaticana-do1"
      g
      \finalis
      \clef "vaticana-fa2"
      g
      \clef "vaticana-fa1"
      g
      \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      \repeat unfold 5 { sol }
    }
    >>
  }

  \markup\justify{
    \bold{Explicit positioning of the b flat.}
    It is standard practice in square notation to place a b flat
    earlier than the first affected b appears,
    in order to optimize appearance and readability.
    LilyPond doesn't support manual positioning of the b flat.
    It can be faked using an invisible note.
  }

  % TODO real-life example
}

\bookpart {
  \header { subtitle = "Severe horizontal spacing issues" }

  \markup{Spacing heavily broken without lyrics}
  % TODO

  \markup{Unnatural alignment of lyrics under a pes}
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ e\melisma \pes f\melismaEnd \] d
    }
    \new VaticanaLyrics \lyricsto "v" { ter -- ra }
    >>
  }

  \markup{Neumes collide/confound}

  % neume "sliding under" the previous one
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ d\melisma \pes g \flexa f f\melismaEnd \] \[ e\melisma \flexa d\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { rí -- a. }
    >>
  }

  % the same neumes come out slightly different without lyrics
  \score {
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ d\melisma \pes g \flexa f f\melismaEnd \] \[ e\melisma \flexa d\melismaEnd \]
    }
  }

  % the final f of the first neume and initial f of the second one are rendered over each other / merged
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ d\melisma \pes g \flexa f f\melismaEnd \] \[ f\melisma \flexa d\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { rí -- a. }
    >>
  }

  % neume "sliding over" the previous one
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ d\melisma \pes g \flexa f f\melismaEnd \] \[ g\melisma \flexa a\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { rí -- a. }
    >>
  }

  % neume without lyrics merges with the following one
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ d\melisma \pes e f \flexa g\melismaEnd \] \[ g\melisma \flexa \deminutum f\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { _ dul }
    >>
  }

  \markup{Puncta inclinata make neumes run under/over divisiones}

  % neume under a divisio minima
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ \virga f\melisma \inclinatum e \inclinatum d \inclinatum c\ictus d\melismaEnd \]
      \divisioMinima
      \[ d\melisma \pes e\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { O o }
    >>
  }

  % neume crossing a divisio maxima
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ \virga f\melisma \inclinatum e \inclinatum d \inclinatum c\ictus d\melismaEnd \]
      \divisioMaxima
      \[ d\melisma \pes e\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { O o }
    >>
  }

  % neume crossing a divisio maxima
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ \virga f\melisma \inclinatum e \inclinatum d
         \virga f \inclinatum e \inclinatum d\melismaEnd \]
      \divisioMaxima
      \[ d\melisma \pes e\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { O o }
    >>
  }

}

\bookpart {
  \header { subtitle = "Other glitches" }

  \markup\column{
    \line{}
    \line{}
  }
}
