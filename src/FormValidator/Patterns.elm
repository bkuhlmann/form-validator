module FormValidator.Patterns exposing
  (
    blank,
    email
  )

{-|

The Form Validator regular expression patterns.

@docs blank, email

-}

import Regex

{-| Answer regular expression for blank string. -}
blank : Regex.Regex
blank =
  Regex.fromString "^\\s*$"
    |> Maybe.withDefault Regex.never

{-| Answer regular expression for email address. -}
email : Regex.Regex
email =
  Regex.fromStringWith {caseInsensitive = True, multiline = False} "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    |> Maybe.withDefault Regex.never
