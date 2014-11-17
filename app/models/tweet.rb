class Tweet < ActiveRecord::Base
  attr_accessible :message
  belongs_to :user
   named_scope :active, :conditions => {:active => true}, :order => "created_at desc"
   named_scope :my_active, lambda { |user| {:conditions => ["user_id = ? and active = ?", user.id, true], :order => "created_at desc"} }
   default_scope :order => "id DESC"

   Tweet.find(:all, :limit => 2)
   Tweet.find(:all)
   Tweet.find(:first)
   Tweet.find(:last, :conditions => {:title => "test"})
   Tweet.first(:conditions => {:title => "test"})
   Tweet.all(:joins => :comments)
   Tweet.find_in_batches(:conditions => {:title => "test"}, :batch_size => 100) do |posts|
   end
   Tweet.find_in_batches(:conditions => {:title => "test"}) do |posts|
   end

   with_scope(:find => {:conditions => {:active => true}}) { Post.first }
   with_exclusive_scope(:find => {:limit =>1}) { Post.last }

   Tweet.count("age", :conditions => {:active => true})
   Tweet.average("orders_count", :conditions => {:active => true})
   Tweet.min("age", :conditions => {:active => true})
   Tweet.max("age", :conditions => {:active => true})
   Tweet.sum("orders_count", :conditions => {:active => true})

   self.errors.on(:email).present?

   self.errors.add_to_base("error message")

   self.save(false)

   Tweet.update_all({:title => "title"}, {:title => "test"})
   Tweet.update_all("title = \'title\'", "title = \'test\'")
   Tweet.update_all("title = \'title\'", ["title = ?", title])
   Tweet.update_all({:title => "title"}, {:title => "test"}, {:limit => 2})

   Tweet.delete_all("title = \'test\'")
   Tweet.delete_all(["title = ?", title])

   Tweet.destroy_all("title = \'test\'")
   Tweet.destroy_all(["title = ?", title])
end
