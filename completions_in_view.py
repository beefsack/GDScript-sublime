import sublime, sublime_plugin
import string

class PleasurazyAPICompletionsPackageEventListener(sublime_plugin.EventListener):

  def on_query_completions(self, view, prefix, locations):
    self.completions = []
    window = sublime.active_window()
    compDefault = [v.extract_completions(prefix) for v in window.views()]
    compDefault = [(item, item) for sublist in compDefault for item in sublist]
    compDefault = list(set(compDefault))
    return (compDefault)
