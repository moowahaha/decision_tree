describe DecisionTree do

  it "should match our class with attributes" do
    candidates = []

    [
        ['ford', nil, nil, 15000],
        ['ford', 'focus', nil, 20000],
        ['ford', 'focus', 'automatic', 25000],
        ['posh', 'focus', 'automatic', 35000]
    ].each do |make, model, transmission, price|
      candidates << Car.new(make: make, model: model, transmission: transmission, price: price)
    end

    tree = DecisionTree.new(
        candidates: candidates,
        factors: %w{make transmission model}
    )

    tree.best_for(
        OpenStruct.new(make: 'ford', model: 'whatever', transmission: 'whatever')
    ).price.should == 15000

    tree.best_for(
        OpenStruct.new(make: 'ford', model: 'focus', transmission: 'whatever')
    ).price.should == 20000

    tree.best_for(
        OpenStruct.new(make: 'ford', model: 'focus', transmission: 'automatic')
    ).price.should == 25000

    tree.best_for(
        OpenStruct.new(make: 'posh', model: 'focus', transmission: 'automatic')
    ).price.should == 35000

    tree.best_for(
        OpenStruct.new(make: 'whatever', model: 'focus', transmission: 'automatic')
    ).should be_nil
 end

end