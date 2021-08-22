---
order: 5
---

# Forms
{:.no_toc}
- toc
{:toc}

> <https://json-schema.org/>

Data structure are defined with JSON Schema and managed with FORMS, depending on file extension can be stored either in JSON or YML/YAML format.

Data resides in [`_data`]({% include widgets/github_url.html path="_data" %}) folder, available for Jekyll with `{% raw %}{{ site.data }}{% endraw %}`{:.language-liquid}.

## Keywords

**Custom keywords**

- **Meta-data**: don’t affect validation e.g. `units`
- **non-impairing**: don’t apply other schemas and don’t modify existing keywords e.g. `isEven`, need a custom validation
- **impairing**: apply other schemas or modify existing keywords e.g. `requiredProperties`

**Annotations**

Describe a schema
- `title`: string
- `description`: string
- `readOnly`: boolean to exclude from writing
- `writeOnly`: boolean, hidden to user

**Format**

`format` is an annotation keyword for semantic information.

## Type

Primitive types of an instance are `string, number, integer, array, object, boolean, null` and can be defined in this ways:

- `type`: may either be a string or a unique strings array
- `enum`: restrict the value to a fixed set (array), a SELECT input will be used  
  In the `array` case, will have the `multiple` attribute
- `const`: restrict the value to a single value (like enum with one item)

Every instance can have a `default` pre-filled value (must be valid)

### String

**Validation keywords**
- `minLength` and `maxLength`: non-negative integers
- `pattern`: ECMA-262 regular expression  
  `^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$` North American telephone number with optional area code e.g. `(888)555-1212`

**Format attributes**

- `date-time`: Date and time together, for example,` 2018-11-13T20:20:39+00:00`.
- `time`: New in draft 7 Time, for example, `20:20:39+00:00`
- `date`: New in draft 7 Date, for example, `2018-11-13`.
- `duration`: `P{n}Y{n}M{n}W{n}DT{n}H{n}M{n}S` New in draft 2019-09 A duration as defined by the ISO 8601 ABNF for “duration”.  
  For example, P3D expresses a duration of 3 days.  
  `P3Y6M4DT12H30M5S` Represents a duration of three years, six months, four days, twelve hours, thirty minutes, and five seconds.
- `email`: Internet email address, see RFC 5322, section 3.4.1.
- `uri`: universal resource identifier

**Custom formats attributes**
- `textarea`: use TEXTAREA for input
- `color`: color picker with hex format `#rrggbb`

**Custom keywords**
- `tooltip`: text visualized on mousehover
- `placeholder`: semi-opaque text rendered in the empty input field
- `label`: brief description displayed in the form

### Numbers

- `integer` (negative and zero fractional are ok)
- `number`

**Validation keywords**
- `multipleOf`
- `minimum` and `maximum`: inclusive limits (numbers)
- `exclusiveMinimum` and `exclusiveMaximum`: exclusive limits (numbers)

**Custom formats attributes**
- `range`: use a INPUT `type="range"`, need `minimum` and `maximum` and optionally `multipleOf`  
  current value will use OUTPUT element

**Custom keywords**
- `tooltip`: text visualized on mousehover (string)
- `placeholder`: semi-opaque text rendered in the empty input field (string)
- `label`: brief description displayed in the form (string)
- `units`: annotation string

### Object

They map `keys` to `values`, each of these pairs is conventionally referred to as a _property_ and defined using the `properties` keywords.

- In JSON, the “keys” must always be strings.
- `required`: is unique strings array (the required properties) and is defined under an object property (scope).
- `dependentRequired`: requires that certain properties must be present if a given property is present.  
  ```json
  "dependentRequired": {
    "credit_card": ["billing_address"],
    "billing_address": ["credit_card"]
  }
  ```
- Conditional property definition:  
  ```json
  "if": {
    "properties": { "country": { "const": "United States of America" } }
  },
  "then": {
    "properties": { "postal_code": { "pattern": "[0-9]{5}(-[0-9]{4})?" } }
  },
  "else": {
    "properties": { "postal_code": { "pattern": "[A-Z][0-9][A-Z] [0-9][A-Z][0-9]" } }
  }
  ```

