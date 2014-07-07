describe "Bangs", ->

  # fixtureを呼び出し
  jasmine.getFixtures().fixturesPath = 'base/spec/fixtures/'
  loadFixtures 'bangs.html'

  lists = $ '.list'
  first = lists.first()

  lists.bangs()


  it "高さは130", ->
    expect(first.height()).toEqual 130


