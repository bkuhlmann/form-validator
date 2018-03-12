module FormValidator.ValidatorsTest exposing (all)

import Expect
import Test exposing (Test, describe, test)
import FormValidator.Validators as Validators

all : Test
all =
  describe "Validators" [
    describe "isBlank" [
      test "answers error when blank" <| \_ ->
        Validators.isBlank "" |> Expect.equal (Just "Must not be blank."),

      test "answers error when space" <| \_ ->
        Validators.isBlank " " |> Expect.equal (Just "Must not be blank."),

      test "answers nothing when string" <| \_ ->
        Validators.isBlank "example" |> Expect.equal Nothing
    ],

    describe "isEmpty" [
      test "answers error when empty" <| \_ ->
        Validators.isEmpty "" |> Expect.equal (Just "Must have at least one selection."),

      test "answers nothing when non-empty" <| \_ ->
        Validators.isEmpty "example" |> Expect.equal Nothing
    ],

    describe "isInteger" [
      test "answers error when string" <| \_ ->
        Validators.isInteger "x" |> Expect.equal (Just "Must be a number."),

      test "answers error when float" <| \_ ->
        Validators.isInteger "1.2" |> Expect.equal (Just "Must be a number."),

      test "answers nothing when integer" <| \_ ->
        Validators.isInteger "1" |> Expect.equal Nothing
    ],

    describe "isFloat" [
      test "answers error when string" <| \_ ->
        Validators.isFloat "x" |> Expect.equal (Just "Must be a decimal."),

      test "answers nothing when integer" <| \_ ->
        Validators.isFloat "1" |> Expect.equal Nothing,

      test "answers nothing when float" <| \_ ->
        Validators.isFloat "1.2" |> Expect.equal Nothing
    ],

    describe "isIncluded" [
      test "answers error when excluded" <| \_ ->
        Validators.isIncluded ["red", "blue"] "bogus"
          |> Expect.equal (Just "Invalid choice: bogus. Use: red, blue."),

      test "answers nothing when included" <| \_ ->
        Validators.isIncluded ["red", "blue"] "red"
          |> Expect.equal Nothing
    ],

    describe "isExcluded" [
      test "answers error when included" <| \_ ->
        Validators.isExcluded ["red", "blue"] "red"
          |> Expect.equal (Just "Invalid choice: red. Avoid: red, blue."),

      test "answers nothing when included" <| \_ ->
        Validators.isExcluded ["red", "blue"] "black"
          |> Expect.equal Nothing
    ],

    describe "isGreaterThan" [
      test "answers error when less than minimum" <| \_ ->
        Validators.isGreaterThan 10 "5" |> Expect.equal (Just "Must be greater than 10."),

      test "answers error when equal to minimum" <| \_ ->
        Validators.isGreaterThan 10 "10" |> Expect.equal (Just "Must be greater than 10."),

      test "answers nothing when greater than minimum" <| \_ ->
        Validators.isGreaterThan 10 "15" |> Expect.equal Nothing
    ],

    describe "isLessThan" [
      test "answers error when greater than maximum" <| \_ ->
        Validators.isLessThan 10 "15" |> Expect.equal (Just "Must be less than 10."),

      test "answers error when equal to maximum" <| \_ ->
        Validators.isLessThan 10 "10" |> Expect.equal (Just "Must be less than 10."),

      test "answers nothing when less than maximum" <| \_ ->
        Validators.isLessThan 10 "5" |> Expect.equal Nothing
    ],

    describe "isBetween" [
      test "answers error when less than minimum" <| \_ ->
        Validators.isBetween 1 10 "0" |> Expect.equal (Just "Must be between 1 and 10."),

      test "answers error when greater than maximum" <| \_ ->
        Validators.isBetween 1 10 "11" |> Expect.equal (Just "Must be between 1 and 10."),

      test "answers nothing when beteen minimum and maximum" <| \_ ->
        Validators.isBetween 1 10 "5" |> Expect.equal Nothing
    ],

    describe "isLengthGreaterThanEqualTo" [
      test "answers error when less than minimum" <| \_ ->
        Validators.isLengthGreaterThanEqualTo 10 "Short."
          |> Expect.equal (Just "Must be greater than or equal to 10 characters."),

      test "answers nothing when equal to minimum" <| \_ ->
        Validators.isLengthGreaterThanEqualTo 10 "Test safe." |> Expect.equal Nothing,

      test "answers nothing when greater than minimum" <| \_ ->
        Validators.isLengthGreaterThanEqualTo 10 "This is quite safe." |> Expect.equal Nothing
    ],

    describe "isLengthLessThanEqualTo" [
      test "answers error when greater than maximum" <| \_ ->
        Validators.isLengthLessThanEqualTo 10 "This test is too long."
          |> Expect.equal (Just "Must be less than or equal to 10 characters."),

      test "answers nothing when equal to maximum" <| \_ ->
        Validators.isLengthLessThanEqualTo 10 "Test safe." |> Expect.equal Nothing,

      test "answers nothing when less than maximum" <| \_ ->
        Validators.isLengthLessThanEqualTo 10 "Safe." |> Expect.equal Nothing
    ],

    describe "isEmail" [
      test "answers error when doesn't resemble and email adddress" <| \_ ->
        Validators.isEmail "bogus" |> Expect.equal (Just "Must be an email address."),

      test "answers error when user is missing" <| \_ ->
        Validators.isEmail "@bogus.com" |> Expect.equal (Just "Must be an email address."),

      test "answers error when domain is missing" <| \_ ->
        Validators.isEmail "bogus@" |> Expect.equal (Just "Must be an email address."),

      test "answers nothing when email" <| \_ ->
        Validators.isEmail "test@example.com" |> Expect.equal Nothing
    ]
  ]
