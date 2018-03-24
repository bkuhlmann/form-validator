module FormValidator.Validator exposing
  (
    init,
    fieldValues,
    fieldValue,
    fieldErrors,
    updateValues,
    updateValue,
    updateAndValidateValues,
    updateAndValidateValue,
    resetForm,
    resetField,
    validateForm,
    validateField,
    isFormInvalid,
    isFieldInvalid
  )

{-|

The Form Validator validator which is main module used to manage forms and fields.

@docs init, fieldValues, fieldValue, fieldErrors, updateValues, updateValue, updateAndValidateValues, resetForm, resetField
@docs updateAndValidateValue, validateForm, validateField, isFormInvalid, isFieldInvalid

-}

import List.Extra
import FormValidator.Models as Models

-- CONSTANTS

valuesDelimiter : String
valuesDelimiter =
  ", "

-- INIT

{-| Initialize a new form field. -}
init : key -> Models.Validators -> Models.Field key
init key validators =
  {
    key = key,
    value = "",
    validators = validators,
    errors = []
  }

-- ACCESSORS

{-| Answer multiple field values. -}
fieldValues : key -> Models.Form key -> List String
fieldValues key form =
  let
    value = fieldValue key form
  in
    if String.isEmpty value then
      []
    else
      String.split valuesDelimiter value

{-| Answer single field value. -}
fieldValue : key -> Models.Form key -> String
fieldValue key form =
  findField key form
    |> Maybe.map .value
    |> Maybe.withDefault ""


{-| Answer all errors for a field. -}
fieldErrors : key -> Models.Form key -> Models.Errors
fieldErrors key form =
  findField key form
    |> Maybe.map .errors
    |> Maybe.withDefault []

-- UPDATERS

{-| Update multiple field values without validation. -}
updateValues : key -> Models.Values -> Models.Form key -> Models.Form key
updateValues key values form =
  let
    filteredValues = List.filter (\value -> not <| String.isEmpty value) values
  in
    updateValue key (String.join valuesDelimiter filteredValues) form

{-| Update single field value without validation. -}
updateValue : key -> Models.Value -> Models.Form key -> Models.Form key
updateValue key value form =
  List.Extra.updateIf (isField key) (updateFieldValue value) form

{-| Answer multiple field values and validate each. -}
updateAndValidateValues : key -> Models.Values -> Models.Form key -> Models.Form key
updateAndValidateValues key values form =
  updateValues key values form |> validateField key

{-| Answer single field value and validate it. -}
updateAndValidateValue : key -> Models.Value -> Models.Form key -> Models.Form key
updateAndValidateValue key value form =
  updateValue key value form |> validateField key

{-| Answer form with all field values and errors reset to initial state. -}
resetForm : Models.Form key -> Models.Form key
resetForm form =
  List.map (updateFieldValueAndErrors "" []) form

{-| Answer field with value and error reset to initial state. -}
resetField : key -> Models.Form key -> Models.Form key
resetField key form =
  List.Extra.updateIf (isField key) (updateFieldValueAndErrors "" []) form

-- VALIDATORS

{-| Validate form (including all fields). -}
validateForm : Models.Form key -> Models.Form key
validateForm form =
  List.map updateFieldErrors form

{-| Validate field. -}
validateField : key -> Models.Form key -> Models.Form key
validateField key form =
  List.Extra.updateIf (isField key) updateFieldErrors form

{-| Answer if form is invalid. -}
isFormInvalid : Models.Form key -> Bool
isFormInvalid form =
  List.concatMap .errors form |> List.any isError

{-| Answer if field is invalid. -}
isFieldInvalid : key -> Models.Form key -> Bool
isFieldInvalid key form =
  List.any isError <| fieldErrors key form

-- UTILITIES

findField : key -> Models.Form key -> Maybe (Models.Field key)
findField key form =
  List.Extra.find (isField key) form

isField : key -> Models.Field key -> Bool
isField key field =
  field.key == key

isError : Models.Error -> Bool
isError error =
  case error of
    Just error ->
      True

    Nothing ->
      False

updateFieldValue : Models.Value -> Models.Field key -> Models.Field key
updateFieldValue value field =
  {field | value = value}

updateFieldErrors : Models.Field key -> Models.Field key
updateFieldErrors field =
  {field | errors = buildErrors field}

updateFieldValueAndErrors : Models.Value -> Models.Errors -> Models.Field key -> Models.Field key
updateFieldValueAndErrors value errors field =
  {field | value = value, errors = errors}

buildErrors : Models.Field key -> Models.Errors
buildErrors field =
  List.map (\validator -> validator field.value) field.validators
