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
  Regex.regex "^\\s*$"

{-| Answer regular expression for email address. -}
email : Regex.Regex
email =
  Regex.regex "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    |> Regex.caseInsensitive
