
class add_tag_form
	constructor: (parent) ->
		@parent = parent
		@node = $(window.shackertags.constants.HTML_FORM_ADD_TAG)
		@parent.node.append @node
		@bind_ui()

	bind_ui: =>
		# Find UI nodes
		@button_cancel = $(@node.find '.button_cancel')
		@button_add = $(@node.find '.button_add')
		@input_tag = $(@node.find '.input_tag_text')
		@input_link = $(@node.find '.input_tag_link')

		# Eat keydown (chatty uses this to move between selected posts)
		@input_tag.keydown (event) ->
			event.stopPropagation();
		@input_link.keydown (event) ->
			event.stopPropagation();

		# Bind events
		@button_add.click @save
		@button_cancel.click @close

		# Fill UI
		@input_link.val @parent.get_post_link()
		@input_tag.focus()

	# Save the new tag.
	save: =>
		chrome.storage.sync.get 'shackertags', @store_tag
		@close()

	# Store the tag and display it on the screen.
	store_tag: (data) =>
		author_id = @parent.get_author_id()

		# Create a new shackertags object if there isn't one.
		if data.shackertags is undefined
			tags = {}
		else
			tags = data.shackertags

		# Create a new collection of tags for the author if necessary, and
		# prevent adding the same tag twice.
		if tags[author_id] is undefined
			tags[author_id] = []
		else if _.any(tags[author_id], (tag) =>
				tag.tag == @input_tag.val())
			return

		tag = {
			id: window.shackertags.create_guid()
			tag: @input_tag.val()
			link: @input_link.val()
		}

		tags[author_id].push(tag)

		# Store the tags.
		chrome.storage.sync.set {'shackertags': tags}

		# Display the new tag.
		author_add_tag_nodes = $(".add_tag.#{@parent.get_author_id()}")
		_.each author_add_tag_nodes, (add_tag_node) =>
			@parent.add_tag_after $($(add_tag_node).prev()[0]), tag, author_id

	close: =>
		@node.remove()
		false
