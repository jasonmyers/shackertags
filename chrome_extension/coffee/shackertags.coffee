$(document).ready ->

	window.shackertags = new shackertags
	_.each $('div.root'), (root_post) ->
		window.shackertags.root_posts.push(new st_root_post(root_post))

class shackertags
	constructor: ->
		@set_constants()
		@root_posts = []

		@observer = new WebKitMutationObserver(@mutated)
		@observer.observe $('div.threads')[0], {
			childList: true
			subtree: true
		}

	# Called when the DOM for a root post changes.
	mutated: (mutation_records, observer) =>
		_.each mutation_records, (mutation_record) =>
			if mutation_record.addedNodes is undefined or mutation_record.addedNodes.length is 0 then return
			_.each mutation_record.addedNodes, (added_node) =>
				node = $(added_node)
				if node.hasClass('root')
					fullpost = $(node.find('.fullpost'))
					window.shackertags.root_posts.push(new st_root_post(node))
				if node.hasClass('fullpost')
					window.shackertags.root_posts.push(new st_root_post(node))

	# Generate a unique identifier.
	create_guid: =>
		'xxxxxxxx_xxxx_4xxx_yxxx_xxxxxxxxxxxx'.replace(/[xy]/g, (c) =>
    		r = Math.random()*16|0
    		v = if c == 'x' then r else (r&0x3|0x8)
    		v.toString(16))

	set_constants: =>
		@constants = {}		
		
		# Tag icon that will display the add tag form when clicked.
		@constants.HTML_ADD_TAG = """
		<span class="add_tag"></span>
		"""

		# Form for adding a new tag.
		@constants.HTML_FORM_ADD_TAG = """
		<div class="div_add_tag">
			<form class="form_add_tag">
				<fieldset>
					<legend>Add a tag</legend>
					<ol>
						<li>
							<label for="input_tag_text">Tag</label>
							<input class="input_tag_text" required name="input_tag_text" type="text" placeholder="Tag"/>
						</li>
						<li>
							<label for="input_tag_link">Link</label>
							<input class="input_tag_link" name="input_tag_link" type="text" placeholder="http://foo.bar/"/>
						</li>
					</ol>
				</fieldset>
				<fieldset class="fieldset_actions">
					<legend>Actions</legend>
					<ol>
						<li><button class="button_add">Add</button></li>
						<li><button class="button_cancel">Cancel</button></li>
					</ol>
				</fieldset>
			</form>
		</div>
		"""
