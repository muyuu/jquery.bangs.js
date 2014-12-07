describe("Bangs", function() {
  var first, lists;
  jasmine.getFixtures().fixturesPath = 'base/spec/fixtures/';
  loadFixtures('bangs.html');
  lists = $('.lists');
  first = lists.find('.list').first();
  lists.bangs({
    item: '.list'
  });
  return it("高さは130", function() {
    return expect(first.height()).toEqual(130);
  });
});
