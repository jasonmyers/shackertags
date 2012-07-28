
class st_shacker_tag
	constructor: (user_node) ->
		@user = $(user_node)
		@is_fullpost = @user.hasClass 'user'
		@node = $(window.shackertags.constants.HTML_ADD_TAG)
		@user.after @node
		@node.addClass @get_author_id()
		@process_existing_tags()
		@node.click @show_add_tag

	# Retrieve existing tags and process.
	process_existing_tags: =>
		chrome.storage.sync.get 'shackertags', @show_existing_tags

	# Show any existing tags near the username.
	show_existing_tags: (data) =>
		if data.shackertags is undefined then return
		author_id = @get_author_id()
		existing_tags = data.shackertags[author_id]
		if existing_tags is undefined then return
		_.each existing_tags, (tag) =>
			@add_tag_after @user, tag, author_id

	# Display a tag after the given node in the DOM.
	add_tag_after: (node, tag, author_id) =>
		tag_node = $("<span class=\"shackertag tagid_#{tag.id}\"><a href=\"#{tag.link}\">#{tag.tag}</a> <a href=\"#\" class=\"remove_shackertag\">&times;</a></span>")
		node.after tag_node
		$(tag_node.find('.remove_shackertag')).click =>
			@remove_tag author_id, tag
			false

	# Remove the tag for the given author, and stop displaying the tag.
	remove_tag: (author_id, tag, tag_node) =>
		$(".shackertag.tagid_#{tag.id}").remove()
		chrome.storage.sync.get 'shackertags', (data) =>
			existing_tags = data.shackertags[author_id]
			tag_to_remove = _.find existing_tags, (existing_tag) =>
				existing_tag.tag == tag.tag
			if tag_to_remove is undefined then return

			data.shackertags[author_id].splice(existing_tags.indexOf(tag_to_remove), 1)
			chrome.storage.sync.set {'shackertags': data.shackertags}

	# Get a permanent link to the post.
	get_post_link: =>
		if @is_fullpost
			fullpost = $(@node.parents('.fullpost')[0])
			postnumber = $(fullpost.find('.postnumber')[0])
			permalink = postnumber.children('a')[0]
			return permalink['href']
		@user.prev()[0]['href']

	# Get the identification number for the post author.
	get_author_id: =>
		if @is_fullpost
			fullpost = $(@node.parents('.fullpost')[0])
			classes = fullpost.attr('class').split(' ')
			author_class = _.find classes, (fullpost_class) ->
				fullpost_class.indexOf('fpauthor') >= 0
			return "author_#{author_class.split('_')[1]}"

		oneline = $(@node.parents('.oneline')[0])
		classes = oneline.attr('class').split(' ')
		author_class = _.find classes, (oneline_class) ->
			oneline_class.indexOf('olauthor') >= 0
		"author_#{author_class.split('_')[1]}"

	# Display the form used for adding new tags.
	show_add_tag: =>
		if @node.children('.div_add_tag').length > 0 then return
		new add_tag_form(@)
