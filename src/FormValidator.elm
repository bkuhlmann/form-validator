module FormValidator exposing (..)

{-|

A customizable form validation component.

This is a wrapper module which exposes public functions, within a single module, found in the sub-
modules of this package:
  - `Models`
  - `Patterns`
  - `Validator`
  - `Validators`
  - `Views`

This wrapper module is provided for convenience in case you don't wish to import the above modules
individually. It also serves as a fast way to get up and running quickly via a single import. If
this is not desired, you can ignore this module altogether and import the individual sub-modules as
needed for your implementation. See the README for details.

# Models

@docs Form

# Init

@docs init

# Accessors

@docs fieldValues, fieldValue, fieldErrors

# Updaters

@docs updateValues, updateValue, updateAndValidateValues, updateAndValidateValue, resetForm
@docs resetField

# Validators

@docs validateForm, validateField, isFormInvalid, isFieldInvalid, isBlank, isEmpty, isInteger
@docs isFloat, isIncluded, isExcluded, isGreaterThan, isGreaterThanEqualTo, isLessThan
@docs isLessThanEqualTo, isBetween, isLengthGreaterThan, isLengthGreaterThanEqualTo
@docs isLengthLessThan, isLengthLessThanEqualTo, isLengthBetween, isEmail

# Views

@docs viewField, viewErrors, viewError

-}

import Html exposing (Html)
import FormValidator.Models as Models
import FormValidator.Validator as Validator
import FormValidator.Validators as Validators
import FormValidator.Views as Views

-- MODELS

{-| `Models` module wrapper function. See `Models` module for details. -}
type alias Form key =
  Models.Form key

-- INIT

{-| `Validator` module wrapper function. See `Validator` module for details. -}
init : key -> Models.Validators -> Models.Field key
init key validators =
  Validator.init key validators

-- ACCESSORS

{-| `Validator` module wrapper function. See `Validator` module for details. -}
fieldValues : key -> Form key -> List String
fieldValues key form =
  Validator.fieldValues key form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
fieldValue : key -> Models.Form key -> String
fieldValue key form =
  Validator.fieldValue key form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
fieldErrors : key -> Models.Form key -> Models.Errors
fieldErrors key form =
  Validator.fieldErrors key form

-- UPDATERS

{-| `Validator` module wrapper function. See `Validator` module for details. -}
updateValues : key -> Models.Values -> Models.Form key -> Models.Form key
updateValues key values form =
  Validator.updateValues key values form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
updateValue : key -> Models.Value -> Models.Form key -> Models.Form key
updateValue key value form =
  Validator.updateValue key value form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
updateAndValidateValues : key -> Models.Values -> Models.Form key -> Models.Form key
updateAndValidateValues key values form =
  Validator.updateAndValidateValues key values form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
updateAndValidateValue : key -> Models.Value -> Models.Form key -> Models.Form key
updateAndValidateValue key value form =
  Validator.updateAndValidateValue key value form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
resetForm : Models.Form key -> Models.Form key
resetForm form =
  Validator.resetForm form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
resetField : key -> Models.Form key -> Models.Form key
resetField key form =
  Validator.resetField key form

-- VALIDATORS

{-| `Validator` module wrapper function. See `Validator` module for details. -}
validateForm : Models.Form key -> Models.Form key
validateForm form =
  Validator.validateForm form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
validateField : key -> Models.Form key -> Models.Form key
validateField key form =
  Validator.validateField key form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
isFormInvalid : Models.Form key -> Bool
isFormInvalid form =
  Validator.isFormInvalid form

{-| `Validator` module wrapper function. See `Validator` module for details. -}
isFieldInvalid : key -> Models.Form key -> Bool
isFieldInvalid key form =
  Validator.isFieldInvalid key form

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isBlank : Models.Value -> Models.Error
isBlank value =
  Validators.isBlank value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isEmpty : Models.Value -> Models.Error
isEmpty value =
  Validators.isEmpty value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isInteger : Models.Value -> Models.Error
isInteger value =
  Validators.isInteger value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isFloat : Models.Value -> Models.Error
isFloat value =
  Validators.isFloat value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isIncluded : List String -> Models.Value -> Models.Error
isIncluded includes value =
  Validators.isIncluded includes value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isExcluded : List String -> Models.Value -> Models.Error
isExcluded excludes value =
  Validators.isExcluded excludes value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isGreaterThan : Int -> Models.Value -> Models.Error
isGreaterThan minimum value =
  Validators.isGreaterThan minimum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isGreaterThanEqualTo : Int -> Models.Value -> Models.Error
isGreaterThanEqualTo minimum value =
  Validators.isGreaterThanEqualTo minimum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isLessThan : Int -> Models.Value -> Models.Error
isLessThan maximum value =
  Validators.isLessThan maximum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isLessThanEqualTo : Int -> Models.Value -> Models.Error
isLessThanEqualTo maximum value =
  Validators.isLessThanEqualTo maximum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isBetween : Int -> Int -> Models.Value -> Models.Error
isBetween minimum maximum value =
  Validators.isBetween minimum maximum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isLengthGreaterThan : Int -> Models.Value -> Models.Error
isLengthGreaterThan minimum value =
  Validators.isLengthGreaterThan minimum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isLengthGreaterThanEqualTo : Int -> Models.Value -> Models.Error
isLengthGreaterThanEqualTo minimum value =
  Validators.isLengthGreaterThanEqualTo minimum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isLengthLessThan : Int -> Models.Value -> Models.Error
isLengthLessThan maximum value =
  Validators.isLengthLessThan maximum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isLengthLessThanEqualTo : Int -> Models.Value -> Models.Error
isLengthLessThanEqualTo maximum value =
  Validators.isLengthLessThanEqualTo maximum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isLengthBetween : Int -> Int -> Models.Value -> Models.Error
isLengthBetween minimum maximum value =
  Validators.isLengthBetween minimum maximum value

{-| `Validators` module wrapper function. See `Validators` module for details. -}
isEmail : Models.Value -> Models.Error
isEmail value =
  Validators.isEmail value

-- VIEWS

{-| `Views` module wrapper function. See `Views` module for details. -}
viewField : key -> Models.Form key -> List String -> List (Html message) -> Html message
viewField key form classes nodes =
  Views.field key form classes nodes

{-| `Views` module wrapper function. See `Views` module for details. -}
viewErrors : Models.Errors -> Html message
viewErrors errors =
  Views.errors errors

{-| `Views` module wrapper function. See `Views` module for details. -}
viewError : Models.Error -> Html message
viewError error =
  Views.error error
