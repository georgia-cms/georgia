require 'spec_helper'

describe Georgia::Review do

  it { should belong_to :meta_page }

  it_behaves_like 'a storable model'

end