describe "Bangs", ->

  # fixtureを呼び出し
  jasmine.getFixtures().fixturesPath = 'base/spec/fixtures/'
  loadFixtures 'bangs.html'

  lists = $ '.lists'
  first = lists.find('.list').first()

  lists.bangs({item:'.list'})


  it "高さは130", ->
    expect(first.height()).toEqual 130


