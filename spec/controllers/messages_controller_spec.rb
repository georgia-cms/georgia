require 'spec_helper'

describe MessagesController, focus: true do

  before :each do
    request = ActionController::TestRequest.new(
      referrer: 'http://localhost:3000/',
      remote_ip: '192.168.1.100',
      user_agent: 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0; EIE10;FRCAMSE)'
    )
    SpamWorker.stub(:perform_async).and_return(true)
  end

  it "creates a Georgia::Message" do
    post(:create, message: {name: "John", phone: '123-456-7890', subject: 'Testing', message: "It's a beautiful day." }, format: 'js')
    expect(assigns(:message)).to be_a(Georgia::Message)
    expect(response).to be_successful
    expect(response).to render_template(:create)
  end

  it "avoids UTF-8 Invalid Byte Sequences" do
    post(:create, message: {
      name: "MCM ¥ê¥å¥Ã¥¯ °×\255".force_encoding('UTF-8'),
      email: "uyiohttu*@gmail.com\255".force_encoding('UTF-8'),
      phone: "http://www.bluedogglass.com.au/home-gallery/mcmofficial.html\255".force_encoding('UTF-8'),
      subject: "MCM ¥ê¥å¥Ã¥¯ °×\255".force_encoding('UTF-8'),
      message: "A great deal has occured in the world of and also carbon finance and pollution levels exchanging due to the fact most people final published relating to this subject, thus i felt this really is good time to provide a quick upgrade. Any. The planet Standard bank As well as Finance Component lately produced its State and Trends of the As well as Market place Two thousand and seven (Document document), any intermittent assessment of the degree and properties of the world-wide promote for carbon dioxide pollution levels..\n <a href=\"http://www.bluedogglass.com.au/home-gallery/mcmofficial.html\" title=\"MCM ¥ê¥å¥Ã¥¯ °×\">MCM ¥ê¥å¥Ã¥¯ °×</a>\255".force_encoding('UTF-8')},
      format: 'js',
      utf8: "?")
    expect(assigns(:message)).to be_a(Georgia::Message)
    expect(response).to be_successful
    expect(response).to render_template(:create)
  end

  # it "renders html format"

end