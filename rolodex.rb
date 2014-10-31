class Rolodex   #Stores multiple contacts
  attr_accessor :contacts

  def initialize
    @contacts = []
    @id = 1000
  end

  def add_contact(contact)
    contact.id = @id  #We can do this because we added an attr_accessor to Contact
    @contacts << contact
    @id += 1
  end

  def find(contact_id)
    contacts.find {|contact| contact.id == contact_id }
  end

  def remove_contact(contact)
    @contacts.delete(contact)
  end
end