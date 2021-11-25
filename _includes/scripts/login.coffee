login =
  login_link: $ 'a.login-link'
  logout_link: $ 'a.logout-link'
  storage: () -> storage.get('login') || {}
  text: -> "Logged as #{login.storage()['user']} (#{login.storage()['role']})"

login.login_link.on 'click', (e) ->
  e.preventDefault()
  token = prompt "Paste a GitHub personal token"
  if !token then return else wait()
  storage.set 'login', {'token': token}
  notification 'Verifying'
  auth = $.get '{{ site.github.api_url }}/user'
  auth.done (data, status) ->
    storage.assign 'login', {'user': data.login, 'logged': new Date()}
    login.permissions()
    return
  auth.fail (request, status, error) -> login.setLogin()
  true

login.permissions = ->
  notification 'Checking permissions'
  repo = $.get '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}'
  repo.done (data, status) ->
    storage.assign('login', {
      'role': (if data.permissions.admin then 'admin' else 'guest')
    }).assign 'repository', {
      'fork': data.fork
      'parent': data.parent?.full_name?
    }
    return
  repo.always () ->
    login.setLogout()
    notification login.text(), 'green'
    return
  true

login.logout_link.on 'click', (e) ->
  e.preventDefault()
  login.setLogin()
  notification 'Logged out'
  true

login.setLogin = ->
  $('html').removeClass 'role-admin role-guest logged'
  storage.clear('login').clear 'repository'
  apply_family()
  dewait()
  true

login.setLogout = ->
  $('html').addClass "role-#{login.storage()['role']} logged"
  login.logout_link.attr 'title', login.text()
  storage.assign 'repository', {'sha': '{{ site.github.build_revision }}'}
  apply_family()
  dewait()
  true

# Immediately Invoked Function Expressions
login.init = (-> if login.storage()["token"] then login.setLogout() else login.setLogin())()
{%- capture api -%}
## Login

Manage GitHub login and logout using `localStorage` and the relative links in the login widget.  

When logged, HTML will have a `.logged`{:.language-sass} class and the role classes `.role-admin`{:.language-sass} or `.role-guest`{:.language-sass} depending on write permissions of the logged user.
{%- endcapture -%}