require 'spec_helper'

describe MessageMailer, :created do

  before do
    @message = create(:message)
    @recipient = create(:person)
  end

  it "delivers" do
    MessageMailer.created(@message.id, @recipient.id).deliver
    assert_equal true, ActionMailer::Base.deliveries.any?
  end

  it "has the correct recipient" do
    email = MessageMailer.created(@message.id, @recipient.id)
    assert_equal true, email.to.include?(@recipient.email)
  end

  it "has the correct reply_to address" do
    email = MessageMailer.created(@message.id, @recipient.id)
    assert_equal @message.conversation.mailbox.address.to_s,
      email.reply_to.first
  end

  it "has the correct reply_to display_name" do
    email = MessageMailer.created(@message.id, @recipient.id)
    expect(email[:reply_to].addrs.first.display_name.to_s).to(
      eq(@message.conversation.account.name)
    )
  end

  it "has the correct from address" do
    email = MessageMailer.created(@message.id, @recipient.id)
    assert_equal "notifications@helpful.io", email.from.first
  end

  it "has the correct from display_name" do
    email = MessageMailer.created(@message.id, @recipient.id)
    assert_equal @message.person.name,
      email[:from].addrs.first.display_name.to_s
  end
end
