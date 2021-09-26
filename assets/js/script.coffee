---
---

# HELPERS

{% include scripts/prevent.coffee %}        # Prevent default events for links and forms
{% include scripts/ajax.coffee %}           # Prefilter for Ajax calls
{% include scripts/toc.coffee %}            # Move toc to sidebar
{% include scripts/apply_family.coffee %}   # Apply classes to parents/childrens
{% include scripts/binary.coffee %}         # Unicode strings to binary data (1 byte)

# WIDGETS

{% include scripts/datetime.coffee %}       # Use apply_family
{% include scripts/notification.coffee %}   # Use datetime
{% include scripts/storage.coffee %}        # Hashed storage system for localStorage
{% include scripts/login.coffee %}          # Use notification, apply_family, storage
{% include scripts/details.coffee %}        # Use storage

# FUNCTIONS

{% include scripts/focus.coffee %}          # Check website browser tab is focused
{% include scripts/inview.coffee %}         # In view Observer
{% include scripts/update.coffee %}         # Check website is updated with repository
{% include scripts/form.coffee %}           # Form engine

# CUSTOM

{% include scripts/custom.coffee %}         # Custom file, empty by default
