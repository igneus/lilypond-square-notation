\version "2.24.1"

\include "gregorian.ly"
\include "stylesheet.ily"

\header {
  title = "State of square notation in LilyPond"
}

\bookpart {
  \markup\justify{
    This document describes the state of square notation support
    as of LilyPond 2.24.
    It serves a double purpose:
    first to assist anyone considering LilyPond for an engraving project
    which involves square notation;
    second to set direction and priorities of possible future work on
    improving the square notation support.
  }
}

\bookpart {
  \header { subtitle = "Safe area" }

  \markup\column{
    \line{LilyPond more or less safely renders square notation pieces which}
    \line{- have lyrics}
    \line{- contain no accidentals, articulations, rhythmic signs or puncta inclinata}
    \line{- have no melismata longer than two or three notes}
  }

  \markup\vspace #1

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

  \markup\vspace #1

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

  \markup\vspace #1

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

  \markup\vspace #1

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
          \voiceTwo
          a a a
        }
        \new VaticanaVoice {
          \voiceThree
          f \[ f8 \flexa e \] d4
        }
        \new VaticanaVoice {
          \voiceFour
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

  \markup\vspace #1

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
          s e c a, f, d, b,, g,,
          b,, d, f, a, c e
        }
      >>
      \new VaticanaLyrics \lyricsto "v" {
        La \repeat unfold 16 { la }
      }
    >>
  }

  \markup\vspace #1

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

  \markup\vspace #1

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
        d c d f g f8( e) f4 d \bar "|"
        b, d b, d b, d e f \bar "|"
        a c' a b c' d' c' d' \bar "|"
        d' c' a8( g) f4 g f8( e) f4 d \bar "||"
      }
    >>
    \layout {
      \override VaticanaStaff.Clef.extra-offset = #'(0.3 . 0)
      \override Staff.TimeSignature.stencil = ##f
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
    They can be faked using LilyPond's instrument name facility,
    but correct positioning requires manual adjustment of each instance:
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \set VaticanaStaff.instrumentName =
        \markup\center-column{
          \small{per.}
          \vspace #0.2
          \override #'(font-size . 14) M
        }

      \clef "vaticana-do3"
      d c d f \[ f\melisma \pes g\melismaEnd \] g \divisioMaior
      a g a a g f e d \divisioMinima f \[ g\melisma \pes a\melismaEnd \] g g \finalis

      g g g d f \[ e \flexa d \] \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      \override LyricText.font-features = #'("smcp") % small caps
      ar -- ty -- res
      \revert LyricText.font-features

      Dó -- mi -- ni,
      Dó -- mi -- num be -- ne -- dí -- ci -- te in ae -- tér -- num.

      E u o u a e.
    }
    >>
    \header {
      piece = ""
    }
    \layout {
      indent = 1\in % make space for the initial

      % manually align the initial with lyrics baseline
      \override VaticanaStaff.InstrumentName.extra-offset = #'(0 . -1.9)
    }
  }

  \markup\justify{
    \bold{Missing clefs.}
    The set of chant clefs predefined in LilyPond
    doesn't include the C clef on the bottom-most staff line
    and the F clef on the bottom- and upper-most line.
    But it's true that modern chant editions rarely use these
    and custom clefs can be defined easily
    (example on the right), making this just a slight inconvenience.
  }

  #(add-new-clef "custom-vaticana-do0" "clefs.vaticana.do" -3 0 0)
  #(add-new-clef "custom-vaticana-fa0" "clefs.vaticana.fa" -3 0 4)
  #(add-new-clef "custom-vaticana-fa3" "clefs.vaticana.fa"  3 0 4)

  \markup\fill-line{
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
      \layout {
        % When a clef change meets a barline, LilyPond by default prints the clef change
        % first, no matter their order in the source code. In chant notation it's highly unusual.
        % We definitely want the barline first.
        \override Score.BreakAlignment.break-align-orders =
          #(make-vector 3 '(span-bar
                            breathing-sign
                            staff-bar
                            clef
                            key
                            time-signature))
      }
    }

    \score {
      <<
      \new VaticanaVoice = "v" {
        \clef "custom-vaticana-do0"
        g'

        \finalis

        \clef "custom-vaticana-fa3"
        g
        \clef "custom-vaticana-fa0"
        g
        \finalis
      }
      \new VaticanaLyrics \lyricsto "v" {
        \repeat unfold 5 { sol }
      }
      >>
      \layout {
        \override Score.BreakAlignment.break-align-orders =
          #(make-vector 3 '(span-bar
                            breathing-sign
                            staff-bar
                            clef
                            key
                            time-signature))
      }
    }
  }

  \markup\vspace #1

  \markup\justify{
    \bold{Explicit positioning of the b flat.}
    It is standard practice in square notation to place a b flat
    earlier than the first affected b appears,
    in order to optimize appearance and readability.
    LilyPond doesn't support manual positioning of the b flat,
    the accidental is always placed immediately before the note
    it belongs to.
  }

  \score {
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ a \flexa g a \pes bes \inclinatum a \inclinatum g \]
    }
  }

  \markup\justify{
    \bold{Remembering b flat.}
    In chant notation

    % quote
    "\"B-flat," when it occurs, only holds good as far as the next natural
    \concat{( \musicglyph "accidentals.vaticana0" ),}
    or dividing line, or new "word\""
    (The Liber Usualis, Tournai-New York 1961, p. XIV).

    LilyPond by default repeats the accidental for every affected note.
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ a\melisma \pes bes g g a \pes bes\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { La }
    >>
  }

  \markup\vspace #1

  \markup\justify{
    \bold{Neumatic space.}
    In modern chant editions spaces of various sizes structure longer neumes.
    LilyPond doesn't provide a standardized solution.
    Invisible notes of various sizes can be used as a workaround.
  }

  % TODO real-life example
}

