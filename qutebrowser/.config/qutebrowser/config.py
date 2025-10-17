# loading autoconfig.yml
config.load_autoconfig()
# minimalism
c.colors.webpage.darkmode.enabled = True
c.scrolling.bar = "never"
c.statusbar.show = "never"
c.tabs.show = "never"
c.content.private_browsing = True
c.zoom.default = "75%"
c.url.default_page = "qute://bookmarks/"
c.url.start_pages = "qute://bookmarks/"
# bindings
config.bind('<Ctrl+/>', 'hint links spawn --detach mpv {hint-url}')
