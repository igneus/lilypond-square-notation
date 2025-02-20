\version "2.24.1"

\include "gregorian.ly"
\include "stylesheet.ily"
\include "commands.ily"

\header {
  title = "State of square notation in LilyPond"

  tagline =  \markup\small\center-column {
    \with-url "https://lilypond.org/" \line {
        #(format #f "Music engraving by LilyPond ~a~awww.lilypond.org"
           (lilypond-version)
           (ly:wide-char->utf-8 #x2014)
           )
    }

    \line{
      This document is released to the public domain under the
      \with-url "https://creativecommons.org/publicdomain/zero/1.0/" {
        CC0 1.0 Universal license
      }
    }
  }
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
    The source code may be useful as a source of code snippets
    and collection of workarounds for known issues.
  }

  \markup\justify{
    For comprehensive documentation see the
    \text-link "http://lilypond.org/doc/v2.24/Documentation/notation/ancient-notation" {
      "Ancient Notation section"
    }
    of the LilyPond Notation Reference.
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
    output quality and has some serious problems (see the chapters
    further below), but it also offers some unique features.
  }

  \markup\vspace #1

  \markup\justify{
    \bold{Unlimited lines of lyrics aligned to a staff}
    (cf. \gregorio-issue #374 )
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
      An -- ge -- li Dó -- mi -- ni, "..."
    }
    \new VaticanaLyrics \lyricsto "v" {
      _ San -- cti Dó -- mi -- ni, "..."
    }
    \new VaticanaLyrics \lyricsto "v" {
      Vír -- gi -- nes Dó -- mi -- ni, "..."
    }
    >>
    \header {
      piece = \markup{
        AR1912,
        p. 724; % Angeli - In Dedicatione S. Michaelis Archangeli
        [32] % Martyres - commune plurimorum martyrum
      }
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
      \new Voice \with { \magnifyStaff #4/6 } \transpose c c' {
        \cadenzaOn
        d c d f g f8( e) f4 d \bar "|"
        b, d b, d b, d e f \bar "|"
        a c' a b c' d' c' d' \bar "|"
        d' c' a8( g) f4 g f8( e) f4 d \bar "||"
      }
    >>
    \layout {
      \override VaticanaStaff.Clef.extra-offset = #'(0.3 . 0)
      \override VaticanaStaff.StaffSymbol.color = #black
      \override Staff.TimeSignature.stencil = ##f
    }
  }

  \markup\vspace #1

  \markup\justify{
    There are also many less prominent features
    which may be useful for specific use cases:
  }
  \markup{
    \bold{Parentheses}
    (cf. \gregorio-issue #1545 )
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \parenthesize g
      \finalis
      \[ \parenthesize g\melisma \pes a\melismaEnd \]
      \[ g\melisma \pes \parenthesize a\melismaEnd \]
      % TODO: parenthesize the pes as a whole
      \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      \repeat unfold 5 { La }
    }
    >>
  }

  \markup\vspace #1

  \markup{
    \bold{Rests}
    (cf. \gregorio-issue #1624 )
  }

  % TODO add space around rests
  % TODO find and transcribe a real-life example
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      g r8 g r4 g \finalis
      \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      \repeat unfold 5 { La }
    }
    >>
    \layout {
      \context {
        \VaticanaVoice
        \override Rest.font-size = #-2
      }
    }
  }

  \markup{
    \bold{Ambitus}
    (cf. \gregorio-issue #1453 )
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ d\melisma \pes f \flexa e\melismaEnd\] \[ g\melisma \pes a\melismaEnd \] \finalis
      \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      \repeat unfold 5 { La }
    }
    >>
    \layout {
      \context {
        \VaticanaVoice
        \consists Ambitus_engraver
        \override AmbitusNoteHead.font-size = #-4
      }
    }
  }

  % how a large ambitus (involving clef change) is rendered
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ f\melisma f \pes g\melismaEnd \] f \divisioMinima \[ f\melisma \pes g\melismaEnd \] f f
      \finalis
      \[ \virga f\melisma f f\melismaEnd \] \[ f\melisma \flexa c\melismaEnd \]
      \finalis
      \clef "vaticana-do2"
      c' c' c' c'
      c' \[ d'\melisma \flexa c' c' \flexa g c' \pes d' \flexa c' d' \flexa c' c' \flexa g\melismaEnd\]
      \divisioMinima
      \[ c'\melisma \pes d' \virga f' \virga g' \inclinatum f' \inclinatum d' \virga e' \inclinatum c' \inclinatum a\melismaEnd \]
      \finalis
    }
    \new VaticanaLyrics \lyricsto "v" {
      Chris -- tus fac -- tus est...
      cru -- cis...
      ex -- al -- tá -- vit il -- lum...
    }
    >>
    \layout {
      \context {
        \VaticanaVoice
        \consists Ambitus_engraver
        \override AmbitusNoteHead.font-size = #-4
      }
      \context {
        \Score
        \override BreakAlignment.break-align-orders =
          #(make-vector 3 '(ambitus
                            breathing-sign
                            staff-bar
                            clef))
      }
    }
    \header {
      piece = "cf. AR1912, p. 365"
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
    \bold{Explicit positioning of b flat.}
    It is standard practice in square notation to place the accidental
    earlier than the first affected note appears,
    in order to optimize appearance and readability.
    In Gregorio each accidental must be explicitly specified
    and is rendered wherever the input file specifies it.
    LilyPond on the other hand generates accidentals automatically,
    based on current key signature and note pitch,
    and doesn't support manual placement of a b flat independent of its note.
    And it doesn't take care to prevent collisions of accidentals with
    notes and other notation elements:
    the accidental is always placed immediately before the note
    it belongs to, no matter what (the first example).
    Workarounds are available (see the source code of the other examples).
  }

  \markup\fill-line{
    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ a \flexa g a \pes bes \inclinatum a \inclinatum g \]
      }
    }

    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ a \flexa g a \pes
        % manually adjust the accidental's position
        \tweak Accidental.extra-offset #'(-1 . 0)
        bes \inclinatum a \inclinatum g \]
      }
    }

    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"

        \accidentalStyle no-reset

        % alternative workaround using a (really) tiny invisible note
        \tweak NoteHead.font-size #-20
        \tweak NoteHead.transparent ##t
        bes

        \[ a \flexa g a \pes bes \inclinatum a \inclinatum g \]
      }
    }

    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"

        % alternative workaround using a note rendered as an accidental
        % - this is similar to how accidentals work in Gregorio
        \tweak NoteHead.stencil #ly:text-interface::print
        \tweak NoteHead.text \markup\musicglyph "accidentals.vaticanaM1"
        b

        \[ a \flexa g a \pes b \inclinatum a \inclinatum g \]
      }
    }
  }

  \markup\vspace #1

  \markup\justify{
    \bold{Remembering b flat.}
    In chant notation

    % quote
    "\"B-flat," when it occurs, only holds good as far as the next natural
    \concat{( \musicglyph "accidentals.vaticana0" ),}
    or dividing line, or new "word\""
    (The Liber Usualis, Tournai-New York 1961, p. XIV).

    LilyPond by default repeats the accidental for every affected note,
    even within the same syllable.
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \[ bes\melisma \inclinatum a \inclinatum g bes\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { La }
    >>
  }

  \markup\justify{
    The behaviour is configurable, but none of the available settings works
    really well for square notation.
  }
  \markup\justify{
    \text-link "http://lilypond.org/doc/v2.24/Documentation/notation/displaying-pitches#automatic-accidentals" {
      \typewriter{"\\accidentalStyle default"}
    }
    (which would be quite useful if it worked the same
    way as in modern notation)
    works in a funny way and is of no use.
  }

  % TODO investigate, find the exact rule by which it operates
  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \accidentalStyle default
      \[ bes\melisma \inclinatum a \inclinatum g bes \inclinatum a \inclinatum g\melismaEnd \]
      \[ bes\melisma \inclinatum a \inclinatum g bes \inclinatum a \inclinatum g\melismaEnd \]
    }
    \new VaticanaLyrics \lyricsto "v" { Laaaaa laaaa }
    >>
  }

  \markup\justify{
    The only viable setting is
    \typewriter{"\\accidentalStyle no-reset"}
    which means that after the first b flat the accidental is remembered forever
    and in order to have rendered another one
    it must be explicitly requested with the exclamation mark suffix:
    \typewriter{"bes!"}
  }

  \score {
    <<
    \new VaticanaVoice = "v" {
      \clef "vaticana-do3"
      \accidentalStyle no-reset
      \[ bes\melisma \inclinatum a \inclinatum g bes\melismaEnd \]
      bes
      bes!
    }
    \new VaticanaLyrics \lyricsto "v" { Laa La La }
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
  % TODO look for a finer solution via grob properties (must work reliably also for ligatures)

  \markup\vspace #1

  \markup\justify{
    \bold{Context-sensitive episema direction.}
    Episema direction is by default always set to UP.
    As a result,
    for pes (and other vertically stacked neumes) it's impossible
    to tell if the episema is attached to the bottom note (first example),
    top note (second example)
    or both (third example).
    But at least the correct result can be achieved by setting
    DOWN direction manually where appropriate
    (the second line of examples).
  }

  \markup\fill-line{
    % bottom
    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ a\episemInitium\episemFinis \melisma \pes c'\melismaEnd \]
      }
    }

    % top
    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ a\melisma \pes c'\episemInitium\episemFinis \melismaEnd \]
      }
    }

    % both
    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ a\episemInitium\episemFinis \melisma \pes c'\episemInitium\episemFinis \melismaEnd \]
      }
    }
  }

  \markup\fill-line{
    % bottom
    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[
        \once \override Episema.direction = #DOWN
        a\episemInitium\episemFinis \melisma \pes c'\melismaEnd \]
      }
    }

    % top
    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[ a\melisma \pes c'\episemInitium\episemFinis \melismaEnd \]
      }
    }

    % both
    \score {
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        \[
        \once \override Episema.direction = #DOWN
        a\episemInitium\episemFinis \melisma \pes
        c'\episemInitium\episemFinis \melismaEnd \]
      }
    }
  }
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

  \markup\justify{
    \bold{Rhythmic signs wandering around.}
    In some scenarios
    punctum mora and ictus
    are not rendered with the notes where the source code indicates them,
    but at random places later in the score.
    In the following example each section closes with a clivis or pes,
    both notes of the neume always marked with a punctum mora.
    In the first two sections the puncta are rendered correctly,
    but in the third and fourth one they end up all over the place.
  }

  \score {
    <<
      \new VaticanaVoice = "uniqueContext0" {
        \clef "vaticana-do3"
        f \[ g \melisma \pes a \melismaEnd \] bes
        \[ \virga a \melisma \inclinatum g \inclinatum f\ictus \melismaEnd \] g
        \[ g \melisma \pes a \pes g \melismaEnd \] f \[ \augmentum e \melisma \pes \augmentum d \melismaEnd \]
        \divisioMaior
        g g\ictus a \[ f \melisma \pes d \melismaEnd \]
        f \[ e \melisma \pes f \melismaEnd \] d \[ \augmentum c \melisma \pes \augmentum d \melismaEnd \]
        \divisioMaxima
        d d\ictus f \[ d \melisma \pes c \melismaEnd \] f
        \[ f \melisma \pes g \pes a \melismaEnd \] g \[ \augmentum g \melisma \pes \augmentum f \melismaEnd \]
        \divisioMaior
        f \[ f \melisma \pes a \virga bes \inclinatum a \inclinatum g\ictus \melismaEnd \] a
        \[ f \melisma \pes d \melismaEnd \] f \[ e \melisma \pes f \melismaEnd \] d \[ \augmentum c \melisma \pes \augmentum d \melismaEnd \]
        \finalis
      }
      \new VaticanaLyrics \lyricsto "uniqueContext0" {
        Ve -- xil -- la Re -- gis pró -- de -- unt:
        Ful -- get Cru -- cis my -- sté -- ri -- um,
        Qua vi -- ta mor -- tem pér -- tu -- lit,
        Et mor -- te vi -- tam pró -- tu -- lit.
      }
    >>
    \header {
      piece = \markup\with-url "https://gregobase.selapa.net/chant.php?id=2120" {
        The Liber Usualis 1961, p. 575
      }
    }
  }
}

