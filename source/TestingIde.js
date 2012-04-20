enyo.kind({
	name: "bb.TestingIde",
	kind: "enyo.FittableRows",
	fit: true,
	classes: "testing-ide onyx enyo-unselectable",
	components: [
		{kind: "onyx.Toolbar", components: [
			/* TODO: Create a control that allows you to have ellipsis
			 * collapsable text on the left and other stuff on the right
			 * Use the google dynamic blog templates as a reference.
			 */
			{content: "Test Development Environment"},
			{kind: "onyx.Button", content: "Feedback", ontap: "showPopup", popup: "feedbackPopup"},
			{kind: "onyx.Button", content: "Help", ontap: "showPopup", popup: "helpPopup"}
		]},
		/* TODO: Create some useful kind of help application that will be useful
		 * for non-developers to use
		 */
		{name: "helpPopup", kind: "onyx.Popup", centered: true, floating: true, modal: true, content: "Help is on it's way.  We just need to write it. ☺"},
		/* TODO: Use the JIRA API to create issues for the test development
		 * environment.  This should really be it's own project in OnDemand.
		 * Present a popup with the various issue types as buttons:
		 *  - bug
		 *  - improvement
		 *  - new feature
		 * Would be easy to create the issues automatically from within the
		 * web application.
		 */
		{name: "feedbackPopup", kind: "onyx.Popup", centered: true, floating: true, modal: true, content: "Feedback will be implemented when we can. ☺"},
		{kind: "enyo.FittableColumns", components: [
			{style: "width:50%", classes: "box", components: [
				{kind: "onyx.Groupbox", components: [
					{kind: "onyx.GroupboxHeader", content: "Settings"},
					{content: "TODO", classes: "onyx-groupbox-item"},
					{content: "TODO", classes: "onyx-groupbox-item"}
				]},
			]},
			{fit: true, classes: "box", components: [
				{kind: "onyx.Groupbox", style: "height:100%", components: [
					{kind: "onyx.GroupboxHeader", content: "Test Modules"},
					{content: "TODO", classes: "onyx-groupbox-item"},
					{content: "TODO", classes: "onyx-groupbox-item"}
				]},
			]}
		]},
		{kind: "enyo.FittableColumns", fit: true, components: [
			{kind: "enyo.FittableRows", style: "width:65%", classes: "box", components: [
				/* TODO: We should make the following into a control.  It is a groupbox
				 * that has one item that expands to the correct height of the
				 * container.  This might require the box-sizing CSS.  It is
				 * is also used below for the results
				 */
				/* TODO: Add onyx.GroupboxItem */
				{name: "testCodeGroupBox", kind: "onyx.Groupbox", fit: true, components: [
					{kind: "enyo.FittableRows", style: "height: 100%;", components: [
						{kind: "onyx.GroupboxHeader", content: "Test Code"},
						{classes: "onyx-groupbox-item", fit: true, components: [
							{kind: "onyx.InputDecorator", style: "-moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box;width:100%;height:100%", components: [
								{name: "testCodeTextArea", kind: "onyx.TextArea", defaultFocus: true, style: "-moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box;width:100%;height:100%", placeholder: "You can write tests here and run them right in the browser!"}
							]}
						]},
						{classes: "onyx-groupbox-item", components: [
							{name: "testButton", kind: "onyx.Button", content: "Run", style: "width:100%", classes: "onyx-affirmative", ontap: "test"}
						]},
					]}
				]}
			]},
			{kind: "enyo.FittableRows", fit: true, classes: "box", components: [
				{kind: "onyx.Groupbox", fit: true, components: [
					{kind: "enyo.FittableRows", fit: true, style: "height: 100%;", components: [
						{kind: "onyx.GroupboxHeader", content: "Results"},
						{name: "resultsScroller", kind: "enyo.Scroller", horizontal: "hidden", classes: "onyx-groupbox-item", fit: true, components: [
							{content: "No results yet, try running a test module!"}
						]}
					]}
				]}
			]}
		]},
	],
	testRunner: new enyo.TestRunner(),
	test: function(inSender) {
		enyo.log("Running Code");
		this.$.testCodeTextArea.node.disabled = false;
		this.$.testButton.eventNode.disabled = false;
		eval(this.$.testCodeTextArea.node.value);
		this.testRunner.renderInto(this.$.resultsScroller.eventNode);
	},
	showPopup: function(inSender) {
		var p = this.$[inSender.popup];
		if (p) {
			p.show();
		} else {
			// TODO: Change this to the feedback method when available
			alert("Failed to find the '" + inSender.popup + "' popup for the '" + inSender.name + "' control.\n\nPlease use the feedback button to notify the developers");
		}
	}
})
