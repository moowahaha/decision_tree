describe DecisionTree do

  before do
    candidates = []

    [
        ['ford', nil, nil, 15000],
        ['ford', 'mondeo', nil, 30000],
        ['ford', 'focus', nil, 20000],
        ['ford', 'focus', 'automatic', 25000],
        ['posh', 'focus', 'automatic', 35000]
    ].each do |make, model, transmission, price|
      candidates << Car.new(make: make, model: model, transmission: transmission, price: price)
    end

    @tree = DecisionTree.new(
        candidates: candidates,
        factors: %w{make transmission model}
    )
  end

  it "should match the most general only using the make" do
    @tree.best_for(
        OpenStruct.new(make: 'ford', model: 'whatever', transmission: 'whatever')
    ).first.price.should == 15000

    @tree.best_for(
        OpenStruct.new(make: 'posh', model: 'focus', transmission: 'automatic')
    ).first.price.should == 35000
  end

  it "should match the most general only using the make a model" do
    @tree.best_for(
        OpenStruct.new(make: 'ford', model: 'focus', transmission: 'whatever')
    ).first.price.should == 20000

    @tree.best_for(
        OpenStruct.new(make: 'ford', model: 'mondeo', transmission: 'whatever')
    ).first.price.should == 30000
  end

  it "should match the most general make, model and transmission" do
    @tree.best_for(
        OpenStruct.new(make: 'ford', model: 'focus', transmission: 'automatic')
    ).first.price.should == 25000
  end

  it "should not match if the make is unset" do
    @tree.best_for(
        OpenStruct.new(make: 'whatever', model: 'focus', transmission: 'automatic')
    ).first.should be_nil
  end

end