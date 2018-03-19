module FormValidator.Views exposing
  (
    field,
    errors,
    error
  )

{-|

The Form Validator views which are convenience methods for rendering fields within your form and
page views.

@docs field, errors, error

-}

import Html exposing (Html, div, text, li, ul)
import Html.Attributes exposing (class, classList)
import FormValidator.Models as Models
import FormValidator.Validator as Validator

-- VIEWS

{-| View field with errors (if any). To be used as a wrapper to field input field(s). -}
field : key -> Models.Form key -> List String -> List (Html message) -> Html message
field key form classes nodes =
  let
    enabledClasses = List.map enableClass classes
    computedClasses = enabledClasses ++ [fieldErrorClass key form]
    content = nodes ++ [errors <| Validator.fieldErrors key form]
  in
    div [classList computedClasses] content

{-| View field errors (if any) as a unordered list. -}
errors : Models.Errors -> Html message
errors errors =
  if List.isEmpty errors then
    text ""
  else
    ul [class "form_validator-errors"] (List.map error errors)

{-| View field error (if any) as a list item. -}
error : Models.Error -> Html message
error error =
  case error of
    Just error ->
      li [class "form_validator-error"] [text error]

    Nothing ->
      text ""

-- UTILITIES

enableClass : String -> (String, Bool)
enableClass class =
  (class, True)

fieldErrorClass : key -> Models.Form key -> (String, Bool)
fieldErrorClass key form =
  ("form_validator-field_error", Validator.isFieldInvalid key form)
