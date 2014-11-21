class CompletionsInViewEventListener(sublime_plugin.EventListener):
	def on_query_completions(self, view, prefix, locations):
		if view.match_selector(locations[0], "source.gdscript"):
			compDefault = [view.extract_completions(prefix)]
			compDefault = [(item, item) for sublist in compDefault for item in sublist if len(item) > 3]
			return (list(set(compDefault)))
		else 
			return []