### Array

- `items: {type: number}`: List validation (is a schema)
- `items: [{type: string}, {type: number}]`: Tuple validation (are different schemas)
- `minItems` and `maxItems`: non-negative integers
- `uniqueItems`: boolean

### Boolean

`true` or `false`

## Reusing

Schemas have an absolute URI `{{ site.github.repository_url }}/_data/` and a JSON pointer (slash-separated path to traverse the properties).

A schema in the file `_data/schema.yml` will have `$id: {{ site.github.repository_url }}/_data/schema`

- `$ref` URI reference a schema or a definition (`$def` is an object with properties).  
  ```json
  {
    "$defs": {
      "point": {
        "type": "object",
        "properties": {
          "x": { "type": "number" },
          "y": { "type": "number" }
        },
        "additionalProperties": false,
        "required": [ "x", "y" ]
      }
    },
    "type": "array",
    "items": { "$ref": "#/$defs/point" },
  }
  ```

- `#` is used for recursive referencing.  
  ```json
  {
    "type": "object",
    "properties": {
      "name": { "type": "string" },
      "children": {
        "type": "array",
        "items": { "$ref": "#" }
      }
    }
  }
  ```

## Special keywords

- `watch`: array of properties to watch, current property update when properties change
- `pool`: use with `watch`, it is the numeric limit for the sum of watched properties (also numbers)
- `eval`: math formula with string interpolation  
  ```js
  function parse(str) {
    return Function(`'use strict'; return (${str})`)()
  }
  parse("1+2+3"); 
  ```

## Storing data

**Authentication and saving path**

To save a data file e.g. `path/file.yml`, a login with writing permission is required.
```js
storage.get("login.role") = "admin"
```
{:.minimal}

When done in a original repository (not a fork), the file will be directy committed in `/_data/path/file.yml`.
```js
storage.get("repository.fork") = false
```
{:.minimal}

When done in a forked repository, the file will be saved in `/_data/users/<username>/path/file.yml` and a Pull request will be performed.
```js
storage.get("repository.fork") = true
```
{:.minimal}

**Working on schemas**

- Schema path

**Working on instances**

- Schema and instance path

<form class="prevent-default">
  <h3>Form</h3>
  <p>Description</p>
  <div class="grid">
    <div>
      <div data-type="text">
        <label for="string">Title text</label>
        <input type="text" name="string" placeholder="String">
        <span>Description</span>
      </div>
      <div data-type="textarea">
        <label for="textarea">Title textarea</label>
        <textarea id="textarea" name="textarea" placeholder="1"></textarea>
        <span>Description</span>
      </div>
      <div data-type="number">
        <label for="number">Title number</label>
        <input type="number" name="number" placeholder="1">
        <span>Description</span>
      </div>
      <div data-type="range">
        <label for="range">Title Range</label>
        <input type="range" name="range"><output name="range_output" for="range">12</output>
        <span>Description</span>
      </div>
    </div>
    <div>
      <div data-type="select">
        <label for="select">Selector</label>
        <select name="select">
          <option value="1">Option 1</option>
          <option value="2">Option 2</option>
        </select>
        <span>Notes selectors</span>
      </div>
      <div data-type="select multiple">
        <label for="select">Selector multiple</label>
        <select name="select" multiple>
          <option value="1">Option 1</option>
          <option value="2">Option 2</option>
          <option value="3">Option 3</option>
          <option value="4">Option 4</option>
          <option value="5">Option 5</option>
          <option value="6">Option 6</option>
        </select>
        <span>Notes multiple selectors</span>
      </div>
      <div data-type="color">
        <label for="string[color]">Color picker</label>
        <input type="color" id="string[color]" name="string[color]" aria-label="color" value="#151ce6" />
        <span>Notes colors</span>
      </div>
    </div>
  </div>
  <div data-type="button">
    <input type="submit" value="Save">
    <input type="reset">
    <input type="button" value="Button">
  </div>
</form>