enyo.kind({
	name: "boilerplateTest",
	kind: enyo.TestSuite,
	testPassingTest: function() {
		this.finish();
	},
	testFailingTest: function() {
		this.finish("Failure message");
	}
});
