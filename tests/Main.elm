module Main exposing (all)

import Expect
import Test exposing (Test, describe)
import FormValidator.ValidatorTest as ValidatorTest
import FormValidator.ValidatorsTest as ValidatorsTest
import FormValidator.PatternsTest as PatternsTest

all : Test
all =
  describe "Form Validator" [
    ValidatorTest.all,
    ValidatorsTest.all,
    PatternsTest.all
  ]