\bookpart {
  \header { subtitle = "Default settings" }

  \markup\justify{
    \bold{The default staff size is too small} and lyrics even more so.
  }

  % This is an illustrative example approximating the default sizes,
  % which are otherwise overridden by our stylesheet.
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
    \layout {
      % approximate the default settings

      % LilyPond default staff size
      #(layout-set-staff-size 20)

      % cf. ly/engraver-init.ly in LilyPond source tree
      \override VaticanaLyrics.LyricText.font-size = #-4
    }
  }

  \markup\justify{
    That's because LilyPond uses the so called staff space - the distance
    between two adjacent staff lines - as a base measuring unit.
    The default staff space is chosen so as to make sense in a five line staff
    of the modern notation and is applied to all supported notation styles,
    including square notation.
    But the characteristic proportions of square notation
    (ratio of the staff size to base note size and staff size to lyrics font size)
    are different from the modern notation.
    Due to the base note shape and its position in the staff
    the square notation requires a greater staff space than the modern notation
    in order to produce notes of comparable size/prominence.
    Square notation, in order to look at least remotely good and
    be comfortably readable, requires a greater staff size than the default one.
  }
  \markup\justify{
    \typewriter{ly/engraver-init.ly} sets for \typewriter{VaticanaLyrics}
    the value of \typewriter{LyricText.font-size} to \typewriter{-4.}
    That's a sensitive relative font size (the absolute font size depends
    on staff size) and the lyrics look good once the staff size is increased.
    But at the same time is increased also the default text font size
    (standalone markup text, lyrics of modern notation scores).
    When square notation lyrics are readable, all the other text in the document
    is \italic{huge.}
    Depending on what kinds of content the document contains and in which
    quantities, it is to be decided if the global settigns will be optimized
    for modern notation (and standalone markup text) and each instance
    of square notation will be resized manually, or vice versa.
  }

  \markup\vspace #1

  \markup\justify{
    \bold{Clef change, when meeting a divisio,} is by default rendered \italic{before}
    the divisio, no matter their order in the source code.
    This is usual in modern notation, but not in square notation.
    There is an easy fix (example on the right).
  }

  \markup\fill-line{
    \score {
      <<
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        g
        \finalis
        \clef "vaticana-do2"
        g
        \finalis
      }
      \new VaticanaLyrics \lyricsto "v" {
        \repeat unfold 5 { sol }
      }
      >>
    }

    \score {
      <<
      \new VaticanaVoice = "v" {
        \clef "vaticana-do3"
        g
        \finalis
        \clef "vaticana-do2"
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

  \markup\column{
    \line{}
    \line{}
  }
}
