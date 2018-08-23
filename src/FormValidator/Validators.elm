module FormValidator.Validators exposing
  (
    isBlank,
    isEmpty,
    isInteger,
    isFloat,
    isIncluded,
    isExcluded,
    isGreaterThan,
    isGreaterThanEqualTo,
    isLessThan,
    isLessThanEqualTo,
    isBetween,
    isLengthGreaterThan,
    isLengthGreaterThanEqualTo,
    isLengthLessThan,
    isLengthLessThanEqualTo,
    isLengthBetween,
    isEmail
  )

{-|

The Form Validator validators provide functionality needed for validating a form field. These can be
mixed and matched as desired.

@docs isBlank, isEmpty, isInteger, isFloat, isIncluded, isExcluded, isGreaterThan
@docs isGreaterThanEqualTo, isLessThan, isLessThanEqualTo, isBetween, isLengthGreaterThan
@docs isLengthGreaterThanEqualTo, isLengthLessThan, isLengthLessThanEqualTo, isLengthBetween
@docs isEmail

-}

import Regex
import FormValidator.Models as Models
import FormValidator.Patterns as Patterns

{-| Validates if value is blank. -}
isBlank : Models.Value -> Models.Error
isBlank value =
  if Regex.contains Patterns.blank value then
    Just "Must not be blank."
  else
    Nothing

{-| Validates if value is empty. -}
isEmpty : Models.Value -> Models.Error
isEmpty value =
  if String.isEmpty value then
    Just "Must have at least one selection."
  else
    Nothing

{-| Validates if value is an integer. -}
isInteger : Models.Value -> Models.Error
isInteger value =
  case String.toInt value of
    Just _ ->
      Nothing
    Nothing ->
      Just "Must be a number."

{-| Validates if value is a float. -}
isFloat : Models.Value -> Models.Error
isFloat value =
  case String.toFloat value of
    Just _ ->
      Nothing
    Nothing ->
      Just "Must be a decimal."

{-| Validates if value is included in list. -}
isIncluded : List String -> Models.Value -> Models.Error
isIncluded includes value =
  if List.member value includes then
    Nothing
  else
    Just <| "Invalid value. Use: " ++ (String.join ", " includes) ++ "."

{-| Validates if value is excluded from list. -}
isExcluded : List String -> Models.Value -> Models.Error
isExcluded excludes value =
  if List.member value excludes then
    Just <| "Invalid value. Avoid: " ++ (String.join ", " excludes) ++ "."
  else
    Nothing

{-| Validates if value is greater than minimum. -}
isGreaterThan : Int -> Models.Value -> Models.Error
isGreaterThan minimum value =
  let
    number = Maybe.withDefault 0 <| String.toInt value
  in
    if number > minimum then
      Nothing
    else
      Just ("Must be greater than " ++ (String.fromInt minimum) ++ ".")

{-| Validates if value is greater than or equal to minimum. -}
isGreaterThanEqualTo : Int -> Models.Value -> Models.Error
isGreaterThanEqualTo minimum value =
  let
    number = Maybe.withDefault 0 <| String.toInt value
  in
    if number >= minimum then
      Nothing
    else
      Just ("Must be greater than or equal to " ++ (String.fromInt minimum) ++ ".")

{-| Validates if value is less than maximum. -}
isLessThan : Int -> Models.Value -> Models.Error
isLessThan maximum value =
  let
    number = Maybe.withDefault 0 <| String.toInt value
  in
    if number < maximum then
      Nothing
    else
      Just ("Must be less than " ++ (String.fromInt maximum) ++ ".")

{-| Validates if value is less than or equal to maximum. -}
isLessThanEqualTo : Int -> Models.Value -> Models.Error
isLessThanEqualTo maximum value =
  let
    number = Maybe.withDefault 0 <| String.toInt value
  in
    if number <= maximum then
      Nothing
    else
      Just ("Must be less than or equal to " ++ (String.fromInt maximum) ++ ".")

{-| Validates if value is within minimum and maximum *inclusive* range. -}
isBetween : Int -> Int -> Models.Value -> Models.Error
isBetween minimum maximum value =
  let
    number = Maybe.withDefault 0 <| String.toInt value
  in
    if number >= minimum && number <= maximum then
      Nothing
    else
      Just ("Must be between " ++ (String.fromInt minimum) ++ " and " ++ (String.fromInt maximum) ++ ".")

{-| Validates if value length is greater than minimum. -}
isLengthGreaterThan : Int -> Models.Value -> Models.Error
isLengthGreaterThan minimum value =
  if String.length value > minimum then
    Nothing
  else
    Just ("Must be greater than " ++ (String.fromInt minimum) ++ " characters.")

{-| Validates if value length is greater than or equal to minimum. -}
isLengthGreaterThanEqualTo : Int -> Models.Value -> Models.Error
isLengthGreaterThanEqualTo minimum value =
  if String.length value >= minimum then
    Nothing
  else
    Just ("Must be greater than or equal to " ++ (String.fromInt minimum) ++ " characters.")

{-| Validates if value length is less than maximum. -}
isLengthLessThan : Int -> Models.Value -> Models.Error
isLengthLessThan maximum value =
  if String.length value < maximum then
    Nothing
  else
    Just ("Must be less than " ++ (String.fromInt maximum) ++ " characters.")

{-| Validates if value length is less than or equal to maximum. -}
isLengthLessThanEqualTo : Int -> Models.Value -> Models.Error
isLengthLessThanEqualTo maximum value =
  if String.length value <= maximum then
    Nothing
  else
    Just ("Must be less than or equal to " ++ (String.fromInt maximum) ++ " characters.")

{-| Validates if value length is between minimum and maximum *inclusive* range. -}
isLengthBetween : Int -> Int -> Models.Value -> Models.Error
isLengthBetween minimum maximum value =
  let
    length = String.length value
  in
    if length >= minimum && length <= maximum then
      Nothing
    else
      Just ("Must be between " ++ (String.fromInt minimum) ++ " and " ++ (String.fromInt maximum) ++ " characters.")

{-| Validates if value is an email address. -}
isEmail : Models.Value -> Models.Error
isEmail value =
  if Regex.contains Patterns.email value then
    Nothing
  else
    Just "Must be an email address."
