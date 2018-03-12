module FormValidator.ValidatorTest exposing (all)

import Expect
import Test exposing (Test, describe, test)
import FormValidator.Models as Models
import FormValidator.Validators as Validators
import FormValidator.Validator as Validator

type FieldKey
  = Name
  | Email
  | Preferences

testForm : Models.Form FieldKey
testForm =
  [
    Validator.init Name [],
    Validator.init Email [Validators.isBlank, Validators.isEmail],
    Validator.init Preferences [Validators.isBlank]
  ]

all : Test
all =
  describe "Validator" [
    describe "init" [
      test "answers field without validators" <| \_ ->
        let
          proof = {key = Name, value = "", validators = [], errors = []}
        in
          Validator.init Name [] |> Expect.equal proof,

      test "answers field with validators" <| \_ ->
        let
          proof = {key = Name, value = "", validators = [Validators.isBlank], errors = []}
        in
          Validator.init Name [Validators.isBlank] |> Expect.equal proof
    ],

    describe "fieldValues" [
      test "answers multiple values" <| \_ ->
        Validator.updateValues Preferences ["a", "b"] testForm
          |> Validator.fieldValues Preferences
          |> Expect.equal ["a", "b"],

      test "answers single value" <| \_ ->
        Validator.updateValue Preferences "example" testForm
          |> Validator.fieldValues Preferences
          |> Expect.equal ["example"],

      test "answers empty list when values don't exist" <| \_ ->
        Validator.fieldValues Preferences testForm |> Expect.equal []
    ],

    describe "fieldValue" [
      test "answers value" <| \_ ->
        Validator.updateValue Name "Test" testForm
          |> Validator.fieldValue Name
          |> Expect.equal "Test",

      test "answers empty string when value doesn't exist" <| \_ ->
        Validator.fieldValue Name testForm |> Expect.equal ""
    ],

    describe "fieldErrors" [
      test "answers multiple errors" <| \_ ->
        Validator.updateAndValidateValue Email "" testForm
          |> Validator.fieldErrors Email
          |> Expect.equal [
            Just "Must not be blank.",
            Just "Must be an email address."
          ],

      test "answers single error" <| \_ ->
        Validator.updateAndValidateValues Preferences [] testForm
          |> Validator.fieldErrors Preferences
          |> Expect.equal [Just "Must not be blank."]
    ],

    describe "isFormInvalid" [
      test "answers valid form" <| \_ ->
        Validator.isFormInvalid testForm
          |> Expect.equal False,

      test "answers invalid form" <| \_ ->
        Validator.validateForm testForm
          |> Validator.isFormInvalid
          |> Expect.equal True
    ],

    describe "isFieldInvalid" [
      test "answers valid form" <| \_ ->
        Validator.isFieldInvalid Name testForm
          |> Expect.equal False,

      test "answers invalid form" <| \_ ->
        Validator.validateForm testForm
          |> Validator.isFieldInvalid Preferences
          |> Expect.equal True
    ]
  ]
