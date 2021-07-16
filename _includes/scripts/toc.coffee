if $('#markdown-toc').length is 1 and $('#widget-toc').length is 1
  # Move `toc` to sidebar
  $('#markdown-toc').detach().appendTo '#widget-toc'
else
  # Remove `<details id="sidebar-toc">` from the sidebar
  $('#widget-toc').remove()