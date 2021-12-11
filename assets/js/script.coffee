---
---

# HELPERS

{% include scripts/prevent.coffee %}        # Prevent default events for links and forms
{% include scripts/prefilter.coffee %}      # Prefilter for Ajax calls
{% include scripts/toc.coffee %}            # Move toc to sidebar
{% include scripts/apply_family.coffee %}   # Apply classes to parents/childrens
{% include scripts/slugify.coffee %}        # Function for string slug
{% include scripts/wait.coffee %}           # Wait and dewait functions

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
{% include scripts/github_api.coffee %}     # Perform GitHub API REST requests

# CUSTOM

{% include scripts/custom.coffee %}         # Custom file, empty by default
