# Form Validator

[![Circle CI Status](https://circleci.com/gh/bkuhlmann/form-validator.svg?style=svg)](https://circleci.com/gh/bkuhlmann/form-validator)

Provides a customizable form validation component for use within your views.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Features](#features)
  - [Screenshots](#screenshots)
  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Usage](#usage)
    - [Overview](#overview)
    - [Field Keys](#field-keys)
    - [Models](#models)
    - [Records/Validators](#recordsvalidators)
    - [Views](#views)
    - [Updates](#updates)
    - [Customization](#customization)
  - [Tests](#tests)
  - [Versioning](#versioning)
  - [Code of Conduct](#code-of-conduct)
  - [Contributions](#contributions)
  - [License](#license)
  - [History](#history)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Features

- Supports multi-form management.
- Supports multiple fields within a form.
- Supports validation of a single field or entire form.
- Supports field access and update management.
- Supports single or multiple field values.
- Supports single or multiple field errors.
- Supports many types of validations. Examples:
  - Blank
  - Empty
  - Integer
  - Float
  - Included
  - Excluded
  - GreaterThan
  - LessThan
  - Between
  - LengthGreaterThanEqualTo
  - LengthLessThanEqualTo
  - Email
- Supports custom validators and UI styling.
- Provides view helpers for rendering a form or field with or without errors.

## Screenshots

**Multiple Selection Error Example**

![](doc/screenshots/selection_error.png)

**Multiple Errors Example**

![](doc/screenshots/multiple_errors.png)

## Requirements

- [Elm](http://elm-lang.org)

## Setup

To setup and install, run:

    elm package install bkuhlmann/form-validator

You can import `FormValidator` as follows:

    import FormValidator as Validator

## Usage

This package supports a basic out-of-the-box experience in addition to full customization. The
following provides a general overview before digging into the specifics.

### Overview

A basic model-view-update implementation might look like this:

    module Pages.Example exposing (..)

    import FormValidator as Validator

    -- TYPES

    type FieldKey
      = Name
      | Email

    type Message
      = FieldInput FieldKey String
      | FieldBlur FieldKey
      | Save

    -- MODELS

    type alias Model =
      {
        form: Validator FieldKey
      }

    -- RECORDS

    initialModel : Model
    initialModel =
      {
        form = [
          Validator.init Name [Validator.isBlank],
          Validator.init Email [Validator.isEmail]
        ]
      }

    -- VIEWS

    view : Model -> Html Message
    view model =
      Validator.viewField Name model.form ["example-field-class"] [
        label [for "name"] [text "Name"],

        input [
          class "example-input-class",
          name "name",
          type_ "text",
          value <| Validator.fieldValue Name model.form,
          onInput <| FieldInput Name,
          onBlur <| FieldBlur Name
        ] []
      ]

    -- UPDATE

    update : Message -> Model -> (Model, Cmd Message)
    update message model =
      case message of
        FieldInput key value ->
          ({model | form = Validator.updateValue key value model.form}, Cmd.none)

        FieldBlur key ->
          ({model | form = Validator.validateField key model.form}, Cmd.none)

        Save ->
          let
            validatedModel = {model | form = Validator.validateForm model.form}
          in
            if Validator.isFormInvalid validatedModel.form then
              (validatedModel, Cmd.none)
            else
              (validatedModel, saveCommand validatedModel)

### Field Keys

The Form Validator design encourages one to use a union type for field keys so the compiler does
most of the work for you should a field name be renamed, removed, etc. That said, you can use any
type for the key but would recommend sticking with a union type if possible.

In the above *Overview*, the following field key type was used:

    type FieldKey
      = Name
      | Email

This is handy because you can add as many keys for as many fields of your form as necessary. You can
also use multiple union types for different forms on your page. Example:

    type ContactKey
      = Name
      | Email
      | Bio

    type AddressKey
      = Line1
      | Line2
      | Country
      | State
      | Zip

### Models

The Form Validator is flexible in that it can be used to represent a single form on a page:

    type alias Model =
      {
        form: Validator FieldKey
      }

...or multiple forms, depending on your need:

    type alias Model =
      {
        contactForm: Validator ContactKey,
        addressForm: Validator AddressKey
      }

### Records/Validators

Using the model examples above, you can define as many validators as necessary for fields in your
form(s). Example:

    initialModel : Model
    initialModel =
      {
        contactForm = [
          Validator.init Name [
            Validator.isBlank,
            Validator.isLengthGreaterThanEqualTo 5
          ],

          Validator.init Email [
            Validator.isBlank,
            Validator.isEmail
          ]
        ],
        addressForm: [
          Validator.init Line2 []
        ]
      }

The validator is initialized with a key and a list of validators. The list can be empty or contain
several validators per field. An empty validator list allows you to define a form field that has no
need of validation while also being able to manage that form field like any other form field. A form
field with multiple validators can result in a list of multiple errors (if any or all of them turn
out to be invalid).

Each initialized validator is a partial function which means you can define the validator with the
necessary requirements (if any). When the form or field is validated later, the `value` (or
`values`) of each field will be supplied to each function at runtime to compute if the field is
valid or invalid.

### Views

The Form Validator comes with a few functions for rendering results in your view. One of which is
the `viewField` function which renders a `div` around your input field. For example, let's look at
the following code:

    Validator.viewField Name model.form ["example-field-class"] [
      label [for "name"] [text "Name"],

      input [
        class "example-input-class",
        name "name",
        type_ "text",
        value <| Validator.fieldValue Name model.form,
        onInput <| FieldInput Name,
        onBlur <| FieldBlur Name
      ] []
    ]

The above will generate the following HTML output when a field fails validation:

    <div class="form_validator-field_error">
      <label>...</label>
      <input>

      <ul class="form_validator-errors">
        <li class="form_validator-error">...</li>
      </ul>
    </div>

This allows you to customize the look and feel of the following classes within the DOM:

- *form_validator-field_error:* The wrapper div for the invalid form field.
- *form_validator-errors:* The unordered list of field errors.
- *form_validator-error:* The individual field error list item.

### Updates

When updating your form, this'll usually occur via one following functions:

- *updateValue:* Allows you to update a field's value for a given key.
- *updateValues:* Similar to the above function but allows for multiple field values to be updated.
- *updateAndValidateValue:* Combines two steps into one, allowing you to update and validate a field
  at once.
- *updateAndValidateValues:* Similar to the above but for multiple field values.
- *validateForm:* Allows you to update and validate an entire form. Handy when preventing a form
  being saved due to detected errors.

### Customization

By default, the `FormValidator` module is provided to you as a single module you can import and use
within your application immediately. It's a wrapper module around the other modules found within the
`FormValidator` namespace/directory. This was done in order to give you a single module to import
and get started quickly.

Should you not want the default behavior provided by the `FormValidator` module, you can ignore
importing that module and import the individual modules as you see fit for your customization
needs. Here is a breakdown of the other modules available to you:

- *FormValidator/Models:* These are the models use to represent the form, field, values, and errors
  of a form.
- *FormValidator/Patterns:* These are the regular expression patterns used for some of the
  validators. These are available to you should you need them for different purposes.
- *FormValidator/Validator:* Contains all functions related to updating and validating forms and
  fields.
- *FormValidator/Validators:* Provides pre-defined validators for various checks. These might be all
  you need or your might want to craft your own validators as business requirements dictate.
- *FormValidator/Views:* These are functions which help you render form and form field errors.

By being able to import any module, you can better mix and match functionality for your specific
needs without having to compile code you don't need.

## Tests

To test, run:

    yarn test

## Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2018 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).
