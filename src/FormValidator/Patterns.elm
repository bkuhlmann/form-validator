module FormValidator.Patterns exposing
  (
    blank,
    email
  )

import Regex

{-| Answer regular expression for blank string. -}
blank : Regex.Regex
blank =
  Regex.regex "^\\s*$"

{-| Answer regular expression for email address. -}
email : Regex.Regex
email =
  Regex.regex "^.+@.+$" |> Regex.caseInsensitive
