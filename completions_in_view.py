import sublime, sublime_plugin
import string

class CompletionsInViewEventListener(sublime_plugin.EventListener):

  def on_query_completions(self, view, prefix, locations):
    self.completions = []
    window = sublime.active_window()
    for v in window.views():
    	arr = v.extract_completions(prefix)
    	for com in arr:
    		if not com in self.completions:
    			self.completions.append(com) 

    self.completions = [self.completions]
    self.completions = [(item, item) for sublist in self.completions for item in sublist]
    self.completions = list(set(self.completions))
    return (self.completions)
