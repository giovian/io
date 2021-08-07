storage =
  key: "{{ site.github.repository_nwo }}"
  get: (key) -> if key then storage.get_object()[key] else storage.get_object()
  get_object: () -> JSON.parse atob localStorage.getItem(storage.key) || "e30="
  set_object: (obj) -> localStorage.setItem(storage.key, btoa JSON.stringify obj)
  push: (key, element) -> storage.set key, (storage.get(key) || []).concat [element]
  concat: (key, array) -> storage.set key, (storage.get(key) || []).concat array
  assign: (key, object) -> storage.set key, Object.assign(storage.get(key) || {}, object)
  set: (key, value) ->
    if key and value
      obj = storage.get_object()
      obj[key] = value
      storage.set_object obj
    return storage
  clear: (key) ->
    if key
      obj = storage.get_object()
      delete obj[key]
      storage.set_object obj
    else
      localStorage.removeItem(storage.key)
    return storage
  console: ->
    console.group storage.key
    console.log localStorage.getItem storage.key
    console.log storage.get()
    console.groupEnd()
    return
{%- capture api -%}
## Storage

Hashed localStorage system with key `owner/repository`.

**GET**

```cs
// Return whole object { ... }
storage.get()
// Return value (can be number, string, array, object)
storage.get("key")
// Return object's property
storage.get("object")["property"]
// Return index element of array
storage.get("array")[index]
```
**SET**
```cs
// Store { key: value } (can be number, string, array, object)
storage.set("key", value)
```
**PUSH**
```cs
// Push element to array
storage.push("array", element)
```
**CONCAT**
```cs
// Store array's merge
storage.concat("array", [array])
```
**ASSIGN**
```cs
// Store merged objects
storage.assign("object", object)
```
**CLEAR**
```cs
// Return storage, remove localStorage key
storage.clear()
// Return storage, remove { key: value, ... }
storage.clear("key")
```
**CONSOLE**
```cs
// Show storage objects in web console
storage.console()
```
{%- endcapture -%}