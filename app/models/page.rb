class Page < ActiveRecord::Base

	belongs_to :subject
	has_many :sections
	has_and_belongs_to_many :editors, "class_name" => "AdminUser"

  acts_as_list :scope => :subject     # from gem installed 

  before_validation :add_default_permalink  #private
  after_save :touch_subject                 #private
  after_destroy :delete_related_sections    #private


  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
          # use presence_of with length_of to disallow spaces
  validates_uniqueness_of :permalink
          # for unique values by subject use ":scope => :subject_id"


	scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("pages.position ASC") }
  scope :newest_first, lambda { order("pages.created_at DESC") }
  scope :search, lambda {|query|
    where(["name LIKE ?", "%#{query}&" ])  
  }

  private

    def add_default_permalink
      if permalink.blank?
        self.permalink = "#{id}-#{name.parameterize}"
      end     
    end

    def touch_subject
      #touch is similar to:
      #subject.update_attribute(:updated_at, Time.now)
      subject.touch
    end

    def delete_related_sections
      self.sections.each do |section|
        # section.destroy  
      end
    end
          #    Uncomment section.destroy above if you want to destroy all sections -         #- associated with the deletion of this particular page
          #    Or perhaps instead of destroy, you would move them to another page.
end
