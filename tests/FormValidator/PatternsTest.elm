module FormValidator.PatternsTest exposing (..)

import Regex
import Expect
import Test exposing (Test, describe, test)
import FormValidator.Patterns as Patterns

all : Test
all =
  describe "Patterns" [
    describe "blank" [
      test "answers true with empty string" <| \_ ->
        Regex.contains Patterns.blank ""|> Expect.equal True,

      test "answers true single whitespace" <| \_ ->
        Regex.contains Patterns.blank " "|> Expect.equal True,

      test "answers false when filled" <| \_ ->
        Regex.contains Patterns.blank "abc"|> Expect.equal False
    ],

    describe "email" [
      test "answers true with email address" <| \_ ->
        Regex.contains Patterns.email "test@example.com"|> Expect.equal True,

      test "answers true with sub-domain" <| \_ ->
        Regex.contains Patterns.email "test@test.example.com"|> Expect.equal True,

      test "answers true with numbers, dots, dashes, and underscores in user name" <| \_ ->
        Regex.contains Patterns.email "t3st.un-known_sample@example.com"|> Expect.equal True,

      test "answers false with generic string" <| \_ ->
        Regex.contains Patterns.email "test"|> Expect.equal False,

      test "answers false without user name" <| \_ ->
        Regex.contains Patterns.email "@example.com"|> Expect.equal False,

      test "answers false without domain" <| \_ ->
        Regex.contains Patterns.email "test@"|> Expect.equal False,

      test "answers false with multiple @'s" <| \_ ->
        Regex.contains Patterns.email "test@tester@example.com"|> Expect.equal False
    ]
  ]
