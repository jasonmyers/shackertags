Overview
========
Adds RES-like tagging to the chatty. 

Install
-------
Install via the [Chrome Web Store](https://chrome.google.com/webstore/detail/gedoafpenbkphidiebbejlfajofogghh).
Download the [Safari extension](https://github.com/downloads/yakz/shackertags/shackertags.safariextz). Double-click the file to install.

Features
--------
- Add tag text and an associated link to a user from any post.
- Displays tags next to the post author for every post.
- Handles root post refresh (adds tag functionality to dynamically loaded posts).
- Delete tags with a handy 'x'.
- Click tag text to go to the associated link.
- Attempts to fit into the style of the site.
- Tags are stored in the 'sync' version of local storage, so they should carry over to all of your Chrome installations.

Requirements
------------

Chrome
	
> I'm using DOM observers which hit the stable branch at 18, I think. So it'll only work with that version or above. I'm not actually sure if it will work with anything less than 21, though, because that's all I've tested it with.

Safari

> I've only tested it with Safari 6.

Notes
-----
I've barely done any work on this, just enough to get the functionality I wanted. There are parts that could be heavily optimized, and the object hierarchy is pretty half-assed. And, I've barely tested it. Don't expect much. Feel free to log issues, or send pull requests if you'd rather just fix it.

The current Safari extension is just a hack of the javascript output from the coffee-script compiler. A proper version with a single code base may follow.

Future
------
I'm planning to make a strictly opt-in "public" tags feature, that will allow you to see tags other people have added (sharing a tag will always demand an explicit opt-in). Filtering and some kind of voting process for removing hateful tags, and possibly a banning system for abusive users will be needed. No schedule on this for now.