\bookpart {
  \header { subtitle = "Severe horizontal spacing issues" }

  \markup\justify{
    The default spacing of scores without lyrics is extremely tight,
    to the point of being hardly readable (example left).
    It can be partially improved by adjusting the configuration (example right).
  }

  \markup\fill-line{
    % psalm tone IV.g
    \score {
      \new VaticanaVoice {
        \clef "vaticana-do3"
        a \[ g \pes a \] a a a\accentus \[ \cavum g \] \augmentum g \divisioMinima
        a a g a b\accentus \[ \cavum a \] \augmentum a \divisioMaxima
        a a a\accentus \[ \cavum g \] \augmentum g \finalis
      }
    }

    \score {
      \new VaticanaVoice {
        \clef "vaticana-do3"
        a \[ g \pes a \] a a a\accentus \[ \cavum g \] \augmentum g \divisioMinima
        a a g a b\accentus \[ \cavum a \] \augmentum a \divisioMaxima
        a a a\accentus \[ \cavum g \] \augmentum g \finalis
      }
      \layout {
        % TODO can the spacing be improved also for melismata?
        \override VaticanaVoice.NoteHead.X-offset = #1
      }
    }
  }

  \markup\vspace #1

  \markup\justify{
    Under a pes (and possibly some other vertically stacked neumes)
    the left edge of the lyric syllable is aligned to the right edge of the neume,
    so that the syllable is more after than under its neume.
    This lyrics alignment is very different from simple notes
    or other composed neume types.
  }

  \markup\fill-line{
    \score {
      <<
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ e\melisma \pes f\melismaEnd \] d
      }
      \new VaticanaLyrics \lyricsto "v" { ter -- ra }
      >>
    }

    \score {
      <<
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ c'\melisma \flexa \deminutum b\melismaEnd \]
      }
      \new VaticanaLyrics \lyricsto "v" { cer }
      >>
    }

    "" ""
  }

  \markup\vspace #1

  \markup\justify{
    Melismata (note groups enclosed in the \typewriter{"\\[ \\]"} melisma brackets)
    collide/confound with their neighbours
    when the width of the melisma is greater than that of the lyric syllable underneath.
  }

  % The first example is from the (ornate, Editio Vaticana) Salve Regina antiphon,
  % the subsequent ones are variations thereof, demonstrating that the behaviour
  % is the same regardless type and position/pitch of the second melisma.
  \markup\fill-line{
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
  }

  \markup\fill-line{
    % neume without lyrics merges with the following one
    % (another example from the Salve Regina)
    \score {
      <<
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ d\melisma \pes e f \flexa g\melismaEnd \] \[ g\melisma \flexa \deminutum f\melismaEnd \]
      }
      \new VaticanaLyrics \lyricsto "v" { _ dul }
      >>
    }

    "" "" ""
  }

  \markup\vspace #1

  \markup{Melismata run under/over divisiones}

  \markup\fill-line{
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

    ""
  }

  \markup\vspace #1

  \markup\justify{
    Markup attached to a note affects score horizontal spacing.
    In documents which include \typewriter{gregorian.ly}
    this affects also modern notation scores.
  }

  \markup\fill-line{
    \score {
      <<
        \new VaticanaVoice = "v" { g^"attached markup" g }
        \new VaticanaLyrics \lyricsto "v" { La La }
      >>
    }

    \score {
      \relative c'' { g^"attached markup" g }
      \addlyrics { La La }
    }
  }
}

\bookpart {
  \header { subtitle = "Other glitches" }

  \markup\column{
    \line{}
    \line{}
  }
}
