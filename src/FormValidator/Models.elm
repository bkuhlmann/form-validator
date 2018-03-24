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

The Form Validator component models.

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

{-| A list of validators for a field. -}
type alias Validators =
  List Validator

{-| A field validator which evaluates to an error string (invalid) or nothing at all (valid). -}
type alias Validator =
  (String -> Maybe String)

{-| A list of field values to be validated. -}
type alias Values =
  List Value

{-| A field value to be validated. -}
type alias Value =
  String

{-| The corresponding error messages of an invalid field value(s). -}
type alias Errors =
  List Error

{-| The corresponding error message of an invalid field value. -}
type alias Error =
  Maybe String
