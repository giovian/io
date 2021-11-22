slugify = (text) -> 
  return text.toString().toLowerCase().trim()
  .replace(/[^\w\s-]/g, '')
  .replace(/[\s_-]+/g, '_')
  .replace(/^-+|-+$/g, '')