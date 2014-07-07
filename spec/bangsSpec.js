describe("Bangs", function() {
  var first, lists;
  jasmine.getFixtures().fixturesPath = 'base/spec/fixtures/';
  loadFixtures('bangs.html');
  lists = $('.list');
  first = lists.first();
  lists.bangs();
  return it("高さは130", function() {
    return expect(first.height()).toEqual(130);
  });
});
