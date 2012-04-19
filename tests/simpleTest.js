enyo.kind({
	name: "simpleTest",
	kind: enyo.TestSuite,
	testIntegersAreIntegers: function() {
		this.finish(isNaN(Number(1)));
	}
});
