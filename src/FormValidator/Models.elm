module FormValidator.Models exposing
  (
    Form,
    Field,
    Validators,
    Validator,
    Values,
    Value,
    Errors,
    Error
  )

{-|

Form Validator component models.

@docs Form, Field, Validators, Validator, Values, Value, Errors, Error

-}

{-| The form model which stores a list of fields for input and validation. -}
type alias Form key =
  List (Field key)

{-|
The form field, identified by unique key, which stores a value, validators of that value,
and validation errors (if any).
-}
type alias Field key =
  {
    key: key,
    value: String,
    validators: Validators,
    errors: Errors
  }

{-| Convenience model for list of validators. -}
type alias Validators =
  List Validator

{-| Validates value as either an error string (invalid) or nothing at all (valid). -}
type alias Validator =
  (String -> Maybe String)

{-| A list of values to be validated. -}
type alias Values =
  List Value

{-| A value to be validated. -}
type alias Value =
  String

{-| The error messages of invalid values. -}
type alias Errors =
  List Error

{-| The error message of an invalid value. -}
type alias Error =
  Maybe String
