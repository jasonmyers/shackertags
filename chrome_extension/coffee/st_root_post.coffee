
class st_root_post
	constructor: (root_node) ->
		@wrapped_root_node = $(root_node)
		@tags = []
		@add_tags()
		
	# Add shacker tags to the DOM for each user node.
	add_tags: =>
		user_nodes = @wrapped_root_node.find '.user, .oneline_user'
		_.each user_nodes, (user_node) =>
			@tags.push new st_shacker_tag(user_node)