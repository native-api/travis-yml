describe Travis::Yml, 'addon: apt' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given a str' do
    yaml %(
      addons:
        apt: str
    )
    it { should serialize_to addons: { apt: { packages: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs' do
    yaml %(
      addons:
        apt:
        - str
    )
    it { should serialize_to addons: { apt: { packages: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'packages' do
    describe 'given a str' do
      yaml %(
        addons:
          apt:
            packages: str
      )
      it { should serialize_to addons: { apt: { packages: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      yaml %(
        addons:
          apt:
            packages:
            - str
      )
      it { should serialize_to addons: { apt: { packages: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'alias package' do
      yaml %(
        addons:
          apt:
            package: str
      )
      it { should serialize_to addons: { apt: { packages: ['str'] } } }
      it { should have_msg [:info, :'addons.apt', :alias, alias: :package, key: :packages] }
    end

    describe 'given a nested array (happens when using aliases)' do
      yaml %(
        addons:
          apt:
            packages:
            -
              - one
              - two
      )
      it { should serialize_to addons: { apt: { packages: ['one', 'two'] } } }
      it { should have_msg [:warn, :'addons.apt.packages', :invalid_seq, value: ['one', 'two']] }
    end

    describe 'given wild nested arrays (using yml aliases)' do
      yaml %(
        addons:
          apt:
            packages:
              -
                -
                  -
                    - 'a'
                    - 'b'
                  - 'c'
                  - 'd'
                - 'e'
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'addons.apt.packages', :invalid_type, expected: :str, actual: :seq, value: [[['a', 'b'], 'c', 'd'], 'e']] }
    end
  end

  describe 'sources' do
    describe 'given a str' do
      yaml %(
        addons:
          apt:
            sources: str
      )
      it { should serialize_to addons: { apt: { sources: [name: 'str'] } } }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      yaml %(
        addons:
          apt:
            sources:
            - str
      )
      it { should serialize_to addons: { apt: { sources: [name: 'str'] } } }
      it { should_not have_msg }
    end

    describe 'alias source' do
      yaml %(
        addons:
          apt:
            source: str
      )
      it { should serialize_to addons: { apt: { sources: [name: 'str'] } } }
      it { should have_msg [:info, :'addons.apt', :alias, alias: :source, key: :sources] }
    end
  end

  describe 'dist' do
    yaml %(
      addons:
        apt:
          dist: dist
    )
    it { should serialize_to addons: { apt: { dist: 'dist' } } }
    it { should_not have_msg }
  end
end