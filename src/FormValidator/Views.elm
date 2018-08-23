module FormValidator.Views exposing
  (
    field,
    errors,
    error
  )

{-|

The Form Validator views which are convenience methods for rendering forms and fields within your
views.

@docs field, errors, error

-}

import Html exposing (Html, div, text, li, ul)
import Html.Attributes exposing (class, classList)
import FormValidator.Models as Models
import FormValidator.Validator as Validator

-- VIEWS

{-| View field with errors (if any). To be used as a wrapper around field DOM elements. -}
field : key -> Models.Form key -> List String -> List (Html message) -> Html message
field key form classes nodes =
  let
    enabledClasses = List.map enableClass classes
    computedClasses = enabledClasses ++ [fieldErrorClass key form]
    content = nodes ++ [errors <| Validator.fieldErrors key form]
  in
    div [classList computedClasses] content

{-| View field errors (if any) as an unordered list. -}
errors : Models.Errors -> Html message
errors messages =
  if List.isEmpty messages then
    text ""
  else
    ul [class "form_validator-errors"] (List.map error messages)

{-| View field error (if any) as a list item. -}
error : Models.Error -> Html message
error message =
  case message of
    Just errorMessage ->
      li [class "form_validator-error"] [text errorMessage]

    Nothing ->
      text ""

-- UTILITIES

enableClass : String -> (String, Bool)
enableClass class =
  (class, True)

fieldErrorClass : key -> Models.Form key -> (String, Bool)
fieldErrorClass key form =
  ("form_validator-field_error", Validator.isFieldInvalid key form)
